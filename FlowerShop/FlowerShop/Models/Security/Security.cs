using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace FlowerShop.Models
{
    public class Security
    {
        public static string Encrypt(string password)
        {
            SHA256 sha = SHA256.Create();
            byte[] rs = sha.ComputeHash(Encoding.UTF8.GetBytes(password));

            return BitConverter.ToString(rs).Replace("-", "").ToLower();
        }
    }
}