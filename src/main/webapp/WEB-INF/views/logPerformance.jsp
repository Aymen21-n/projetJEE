<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>FitnessTracker - Log Performance</title>
    <style>
        body { margin: 0; font-family: Arial, sans-serif; background: #f2f6f9; color: #1f2937; }
        .container { max-width: 900px; margin: 30px auto; padding: 0 20px; }
        .topbar { background: #0f766e; color: white; padding: 18px 24px; border-radius: 10px; display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 12px; }
        .topbar h1 { margin: 0; font-size: 26px; }
        nav a { color: white; margin-left: 16px; font-weight: bold; text-decoration: none; }
        nav a:hover { text-decoration: underline; }
        .message { padding: 12px 16px; border-radius: 6px; margin: 20px 0; font-weight: bold; }
        .success { background: #dcfce7; color: #166534; border: 1px solid #bbf7d0; }
        .error { background: #fee2e2; color: #991b1b; border: 1px solid #fecaca; }
        .card { background: #ffffff; margin-top: 24px; border-radius: 10px; padding: 24px; box-shadow: 0 8px 24px rgba(15, 23, 42, 0.08); }
        label { display: block; margin: 14px 0 6px; font-weight: bold; }
        input, select, textarea { width: 100%; box-sizing: border-box; padding: 10px; border: 1px solid #cbd5e1; border-radius: 6px; font-size: 15px; }
        textarea { min-height: 120px; resize: vertical; }
        button { margin-top: 18px; padding: 12px 18px; border: none; border-radius: 6px; background: #0f766e; color: white; font-weight: bold; cursor: pointer; }
        button:hover { background: #115e59; }
    </style>
</head>
<body>
<c:if test="${empty sessionScope.loggedInUser}">
    <c:redirect url="/login" />
</c:if>
<div class="container">
    <div class="topbar">
        <h1>Log Your Performance</h1>
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
        <form method="post" action="/save-performance-page">
            <label for="programId">Program</label>
            <select id="programId" name="programId" required>
                <c:forEach var="program" items="${programs}">
                    <option value="${program.id}">${program.name} (${program.category})</option>
                </c:forEach>
            </select>

            <label for="performanceDate">Date</label>
            <input type="date" id="performanceDate" name="performanceDate" value="${today}" required>

            <label for="durationPerformed">Duration performed</label>
            <input type="number" id="durationPerformed" name="durationPerformed" min="1" required>

            <label for="distanceKm">Distance (km)</label>
            <input type="number" id="distanceKm" name="distanceKm" min="0" step="0.1">

            <label for="notes">Notes</label>
            <textarea id="notes" name="notes"></textarea>

            <button type="submit">Save Performance</button>
        </form>
    </div>
</div>
</body>
</html>
