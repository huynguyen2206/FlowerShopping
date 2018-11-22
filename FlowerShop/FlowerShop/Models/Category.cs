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
    
    public partial class Category
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Category()
        {
            this.Products_Categories_Mapping = new HashSet<Products_Categories_Mapping>();
        }
    
        public int Id { get; set; }
        public string CategoryName { get; set; }
        public int TopicId { get; set; }
        public bool ShowHomePage { get; set; }
        public System.DateTime CreateDate { get; set; }
        public bool IsActive { get; set; }
    
        public virtual Topic Topic { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Products_Categories_Mapping> Products_Categories_Mapping { get; set; }
    }
}