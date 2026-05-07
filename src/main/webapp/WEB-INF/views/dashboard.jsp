<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>FitnessTracker - Dashboard</title>
    <style>
        body { margin: 0; font-family: Arial, sans-serif; background: #f2f6f9; color: #1f2937; }
        .container { max-width: 1200px; margin: 30px auto; padding: 0 20px; }
        .topbar { background: #0f766e; color: white; padding: 18px 24px; border-radius: 10px; display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 12px; }
        .topbar h1 { margin: 0; font-size: 26px; }
        nav a { color: white; margin-left: 16px; font-weight: bold; text-decoration: none; }
        nav a:hover { text-decoration: underline; }
        .message { padding: 12px 16px; border-radius: 6px; margin: 20px 0; font-weight: bold; }
        .success { background: #dcfce7; color: #166534; border: 1px solid #bbf7d0; }
        .error { background: #fee2e2; color: #991b1b; border: 1px solid #fecaca; }
        .card { background: #ffffff; margin-top: 24px; border-radius: 10px; padding: 24px; box-shadow: 0 8px 24px rgba(15, 23, 42, 0.08); }
        h2 { color: #0f766e; margin-top: 0; }
        table { width: 100%; border-collapse: collapse; margin-top: 14px; }
        th, td { padding: 12px; border: 1px solid #d1d5db; text-align: left; }
        th { background: #ccfbf1; color: #134e4a; }
        tr:nth-child(even) { background: #f8fafc; }
        form { display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap: 16px; }
        .full { grid-column: 1 / -1; }
        label { display: block; margin-bottom: 6px; font-weight: bold; }
        input, select, textarea { width: 100%; box-sizing: border-box; padding: 10px; border: 1px solid #cbd5e1; border-radius: 6px; font-size: 15px; }
        textarea { min-height: 90px; resize: vertical; }
        button { padding: 12px 18px; border: none; border-radius: 6px; background: #0f766e; color: white; font-weight: bold; cursor: pointer; }
        button:hover { background: #115e59; }
    </style>
</head>
<body>
<c:if test="${empty sessionScope.loggedInUser}">
    <c:redirect url="/login" />
</c:if>
<div class="container">
    <div class="topbar">
        <h1>Welcome, ${user.username}!</h1>
        <nav>
            <a href="/dashboard">Dashboard</a>
            <a href="/log-performance-page">Log Performance</a>
            <a href="/history">History</a>
            <a href="/logout">Logout</a>
        </nav>
    </div>

    <c:if test="${not empty success}">
        <div class="message success">${success}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="message error">${error}</div>
    </c:if>

    <div class="card">
        <h2>Training Programs</h2>
        <table>
            <thead>
            <tr>
                <th>Name</th>
                <th>Category</th>
                <th>Duration (mins)</th>
                <th>Difficulty</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="program" items="${programs}">
                <tr>
                    <td>${program.name}</td>
                    <td>${program.category}</td>
                    <td>${program.durationMinutes}</td>
                    <td>${program.difficulty}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="card">
        <h2>Log a Performance</h2>
        <form method="post" action="/log-performance">
            <div>
                <label for="programId">Program</label>
                <select id="programId" name="programId" required>
                    <c:forEach var="program" items="${programs}">
                        <option value="${program.id}">${program.name} (${program.category})</option>
                    </c:forEach>
                </select>
            </div>
            <div>
                <label for="performanceDate">Date</label>
                <input type="date" id="performanceDate" name="performanceDate" value="${today}" required>
            </div>
            <div>
                <label for="durationPerformed">Duration performed</label>
                <input type="number" id="durationPerformed" name="durationPerformed" min="1" required>
            </div>
            <div>
                <label for="distanceKm">Distance (km)</label>
                <input type="number" id="distanceKm" name="distanceKm" min="0" step="0.1">
            </div>
            <div class="full">
                <label for="notes">Notes</label>
                <textarea id="notes" name="notes"></textarea>
            </div>
            <div class="full">
                <button type="submit">Save Performance</button>
            </div>
        </form>
    </div>
</div>
</body>
</html>
