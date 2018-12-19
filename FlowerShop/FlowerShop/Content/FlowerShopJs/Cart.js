
$.cookie.json = true;
$.cookie.defaults.path = '/';

function getCartItems() {
    if ($.cookie('productlist')) {
        return $.cookie('productlist').cartItems;
    } else {
        return [];
    }
}

function saveCartItems(cart_items) {
    var obj = { "cartItems": cart_items };
    $.cookie('productlist', obj);
}

// Remove All Item
function emptyCartItems() {
    $.removeCookie('productlist');
    $.removeCookie('total');
}

//Add Item
function addItem(productid, productname, price, saleprice, picture, quantity, quantitystock) {
    var cart_items = getCartItems();
    //if (quantity == null) {
    //    quantity = 1;
    //}
    quantity = quantity ? quantity : 1;

    var is_exist = false;
    $(cart_items).each(function (i, v) {
        if (v && v.productid == productid) {
            is_exist = true;
        }
    });
    if (!is_exist) {
        var new_item = { "productid": productid, "productname": productname, "price": price.replace(/,/g, ''), "saleprice": saleprice.replace(/,/g, ''), "picture": picture, "quantity": quantity, "quantitystock": quantitystock };
        cart_items.push(new_item);
        saveCartItems(cart_items);
        alert("Thêm Sản Phẩm Thành Công!");
        loadCartItems();
        if (!$.cookie('couponprice')) {
            showTotal(0)
        }
        else {
            showTotal($.cookie('couponprice'));
        }

    } else {
        alert("Sản Phẩm Đã Có Trong Giỏ Hàng!");
    }
}

// Update Item
function updateItem(productid, q) {

    var cart_items = getCartItems();
    var t = 0;
    $(cart_items).each(function (i, v) {
        if (v && v.productid == productid) {
            cart_items[i].quantity = q;
            saveCartItems(cart_items);
            t = (cart_items[i].price - cart_items[i].saleprice) * q;
        }
    });
    return t.toLocaleString('en') + " NVĐ";
}

//Remove Item
function removeItem(productid) {

    var cart_items = getCartItems();

    $(cart_items).each(function (i, v) {
        if (v && v.productid == productid) {
            cart_items.splice(i, 1);
        }
    });

    saveCartItems(cart_items);
}

// Show Total
function showTotal(coupon) {
    var total = 0;
    var cart_items = getCartItems();
    $(cart_items).each(function (i, v) {
        if (v) {
            total += ((v.price - v.saleprice) * v.quantity);
        }
    });
    if (coupon <= 100) {
        total = total - ((total * coupon) / 100)
    }
    else {
        total = total - (parseInt(coupon) * 1000)
    }

    if (total < 0) return total = 0;
    if (coupon != 0) {
        $.cookie('total', total);
    }
    $(".sumtotal").html(total.toLocaleString('en') + " NVĐ");

}

// Load Total
function loadTotal() {
    if ($.cookie('total') != null) {
        $(".sumtotal").html($.cookie('total').toLocaleString('en') + " NVĐ");
    }
}

// Load CartItem
function loadCartItems() {

    var cart_items = getCartItems();
    var quan = 0;
    var total = 0;
    $("#carts2").html("");
    $(".show_mini_carts").html("");
    $(cart_items).each(function (i, v) {
        var t = (v.price - v.saleprice) * v.quantity;
        total += t;
        quan += v.quantity
        // show CartItem trong Index/Cart
        $("#carts2").append("<tr>"
            + "<td align='center'>" + v.productid + "</td>"
            + "<td>" + v.productname + "</td>"
            + "<td align='right'>" + parseFloat(v.price).toLocaleString('en') + " VNĐ" + "</td>"
            + "<td align='right'>" + parseFloat(v.saleprice).toLocaleString('en') + " VNĐ" + "</td>"
            + "<td align='plantmore-product-quantity'><input type='number' pstock='" + v.quantitystock + "' class='quantity' value='" + v.quantity + "' min='1' max='1000'></td>"
            + "<td align='right' style='font-weight: bold'>" + t.toLocaleString('en') + " NVĐ" + "</td>"
            + "<td><button class='removeitem'>Remove</button></td>"
            + "</tr>");

        // show CartItem nhỏ ngoài Layout
        $(".show_mini_carts").append("<li class='single-cart-item'>"
            + "<div class='cart-img'>"
            + "<a href=''><img src='" + v.picture + "'></a></div>"
            + "<div class='cart-content'>"
            + "<h5 class='product-name'><a href=''>" + v.productname + "</a></h5>"
            + "<span class='cart-price'>" + v.quantity + " × " + (v.price - v.saleprice) + "</span></div>"
            + "</li>");

        $("#carts3").append("<tr class='cart_item'>"
            + "<td class='cart-product-name'>" + v.productname + "<strong class='product-quantity'> × " + v.quantity + "</strong></td>"
            + "<td class='cart-product-total'><span class='amount'>" + t.toLocaleString('en') + " NVĐ" + "</span></td>"
            + "</tr>");
    });

    // Show price
    $(".sumtotal").html(total.toLocaleString('en') + " NVĐ");

    $(".cart-icon").append("<span class='cart-quantity'>" + quan + "</span>");

    // Thay đổi số lượng
    $(".quantity").bind("keyup change click", function () {
        var value = $(this).val();
        var quantitystock = $(this).attr("pstock");
        if (value > parseInt(quantitystock)) {
            alert("Số lượng vượt quá số lượng sản phẩm hiện có! Số lượng hiện có: " + quantitystock);
            $(this).val(1);
            return false;
        }
        var tr = $(this).closest("tr").find("td");
        var t = updateItem(tr.eq(0).html(), value);

        // Bắt lỗi không cho số lượng < 0 và > 1000
        if (value <= 0 || value > 1000) {
            //alert("Lỗi số lượng");
            $(this).val(1);
            return false;
        }

        tr.eq(5).html(t.toLocaleString('en'));

        if (!$.cookie('couponprice')) {
            showTotal(0)
        }
        else {
            showTotal($.cookie('couponprice'));
        }
    });

    $(".removeitem").click(function () {
        if (confirm("Are you sure to remove this item?")) {
            var tr = $(this).closest("tr").find("td");
            removeItem(tr.eq(0).html());
            tr.remove();
            loadCartItems();
        }
        if (!$.cookie('couponprice')) {
            showTotal(0)
        }
        else {
            showTotal($.cookie('couponprice'));
        }
        return false;
    });
}


// Check Out
function Checkout(coupon) {
    var Receiver = $(".cfl_Receiver").val();
    var Address = $(".cfl_Address").val();
    var phone = $(".cfl_phone").val();

    var cart_items = getCartItems();

    $.ajax({
        url: '/Cart/Checkout',
        type: "POST",
        data: "data=" + JSON.stringify(cart_items) + "&coupon=" + coupon + "&receiver=" + Receiver + "&address=" + Address + "&Phone=" + phone,
        success: function (response) {

            if (response == "OK") {

                alert("Checkout Ok");
                emptyCartItems();
                $.removeCookie('total');
                $.removeCookie('couponid');
                $.removeCookie('total');
                $.removeCookie('couponprice');
                location.href = "/Home";  // chuyển qua trang Home
            }
            else if (response == "coupon") {
                alert("Mã Coupon này vừa được sử dụng");
                $("#btnremovecoupon").click();
            }
            else {

                //dialog.modal("show");
                //$("#myContent").html(response);

                alert(response);
                return false;
            }
        },
        error: function (response) {
            alert(response)
        }
    });

    return false;
}

// Load Like
function load_like() {
    var btn = $("#btnlike");
    var pid = btn.attr("pid");

    $.ajax({
        url: '/Product/Checklike',
        type: "POST",
        data: "id=" + pid,
        success: function (response) {
            //alert(response);
            btn.text(response == "True" ? "Unlike" : "Like");
        }

    });
}


$(document).ready(function () {

    // add product to cart
    $(".btnAddProduct").click(function () {
        var a = $(this);
        var quantity = $("#quantity_product").val();
        var quantitystock = a.attr("pstock");
        if (quantity > parseInt(quantitystock)) {
            alert("Số lượng vượt quá số lượng sản phẩm hiện có!");
            return false;
        }
        addItem(a.attr("pid"), a.attr("pname"), a.attr("pprice"), a.attr("psale"), a.attr("ppic"), quantity, quantitystock);
        return false;
    });

    loadCartItems();
    load_like();
    loadTotal();

    // empty cart
    $("#emptycart").click(function () {
        if (!$.cookie('productlist')) {
            return false;
        }
        if (confirm("Are you sure to remove all items?")) {
            emptyCartItems();
            loadCartItems();
        }
    });

    // checkout
    $(".checkout1").click(function () {
        if ($.cookie('couponid')) {
            Checkout($.cookie('couponid'));
        }
        else {
            Checkout(1);
        }

    });

    // Button Like
    $("#btnlike").click(function () {
        var btn = $(this);
        var pid = btn.attr("pid");
        $.ajax({
            url: '/Product/Like',
            type: "POST",
            data: "id=" + pid,
            success: function (response) {
                var d = response.split("|");
                btn.text(d[0] == "True" ? "Unlike" : "Like");
                //d[0] == "True" ? btn.text("Unlike") : btn.text("Like");

                $(".like_count").html("Lượt Like: " + d[1]);
            }

        });
        return false;
    });

    // Button Coupon
    $("#btncoupon").click(function () {
        var code = $("#coupon_code").val();
        if (!$.cookie('productlist')) {
            alert("Bạn chưa có sản phẩm trong giỏ hàng");
            $("#coupon_code").val("")
            return false;
        }

        if ($.cookie('total')) {
            alert("Mỗi đơn hàng chỉ được sử dụng 1 coupon");
            $("#coupon_code").val("")
            return false;
        }

        $.ajax({
            url: '/Cart/Coupon',
            type: "POST",
            data: "code=" + code,
            success: function (response) {
                if (response == "error") {
                    alert("Mã Coupon không chính xác")
                }
                else if (response == "unique") {
                    alert("Coupon này đã được sử dụng")
                }
                else {

                    var c = response.split("|");
                    //alert(parseInt(c[1]))
                    if (c[0] <= 100) {
                        alert("Bạn đã được khuyến mãi " + c[0] + "% tổng giá trị đơn hàng");
                    }
                    else {
                        alert("Bạn đã được khuyến mãi " + c[0] + " VNĐ tổng giá trị đơn hàng")
                    }

                    $.cookie('couponprice', c[0]);
                    showTotal($.cookie('couponprice'));
                    $.cookie('couponid', c[1])
                    $("#coupon_code").val("");
                }
            }

        });


        return false;
    });

    //Remove coupon
    $("#btnremovecoupon").click(function () {
        if ($.cookie('total')) {
            showTotal(0);
            $.removeCookie('total');
            $.removeCookie('couponid');
            $.removeCookie('couponprice');
            alert("Coupon đã bị hủy");
            return false;
        }
        return false;
    });



});