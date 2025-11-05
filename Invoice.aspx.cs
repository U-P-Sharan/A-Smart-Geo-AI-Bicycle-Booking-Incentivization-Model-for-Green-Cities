using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Drawing.Printing;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using iTextSharp.text;
using iTextSharp.text.pdf;
using Font = iTextSharp.text.Font;

namespace goWheel
{
    public partial class Invoice : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Request.QueryString["bookingId"] != null)
            {
                int bookingId = int.Parse(Request.QueryString["bookingId"]);
                //int userId = 1; // You can fetch from session if required
                string userId = HttpContext.Current.Session["UserID"].ToString();
                GenerateInvoicePDF(bookingId, userId);
            }
        }

        private void GenerateInvoicePDF(int bookingId, string userId)
        {
            string conStr = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            SqlConnection con = new SqlConnection(conStr);

            string query = @"
  

SELECT 
    b.BookingID,
    u.FullName AS UserName,
    u.Address AS UserAddress,
    v.FullName AS VendorName,  
    v.Address AS VendorAddress,
    bk.BicycleName,
    bk.BicycleBrand,
    bk.PerHourCharge,
    b.StartDate,
    b.EndDate,
    DATEDIFF(HOUR, b.StartDate, b.EndDate) AS TotalHours,
    fd.DiscountPercent,
    b.TotalAmount
FROM Bookings b
JOIN Users u ON b.UserID = u.UserID  
JOIN Bicycles bk ON b.BicycleID = bk.BicycleID
JOIN Users v ON bk.VendorID = v.UserID  
OUTER APPLY (
    SELECT TOP 1 * 
    FROM FareDiscounts fd 
    WHERE DATEDIFF(HOUR, b.StartDate, b.EndDate) >= fd.MinHours 
    ORDER BY fd.MinHours DESC
) fd
    WHERE b.BookingID = @BookingID AND b.UserID = @UserID";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@BookingID", bookingId);
            cmd.Parameters.AddWithValue("@UserID", userId);

            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();

            if (rdr.Read())
            {
                string vendor = rdr["VendorName"].ToString();
                string vendorAddr = rdr["VendorAddress"].ToString();
                string user = rdr["UserName"].ToString();
                string userAddr = rdr["UserAddress"].ToString();
                string bicycle = rdr["BicycleName"].ToString();
                decimal charge = Convert.ToDecimal(rdr["PerHourCharge"]);
                int hours = Convert.ToInt32(rdr["TotalHours"]);
                decimal subtotal = charge * hours;
                decimal discount = Convert.ToDecimal(rdr["DiscountPercent"] ?? 0);
                decimal discountAmt = subtotal * discount / 100;
                decimal total = subtotal - discountAmt;

                Document doc = new Document(PageSize.A4, 50, 50, 50, 50);
                MemoryStream ms = new MemoryStream();
                PdfWriter.GetInstance(doc, ms);
                doc.Open();

                // Define fonts
                Font headerFont = FontFactory.GetFont("Arial", 20, Font.BOLD);
                Font subHeaderFont = FontFactory.GetFont("Arial", 12, Font.BOLD);
                Font normalFont = FontFactory.GetFont("Arial", 10, Font.NORMAL);

                // Header
                Paragraph header = new Paragraph("GoWHEEL", headerFont)
                {
                    Alignment = Element.ALIGN_CENTER
                };
                doc.Add(header);
                doc.Add(new Paragraph($"Order #: {bookingId}", normalFont));
                doc.Add(new Paragraph($"Issued: {DateTime.Now:dd/MM/yyyy}", normalFont));
                doc.Add(new Paragraph("\n"));

                // From/To Details
                PdfPTable partyTable = new PdfPTable(2);
                partyTable.WidthPercentage = 100;
                partyTable.SetWidths(new float[] { 50, 50 });

                PdfPCell fromCell = new PdfPCell();
                //fromCell.Border = System.Drawing.Rectangle.Round;
                fromCell.AddElement(new Paragraph("Invoice From", subHeaderFont));
                fromCell.AddElement(new Paragraph(vendor, normalFont));
                fromCell.AddElement(new Paragraph(vendorAddr, normalFont));

                PdfPCell toCell = new PdfPCell();
                //toCell.Border = Rectangle.NO_BORDER;
                toCell.AddElement(new Paragraph("Invoice To", subHeaderFont));
                toCell.AddElement(new Paragraph(user, normalFont));
                toCell.AddElement(new Paragraph(userAddr, normalFont));

                partyTable.AddCell(fromCell);
                partyTable.AddCell(toCell);
                doc.Add(partyTable);
                doc.Add(new Paragraph("\nPayment Method: Online (Wallet)", normalFont));
                doc.Add(new Paragraph($"Rental Period:", subHeaderFont));
                doc.Add(new Paragraph($"Start Date: {Convert.ToDateTime(rdr["StartDate"]).ToString("dd MMM yyyy hh:mm tt")}", normalFont));
                doc.Add(new Paragraph($"End Date: {Convert.ToDateTime(rdr["EndDate"]).ToString("dd MMM yyyy hh:mm tt")}", normalFont));
                doc.Add(new Paragraph($"Total Hours: {rdr["TotalHours"]}", normalFont));
                doc.Add(new Paragraph("\n"));

                // Booking Info Table
                PdfPTable infoTable = new PdfPTable(4);
                infoTable.WidthPercentage = 100;
                infoTable.SpacingBefore = 20f;
                infoTable.SetWidths(new float[] { 50, 15, 15, 20 });

                infoTable.AddCell(new PdfPCell(new Phrase("Description", subHeaderFont)));
                infoTable.AddCell(new PdfPCell(new Phrase("Quantity", subHeaderFont)));
                infoTable.AddCell(new PdfPCell(new Phrase("Price", subHeaderFont)));
                infoTable.AddCell(new PdfPCell(new Phrase("Total", subHeaderFont)));

                infoTable.AddCell(new Phrase("Bicycle Booking - " + bicycle, normalFont));
                infoTable.AddCell(new Phrase("1", normalFont));
                infoTable.AddCell(new Phrase("$" + charge.ToString("0.00"), normalFont));
                infoTable.AddCell(new Phrase("$" + subtotal.ToString("0.00"), normalFont));

                doc.Add(infoTable);

                // Summary (right aligned)
                PdfPTable summaryTable = new PdfPTable(2);
                summaryTable.TotalWidth = 300f;
                summaryTable.LockedWidth = true;
                summaryTable.HorizontalAlignment = Element.ALIGN_RIGHT;
                summaryTable.SpacingBefore = 20f;

                summaryTable.AddCell(new Phrase("Subtotal:", subHeaderFont));
                summaryTable.AddCell(new Phrase($"${subtotal:0.00}", normalFont));
                summaryTable.AddCell(new Phrase("Discount:", subHeaderFont));
                summaryTable.AddCell(new Phrase($"{discount:0.00}%", normalFont));
                summaryTable.AddCell(new Phrase("Total Amount:", subHeaderFont));
                summaryTable.AddCell(new Phrase($"${total:0.00}", normalFont));

                doc.Add(summaryTable);

                doc.Close();

                // Return PDF to browser
                Response.Clear();
                Response.ContentType = "application/pdf";
                Response.AddHeader("content-disposition", $"attachment;filename=Invoice_{bookingId}.pdf");
                Response.OutputStream.Write(ms.GetBuffer(), 0, ms.GetBuffer().Length);
                Response.End();
            }

            rdr.Close();
            con.Close();
        }

    }
}