<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>FitnessTracker - Login</title>
    <style>
        body { margin: 0; font-family: Arial, sans-serif; background: #f2f6f9; color: #1f2937; }
        .container { max-width: 1100px; margin: 40px auto; padding: 0 20px; }
        .header { text-align: center; margin-bottom: 30px; }
        .header h1 { color: #0f766e; margin-bottom: 8px; }
        .message { padding: 12px 16px; border-radius: 6px; margin-bottom: 18px; font-weight: bold; }
        .error { background: #fee2e2; color: #991b1b; border: 1px solid #fecaca; }
        .success { background: #dcfce7; color: #166534; border: 1px solid #bbf7d0; }
        .forms { display: grid; grid-template-columns: repeat(auto-fit, minmax(320px, 1fr)); gap: 24px; }
        .card { background: #ffffff; border-radius: 10px; padding: 26px; box-shadow: 0 8px 24px rgba(15, 23, 42, 0.08); }
        .card h2 { color: #0f766e; margin-top: 0; }
        label { display: block; margin: 14px 0 6px; font-weight: bold; }
        input { width: 100%; box-sizing: border-box; padding: 10px; border: 1px solid #cbd5e1; border-radius: 6px; font-size: 15px; }
        button { margin-top: 18px; width: 100%; padding: 12px; border: none; border-radius: 6px; background: #0f766e; color: white; font-weight: bold; cursor: pointer; }
        button:hover { background: #115e59; }
        .anchor { text-align: center; margin-top: 16px; }
        a { color: #0f766e; font-weight: bold; text-decoration: none; }
        a:hover { text-decoration: underline; }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>FitnessTracker</h1>
        <p>Track programs, log workouts, and review your progress.</p>
        <div class="anchor"><a href="#register-section">Create a new account</a></div>
    </div>

    <c:if test="${not empty error}">
        <div class="message error">${error}</div>
    </c:if>
    <c:if test="${not empty success}">
        <div class="message success">${success}</div>
    </c:if>

    <div class="forms">
        <div class="card">
            <h2>Login</h2>
            <form method="post" action="/login">
                <label for="login-username">Username</label>
                <input type="text" id="login-username" name="username" maxlength="50" required>

                <label for="login-password">Password</label>
                <input type="password" id="login-password" name="password" required>

                <button type="submit">Login</button>
            </form>
        </div>

        <div class="card" id="register-section">
            <h2>Register</h2>
            <form method="post" action="/register">
                <label for="register-username">Username</label>
                <input type="text" id="register-username" name="username" maxlength="50" value="${registerUsername}" required>

                <label for="register-email">Email</label>
                <input type="email" id="register-email" name="email" maxlength="100" value="${registerEmail}" required>

                <label for="register-password">Password</label>
                <input type="password" id="register-password" name="password" required>

                <label for="confirm-password">Confirm Password</label>
                <input type="password" id="confirm-password" name="confirmPassword" required>

                <button type="submit">Register</button>
            </form>
        </div>
    </div>
</div>
</body>
</html>
