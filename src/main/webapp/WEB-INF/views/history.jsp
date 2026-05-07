<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>FitnessTracker - History</title>
    <style>
        body { margin: 0; font-family: Arial, sans-serif; background: #f2f6f9; color: #1f2937; }
        .container { max-width: 1200px; margin: 30px auto; padding: 0 20px; }
        .topbar { background: #0f766e; color: white; padding: 18px 24px; border-radius: 10px; display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 12px; }
        .topbar h1 { margin: 0; font-size: 26px; }
        nav a { color: white; margin-left: 16px; font-weight: bold; text-decoration: none; }
        nav a:hover { text-decoration: underline; }
        .message { padding: 12px 16px; border-radius: 6px; margin: 20px 0; font-weight: bold; }
        .success { background: #dcfce7; color: #166534; border: 1px solid #bbf7d0; }
        .card { background: #ffffff; margin-top: 24px; border-radius: 10px; padding: 24px; box-shadow: 0 8px 24px rgba(15, 23, 42, 0.08); }
        h2 { color: #0f766e; margin-top: 0; }
        .filters { display: grid; grid-template-columns: repeat(auto-fit, minmax(210px, 1fr)); gap: 16px; align-items: end; }
        label { display: block; margin-bottom: 6px; font-weight: bold; }
        input, select { width: 100%; box-sizing: border-box; padding: 10px; border: 1px solid #cbd5e1; border-radius: 6px; font-size: 15px; }
        button { padding: 12px 18px; border: none; border-radius: 6px; background: #0f766e; color: white; font-weight: bold; cursor: pointer; }
        button:hover { background: #115e59; }
        table { width: 100%; border-collapse: collapse; margin-top: 14px; }
        th, td { padding: 12px; border: 1px solid #d1d5db; text-align: left; vertical-align: top; }
        th { background: #ccfbf1; color: #134e4a; }
        tr:nth-child(even) { background: #f8fafc; }
        .empty { padding: 24px; text-align: center; color: #64748b; font-weight: bold; }
    </style>
</head>
<body>
<c:if test="${empty sessionScope.loggedInUser}">
    <c:redirect url="/login" />
</c:if>
<div class="container">
    <div class="topbar">
        <h1>My Performance History</h1>
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

    <div class="card">
        <h2>Filters</h2>
        <form class="filters" method="get" action="/history">
            <div>
                <label for="startDate">Start Date</label>
                <input type="date" id="startDate" name="startDate" value="${startDate}">
            </div>
            <div>
                <label for="endDate">End Date</label>
                <input type="date" id="endDate" name="endDate" value="${endDate}">
            </div>
            <div>
                <label for="programId">Program</label>
                <select id="programId" name="programId">
                    <option value="">All Programs</option>
                    <c:forEach var="program" items="${programs}">
                        <option value="${program.id}" <c:if test="${programId == program.id}">selected</c:if>>${program.name}</option>
                    </c:forEach>
                </select>
            </div>
            <div>
                <button type="submit">Apply Filters</button>
            </div>
        </form>
    </div>

    <div class="card">
        <h2>Performance Table</h2>
        <c:choose>
            <c:when test="${empty performances}">
                <div class="empty">No performances recorded yet</div>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                    <tr>
                        <th>Date</th>
                        <th>Program Name</th>
                        <th>Category</th>
                        <th>Duration Performed (mins)</th>
                        <th>Distance (km)</th>
                        <th>Notes</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="performance" items="${performances}">
                        <tr>
                            <td>${performance.performanceDate}</td>
                            <td>${performance.program.name}</td>
                            <td>${performance.program.category}</td>
                            <td>${performance.durationPerformed}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${empty performance.distanceKm}">-</c:when>
                                    <c:otherwise>${performance.distanceKm}</c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${empty performance.notes}">-</c:when>
                                    <c:when test="${fn:length(performance.notes) > 50}">${fn:substring(performance.notes, 0, 50)}...</c:when>
                                    <c:otherwise>${performance.notes}</c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>
</html>
