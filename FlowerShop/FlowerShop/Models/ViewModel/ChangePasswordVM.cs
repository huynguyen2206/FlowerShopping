using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace FlowerShop.Models
{
    public class ChangePasswordVM
    {
        [DataType(DataType.Password), MinLength(8), MaxLength(30)]
        [Required]
        public string Password { get; set; }

        [DataType(DataType.Password), MinLength(8), MaxLength(30)]
        [Required]
        public string NewPassword { get; set; }

        [DataType(DataType.Password), MinLength(8), MaxLength(30)]
        [Compare("NewPassword", ErrorMessage = "Mật khẩu không trùng khớp")]
        public string RePassword { get; set; }
    }
}