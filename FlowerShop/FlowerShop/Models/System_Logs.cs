//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace FlowerShop.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class System_Logs
    {
        public int Id { get; set; }
        public int Log_Type_Id { get; set; }
        public int EmployeeId { get; set; }
        public string Message { get; set; }
        public System.DateTime RegisterDate { get; set; }
    
        public virtual Log_Types Log_Types { get; set; }
        public virtual Employee Employee { get; set; }
    }
}
