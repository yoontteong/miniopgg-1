<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>

<style>
    .ok {
        color: green;
        font-size: 13px;
    }

    .error {
        color: red;
        font-size: 13px;
    }
</style>

<script>
function checkId() {
    let id = document.getElementById("login_id").value;
    let msg = document.getElementById("idMsg");

    if (id.length < 4) {
        msg.innerText = "아이디는 4자 이상 입력해주세요.";
        msg.className = "error";
        return;
    }

    fetch("${pageContext.request.contextPath}/checkId?login_id=" + id)
        .then(res => res.text())
        .then(data => {
            if (data === "ok") {
                msg.innerText = "사용 가능한 아이디입니다.";
                msg.className = "ok";
            } else {
                msg.innerText = "이미 사용중인 아이디입니다.";
                msg.className = "error";
            }
        });
}

function checkPw() {
    let pw = document.getElementById("password").value;
    let msg = document.getElementById("pwMsg");

    let regex = /^(?=.*[A-Za-z])(?=.*[!@#$%^&*]).{8,}$/;

    if (regex.test(pw)) {
        msg.innerText = "사용 가능한 비밀번호입니다.";
        msg.className = "ok";
    } else {
        msg.innerText = "영문+특수문자 포함 8자 이상 입력해주세요.";
        msg.className = "error";
    }
}

function checkPw2() {
    let pw = document.getElementById("password").value;
    let pw2 = document.getElementById("password2").value;
    let msg = document.getElementById("pw2Msg");

    if (pw2.length === 0) {
        msg.innerText = "";
        return;
    }

    if (pw === pw2) {
        msg.innerText = "비밀번호가 일치합니다.";
        msg.className = "ok";
    } else {
        msg.innerText = "비밀번호가 일치하지 않습니다.";
        msg.className = "error";
    }
}

function togglePassword(id) {
    let input = document.getElementById(id);

    if (input.type === "password") {
        input.type = "text";
    } else {
        input.type = "password";
    }
}
</script>
</head>

<body>

<h2>회원가입</h2>

<form action="${pageContext.request.contextPath}/signup" method="post">

    아이디:
    <input type="text" name="login_id" id="login_id" onkeyup="checkId()" required>
    <span id="idMsg"></span>
    <br><br>

    비밀번호:
    <input type="password" name="password" id="password" onkeyup="checkPw(); checkPw2();" required>
    <button type="button" onclick="togglePassword('password')">보기</button>
    <span id="pwMsg"></span>
    <br><br>

    비밀번호 확인:
    <input type="password" id="password2" onkeyup="checkPw2()" required>
    <button type="button" onclick="togglePassword('password2')">보기</button>
    <span id="pw2Msg"></span>
    <br><br>

    닉네임:
    <input type="text" name="nickname" required>
    <br><br>

    이메일:
    <input type="email" name="email">
    <br><br>

    이름:
    <input type="text" name="name">
    <br><br>

    생년월일:
    <input type="date" name="birthdate">
    <br><br>

    성별:
    <select name="gender">
        <option value="">선택</option>
        <option value="남">남</option>
        <option value="여">여</option>
    </select>
    <br><br>

    전화번호:
    <input type="text" name="phone" placeholder="010-0000-0000">
    <br><br>

    <button type="submit">회원가입</button>

</form>

<br>
<a href="${pageContext.request.contextPath}/user/login.jsp">로그인으로 이동</a>

</body>
</html>