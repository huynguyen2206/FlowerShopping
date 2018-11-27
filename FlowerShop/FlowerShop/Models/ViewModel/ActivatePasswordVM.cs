using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace FlowerShop.Models
{
    public class ActivatePasswordVM
    {
        public int Id { get; set; }

        [DataType(DataType.Password), MinLength(8), MaxLength(30)]
        [Required]
        public string Password { get; set; }

        [DataType(DataType.Password), MinLength(8), MaxLength(30)]
        [Compare("Password", ErrorMessage = "Mật khẩu không trùng khớp")]
        [Required]
        public string RePassword { get; set; }
    }
}