function init_reload() {
    setInterval(function () {
        window.location.reload();
    }, 90000);
}


$(document).ready(function () {
    //init_reload();
    $("#Login_form").submit(function () {

        $.ajax({
            url: this.action,
            type: this.method,
            data: $(this).serialize(),
            success: function (response) {
                if (response == "LoginLog") {
                    $(".login_email").val("");
                    $(".login_password").val("");
                    alert("Bạn đã đăng nhập sai nhiều lần, vui lòng chờ 10 phút");
                    location.href = "/Home";
                }
                else if (response == "OK") {
                    location.href = "/Home";
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

});