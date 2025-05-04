using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using iText.Kernel.Pdf;
using iText.Kernel.Pdf.Canvas.Draw;
using iText.Layout;
using iText.Layout.Borders;
using iText.Layout.Element;
using iText.Layout.Properties;

namespace Pets_Heaven_
{
    public partial class Cart : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["PetsHeavenConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
                Response.Redirect("Login.aspx");

            if (!IsPostBack)
            {
                LoadUserInfo();
                LoadCartItems();
            }
        }

        private void LoadUserInfo()
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlCommand cmd = new SqlCommand("SELECT FullName, Email, Address FROM Users WHERE UserID = @UserID", con);
                cmd.Parameters.AddWithValue("@UserID", userId);
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    txtName.Text = reader["FullName"].ToString();
                    txtEmail.Text = reader["Email"].ToString();
                    txtAddress.Text = reader["Address"].ToString();
                }
            }
        }

        private DataTable LoadCartItems()
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            DataTable dt = new DataTable();

            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlCommand cmd = new SqlCommand(@"SELECT C.CartID, P.ProductName, P.Price, C.Quantity 
                                                  FROM AddToCart C 
                                                  INNER JOIN Products P ON C.ProductID = P.ProductID 
                                                  WHERE C.UserID = @UserID", con);
                cmd.Parameters.AddWithValue("@UserID", userId);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                gvCart.DataSource = dt;
                gvCart.DataBind();
            }

            decimal total = 0;
            foreach (DataRow row in dt.Rows)
            {
                total += Convert.ToDecimal(row["Price"]) * Convert.ToInt32(row["Quantity"]);
            }
            lblTotal.Text = "Total: ₹" + total.ToString("N2");

            return dt;
        }

        protected void btnUpdateAddress_Click(object sender, EventArgs e)
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlCommand cmd = new SqlCommand("UPDATE Users SET Address = @Address WHERE UserID = @UserID", con);
                cmd.Parameters.AddWithValue("@Address", txtAddress.Text.Trim());
                cmd.Parameters.AddWithValue("@UserID", userId);
                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        protected void gvCart_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            int cartId = Convert.ToInt32(e.CommandArgument);
            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();

                if (e.CommandName == "RemoveItem") // ✅ Fixed here
                {
                    SqlCommand delCmd = new SqlCommand("DELETE FROM AddToCart WHERE CartID = @CartID", con);
                    delCmd.Parameters.AddWithValue("@CartID", cartId);
                    delCmd.ExecuteNonQuery();
                }
                else
                {
                    SqlCommand getCmd = new SqlCommand("SELECT Quantity FROM AddToCart WHERE CartID = @CartID", con);
                    getCmd.Parameters.AddWithValue("@CartID", cartId);
                    int qty = Convert.ToInt32(getCmd.ExecuteScalar());

                    if (e.CommandName == "IncreaseQty") qty++;
                    else if (e.CommandName == "DecreaseQty" && qty > 1) qty--;

                    SqlCommand updateCmd = new SqlCommand("UPDATE AddToCart SET Quantity = @Qty WHERE CartID = @CartID", con);
                    updateCmd.Parameters.AddWithValue("@Qty", qty);
                    updateCmd.Parameters.AddWithValue("@CartID", cartId);
                    updateCmd.ExecuteNonQuery();
                }
            }

            LoadCartItems();
        }


        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            string name = txtName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string address = txtAddress.Text.Trim();
            string paymentMethod = ddlPaymentMethod.SelectedValue;

            DataTable cartItems = LoadCartItems();
            if (cartItems.Rows.Count == 0)
            {
                Response.Write("<script>alert('Your cart is empty.');</script>");
                return;
            }

            decimal total = 0;
            foreach (DataRow row in cartItems.Rows)
                total += Convert.ToDecimal(row["Price"]) * Convert.ToInt32(row["Quantity"]);

            // Create and save invoice PDF
            string invoiceFile = name.Replace(" ", "_") + "_Invoice_" + DateTime.Now.Ticks + ".pdf";
            string invoicePath = Server.MapPath("~/Invoices/" + invoiceFile);
            Directory.CreateDirectory(Server.MapPath("~/Invoices/"));
            GeneratePdfInvoice(invoicePath, name, email, address, cartItems, total);

            // Insert order
            int orderId;
            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(@"INSERT INTO Orders (UserID, TotalAmount, PaymentMethod, DeliveryAddress, InvoicePath)
                                                  VALUES (@UserID, @Total, @Method, @Address, @InvoicePath);
                                                  SELECT SCOPE_IDENTITY();", con);
                cmd.Parameters.AddWithValue("@UserID", userId);
                cmd.Parameters.AddWithValue("@Total", total);
                cmd.Parameters.AddWithValue("@Method", paymentMethod);
                cmd.Parameters.AddWithValue("@Address", address);
                cmd.Parameters.AddWithValue("@InvoicePath", "Invoices/" + invoiceFile);
                orderId = Convert.ToInt32(cmd.ExecuteScalar());
            }

            // Send invoice email
            SendEmailWithAttachment(email, "Pets Heaven Invoice", "Your order was successful. Please find your invoice attached.", invoicePath);

            // Clear cart
            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();
                SqlCommand clearCart = new SqlCommand("DELETE FROM AddToCart WHERE UserID = @UserID", con);
                clearCart.Parameters.AddWithValue("@UserID", userId);
                clearCart.ExecuteNonQuery();
            }

            string swalScript = @"
    Swal.fire({
        icon: 'success',
        title: 'Thank you!',
        text: 'Order placed successfully! Invoice has been emailed.',
        confirmButtonColor: '#7d5fff'
    }).then((result) => {
        if (result.isConfirmed) {
            window.location.href = 'Home_page.aspx';
        }
    });";

            ScriptManager.RegisterStartupScript(this, GetType(), "SwalSuccess", swalScript, true); ;
        }

        private void GeneratePdfInvoice(string filePath, string name, string email, string address, DataTable items, decimal total)
        {
            using (FileStream fs = new FileStream(filePath, FileMode.Create))
            using (PdfWriter writer = new PdfWriter(fs))
            {
                PdfDocument pdf = new PdfDocument(writer);
                Document doc = new Document(pdf);

                // 🖼️ Full-width banner/logo image
                string logoPath = HttpContext.Current.Server.MapPath("~/Images/Logo_pdf.png");
                if (File.Exists(logoPath))
                {
                    var logo = new iText.Layout.Element.Image(iText.IO.Image.ImageDataFactory.Create(logoPath));
                    logo.SetWidth(UnitValue.CreatePercentValue(100)); // full width
                    doc.Add(logo);
                }

                // 🔻 Line after logo
                doc.Add(new Paragraph("\n"));
                doc.Add(new LineSeparator(new SolidLine()));

                // 📅 Date & GST
                Paragraph headerInfo = new Paragraph($"Date: {DateTime.Now:dd-MM-yyyy HH:mm}\nGST No: xxxxxxxxxxxxxx")
                    .SetTextAlignment(TextAlignment.RIGHT)
                    .SetFontSize(10)
                    .SetBold();
                doc.Add(headerInfo);

                // 👤 Customer Information
                doc.Add(new Paragraph("\n"));
                Table customerTable = new Table(UnitValue.CreatePercentArray(1)).UseAllAvailableWidth();
                customerTable.AddCell(new Cell().Add(new Paragraph($"Customer Name: {name}").SetFontSize(11).SetBold()).SetBorder(Border.NO_BORDER));
                customerTable.AddCell(new Cell().Add(new Paragraph($"Email: {email}").SetFontSize(11)).SetBorder(Border.NO_BORDER));
                customerTable.AddCell(new Cell().Add(new Paragraph($"Address: {address}").SetFontSize(11)).SetBorder(Border.NO_BORDER));
                doc.Add(customerTable);

                doc.Add(new Paragraph("\n"));
                doc.Add(new LineSeparator(new SolidLine()));
                doc.Add(new Paragraph("\n"));

                // 📦 Products Table
                Table table = new Table(4).UseAllAvailableWidth();
                table.AddHeaderCell("Product");
                table.AddHeaderCell("Quantity");
                table.AddHeaderCell("Price");
                table.AddHeaderCell("Subtotal");

                foreach (DataRow row in items.Rows)
                {
                    string productName = row["ProductName"].ToString();
                    int quantity = Convert.ToInt32(row["Quantity"]);
                    decimal price = Convert.ToDecimal(row["Price"]);
                    decimal subtotal = quantity * price;

                    table.AddCell(productName);
                    table.AddCell(quantity.ToString());
                    table.AddCell($"₹{price:0.00}");
                    table.AddCell($"₹{subtotal:0.00}");
                }

                doc.Add(table);

                // 💰 Total Amount
                doc.Add(new Paragraph($"\nTotal Amount: ₹{total:0.00}")
                    .SetTextAlignment(TextAlignment.RIGHT)
                    .SetFontSize(12)
                    .SetBold());

                // ✍️ Signature Line & Image
                doc.Add(new Paragraph("\n\n"));

                Table signatureTable = new Table(1).UseAllAvailableWidth();
                string signaturePath = HttpContext.Current.Server.MapPath("~/Images/Signature.png"); // Replace with your actual path

                if (File.Exists(signaturePath))
                {
                    var signatureImg = new iText.Layout.Element.Image(iText.IO.Image.ImageDataFactory.Create(signaturePath))
                                        .ScaleToFit(120, 60)
                                        .SetHorizontalAlignment(HorizontalAlignment.RIGHT);
                    signatureTable.AddCell(new Cell().Add(signatureImg).SetBorder(Border.NO_BORDER).SetTextAlignment(TextAlignment.RIGHT));
                }

                signatureTable.AddCell(new Cell().Add(new Paragraph("Authorized Signature"))
                    .SetTextAlignment(TextAlignment.RIGHT)
                    .SetBorder(Border.NO_BORDER)
                    .SetFontSize(10)
                    .SetBold());

                doc.Add(signatureTable);

                doc.Close();
            }
        }



        private void SendEmailWithAttachment(string toEmail, string subject, string body, string filePath)
        {
            MailMessage mail = new MailMessage();
            mail.From = new MailAddress("petsheaven41@gmail.com");
            mail.To.Add(toEmail);
            mail.Subject = subject;
            mail.Body = body;
            mail.Attachments.Add(new Attachment(filePath));

            SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
            smtp.Credentials = new NetworkCredential("petsheaven41@gmail.com", "ftraexpzoradpzco");
            smtp.EnableSsl = true;
            smtp.Send(mail);
        }
     
    }
}
