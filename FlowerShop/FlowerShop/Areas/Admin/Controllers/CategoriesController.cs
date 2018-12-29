using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
// phải thêm dòng này mới có thể khởi tạo biến db
using FlowerShop.Models;

namespace FlowerShop.Areas.Admin.Controllers
{
    // cái [AdminCustomAuthorize] dùng để phân quyền, mi cũng không cần quan tâm
    [AdminCustomAuthorize]

    // Đây là một Controller có tên là CategoriesController
    // Một Controller có nhiều Action mỗi Action xử lý một công việc khác nhau
    public class CategoriesController : Controller
    {
        // khởi tạo biến db để có thể dùng database
        FlowerShoppingEntities db = new FlowerShoppingEntities();

        // INDEX SHOW CATEGORIES
        // Hàm này dùng để hiển thị danh sách các categories | string kw là tham số truyền vào để search
        // Đây là Action Index dùng hiển thị
        // Nếu hàm nào không có [HttpGet] hay [HttpPost] thì nó sẽ tự hiểu là hàm [HttpGet]
        public ActionResult Index(string kw)
        {
            // 4 dòng ở dưới coi như ta thêm vô khỏi cần quan tâm
            PermisstionsVM per = CustomPermisstions.CheckPermisstion("Categories");
            ViewBag.Create = per.Create.ToString();
            ViewBag.Edit = per.Edit.ToString();
            ViewBag.Delete = per.Delete.ToString();

            // khởi tạo biến categories => db.Categories.Tolist() nghĩa là lấy tất cả các danh sách của bảng Categories ép thành 1 cái list
            var categories = db.Categories.ToList();

            // string.IsNullOrEmpty(kw) có nghĩa là kiểm tra tham số kw truyền vào có bằng null hay không,
            // Nếu để string.IsNullOrEmpty(kw) là kiểm tra bằng null còn !string.IsNullOrEmpty(kw) là kiểm tra khác null
            // ở đây kiểm tra kw khác null
            if (!string.IsNullOrEmpty(kw))
            {
                // Nếu kw khác null thì code sẽ chạy vào đây
                // db.Categories.Where(x => x.TopicId.ToString().Equals(kw)).ToList() 
                // có nghĩa là trong cái list mình tạo ra ở trên lọc lại 1 lần nữa, lấy các categories
                // có cái Id của Topic trùng với sô Id mà mình nhập vào kw ngoài View
                // vd mi ra View nhập 1 thì nó sẽ lọc ra các category có TopicId = 1
                categories = db.Categories.Where(x => x.TopicId.ToString().Equals(kw)).ToList();
            }

            // return View(categories) có nghĩa là hiển thị ra View
            // categories ở đây là cái list ở trên mà mình sẽ hiển thị ra ngoài View
            return View(categories);
        }


        // CREATE CATEGORY
        // Hàm này dùng để khởi tạo một Category mới
        // Đây là Action Create để tạo mới Category
        // Mỗi Action thường có 2 hàm là hàm [HttpGet] và [HttpPost]
        // Action Index không có hàm [HttpPost] bởi vì hắn chỉ hiển thị dữ liệu chứ không có thêm xóa sửa chi trong database hết
        // đây là hàm HttpGet dùng để hiển thị dữ liệu ra ngoài View khi mới xuất hiện
        [HttpGet]
        public ActionResult Create()
        {
            // new SelectList(db.Topics, "Id", "TopicName") dùng để tạo ra một danh sách của Topic để hiển thị ra ngoài khi bấm sổ xuống
            // new SelectList gồm 3 tham số
            // 1: db.Topics là bảng mình sẽ đưa vào cụ thể ở đây là bảng Topics
            // 2: "Id" ở đây là khi mình bấm nút submit hắn sẽ truyền cái Id của Topic đó lên trong hàm httpPost để mình xử lý
            // 3: "TopicName" ở đây là để hiển thị tên ở ngoài View sẽ lấy theo trường "TopicName" của bảng Topic, nếu mình để "Id" nó sẽ hiển thị Id ngoài View khi mình sổ xuống
            ViewBag.TopicId = new SelectList(db.Topics, "Id", "TopicName");

            //return PartialView() dùng để show ra cái bảng nhỏ nhỏ khi mình bấm vô chữ Add Category => bấm thử sẽ thấy
            return PartialView();
        }

        // đây là hàm HttpPost dùng để xử lý, khi mình bấm nút submit nó sẽ bắt đầu gọi tới hàm này
        // hàm này nhận vào một cái "Category category"
        // category ở đây là biến tự đặt ưng đặt tên gì cũng được
        // Category ở đây là bảng Category
        // Category category nghĩa là bên ngoài View khi submit các dữ liệu ngoài đó sẽ biến thành 1 cái biến có kiểu dữ liệu là bảng Category rồi truyền vào đây
        [HttpPost]
        public ActionResult Create(Category category)
        {
            //try catch có nghĩ là bắt lỗi
            // Nếu có lỗi gì đó nó sẽ chạy xuống catch
            try
            {
                // DateTime.Now nghĩ là lấy thời điểm hiện tại khi họ tạo mới một Category
                category.CreateDate = DateTime.Now;

                // sau đó add hết category vào bảng Categories
                db.Categories.Add(category);

                // dòng này để lưu Log lại mi cũng k cần quan tâm
                SystemLogs.Create("Category", category.CategoryName);

                // db.SaveChanges() dùng để lưu vào database nếu k có dòng này thì nó sẽ không lưu được
                db.SaveChanges();

                // sau khi db.SaveChanges() thành công nó sẽ trở về lại Action Index
                return RedirectToAction("Index");
            }
            catch (Exception)
            {
                throw;
            }

        }


        // EDIT CATEGORY
        // Hàm này dùng để chỉnh sửa một Category
        //hàm này nhận vào một id của Category để biết mình đang chỉnh sửa cái Category nào
        public ActionResult Edit(int id)
        {
            //db.Categories.Find(id) nghĩa là tìm đến cái Category có Id bằng id mình truyền vào
            // sau đó gán Category đó cho một biến var category 
            var category = db.Categories.Find(id);

            // Cái này hàm Create có
            ViewBag.TopicId = new SelectList(db.Topics, "Id", "TopicName", category.TopicId);

            // sau đó truyền ra ngoài View
            // return PartialView() mà không có "category" thì các textbox sẽ trống trơn không có gì hết
            return PartialView(category);
        }

        // Đây là hàm [HttpPost] dùng để xử lý khi bấm submit
        // Category data ở đây là khi bấm submit nó sẽ đưa hết dữ liệu khi mình chỉnh sửa ngoài View thành một biến có kiểu dữ liệu là Category rồi đưa vào đây xử lý
        [HttpPost]
        public ActionResult Edit(Category data)
        {
            // ModelState.IsValid ở đây là kiểm tra xem mình có nhập đầy đủ không, nếu đầy đủ sẽ chạy vào được tiếp còn không đủ thì chạy xuống phía dưới
            if (ModelState.IsValid)
            {
                // data ở đây khi bấm submit sẽ có đầy đủ những thứ như Id, CategoryName, IsaActive ... của bảng Category
                // tìm ra cái Category có Id = data.Id
                var category = db.Categories.Find(data.Id);
                // sửa cái category.CategoryName thành data.CategoryName mình mới sửa ngoài View
                // các dòng dưới tương tự
                category.CategoryName = data.CategoryName;
                category.TopicId = data.TopicId;
                category.ShowHomePage = data.ShowHomePage;
                category.CreateDate = DateTime.Now;
                category.IsActive = data.IsActive;

                // không cần quan tâm
                SystemLogs.Edit("Category", data.CategoryName);

                // lưu lại trong database
                db.SaveChanges();
                // sau khi lưu thành công sẽ quay lại Action Index
                return RedirectToAction("Index");
            }
            // Như trên
            ViewBag.TopicId = new SelectList(db.Topics, "Id", "TopicName", data.TopicId);

            // Nếu nhập không đầy đủ sẽ trả ra lại View
            return View(data);
        }


        // DELETE
        // Hàm này dùng để xóa một Category
        // hàm này nhận vào một id để biết đang xóa cái Category nào
        // ngoài View khi mình bấm delete nó sẽ lấy Id của Category đó truyền vào đây
        // ra Ngoài View của Index kéo xuống dưới cùng sẽ thấy một đoạn javascrip để xử lý Detele này
        // hàm này là hàm httpGet vì ở đây ta xử lý bằng Ajax Post
        // https://thienanblog.com/javascript/jquery/huong-dan-jquery-ajax-toan-tap/ vô đó để biết thêm về ajax
        public ActionResult Delete(int id)
        {
            try
            {
                // tìm đến Category có Id bằng id mình truyền vào
                var category = db.Categories.Find(id);

                // db.Categories.Remove(category) nghĩa là mình remove cái category mới tìm thấy được
                db.Categories.Remove(category);

                // không cần quan tâm
                SystemLogs.Delete("Category", category.CategoryName);

                // lưu lại vào database
                db.SaveChanges();

                // lưu thành công sẽ trả ra chữ Ok, ra ngoài View xem sẽ thấy
                return Content("OK");
            }
            catch (Exception ex)
            {
                // nếu lỗi nó sẽ trả ra thông báo lỗi
                return Content(ex.Message);
            }

        }

    }
}