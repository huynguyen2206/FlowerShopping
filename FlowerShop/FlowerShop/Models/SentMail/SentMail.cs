using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Web;

namespace FlowerShop.Models
{
    public class SentMail
    {
        public static void Sent(string Email, string subject ,string body)
        {
            // Sent email
            MailMessage mail = new MailMessage();
            mail.From = new MailAddress("myaptechmail@gmail.com");
            mail.To.Add(Email);
            mail.Subject = subject;
            mail.Body = body;

            mail.SubjectEncoding = Encoding.UTF8;
            mail.BodyEncoding = Encoding.UTF8;
            mail.IsBodyHtml = true;

            //Create SMTP for send mail
            SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
            smtp.UseDefaultCredentials = false;
            smtp.Credentials = new NetworkCredential("myaptechmail", "thanhbinh");
            smtp.EnableSsl = true;

            //Call Send mail -> Check all Spam
            smtp.Send(mail);
        }
    }
}