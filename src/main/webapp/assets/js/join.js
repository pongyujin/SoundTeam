$(document).ready(function() {
    $('#password-confirm').on('input', function() {
		
        var password = $('input[name="password"]').val();
        var confirmPassword = $(this).val();

        $.ajax({
            url: "CheckPw",  // 서블릿 경로
            type: "post",
            data: {
                "password": password,
                "confirmPassword": confirmPassword
            },
            success: function(response) {
                if (response === "match") {
                    $('#passwordCheckMessage').text('비밀번호가 일치합니다.').css('color', 'green');
                } else {
                    $('#passwordCheckMessage').text('비밀번호가 일치하지 않습니다.').css('color', 'red');
                }
            },
            error: function() {
                $('#passwordCheckMessage').text('비밀번호 확인 중 오류가 발생했습니다.').css('color', 'red');
            }
        });
    });
});

$(document).ready(function() {
    $('.id-btn').on('click', function(event) {
        event.preventDefault(); // 기본 폼 제출 동작 방지

        var userid = $('#userid').val();

        $.ajax({
            url: 'CheckId', // Id_Check_Controller 서블릿 경로
            type: 'POST',
            data: { "userid": userid },
            success: function(response) {
                if (response === 'ok') {
                    $('#useridCheckMessage').text('사용할 수 있는 아이디입니다.').css('color', 'green');
                } else {
                    $('#useridCheckMessage').text('사용할 수 없는 아이디입니다.').css('color', 'red');
                }
            },
            error: function() {
                $('#useridCheckMessage').text('중복 체크 중 오류가 발생했습니다.').css('color', 'red');
            }
        });
    });
});



