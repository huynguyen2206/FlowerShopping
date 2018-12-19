
function init_reload() {
    setInterval(function () {
        window.location.reload();
    }, 90000);
}


$(document).ready(function () {
    //init_reload();
    $("#Login_form").submit(function () {
        var url = location.href;
        $.ajax({
            url: this.action,
            type: this.method,
            data: $(this).serialize(),
            success: function (response) {
                if (response == "LoginLog") {
                    $(".login_email").val("");
                    $(".login_password").val("");
                    alert("Bạn đã đăng nhập sai nhiều lần, vui lòng chờ 10 phút");
                    location.href = url;
                }
                else if (response == "OK") {
                    location.href = url;
                }
                else {
                    alert(response);
                }
            } 

        });
        $(".login_email").val("");
        $(".login_password").val("");
        return false;
    });


    $("#forget_password").click(function () {
        if (email = prompt("Vui lòng nhập Email!")) {
            if (email == "") {
                return false;
            }
            $.ajax({
                url: '/Customer/ForgetPassword',
                type: 'post',
                data: "myemail=" + email,
                success: function (response) {
                    if (response == "OK") {
                        alert("Vui lòng xác thực trong email của bạn để lấy thông tin cá nhân!");
                    }
                    else {
                        alert(response);
                    }
                }
            });
        } else {
            return false;
        }
        
    });



});