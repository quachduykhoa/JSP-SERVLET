<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>Danh Sách Người Dùng</title>
    <style>
        body { font-family: Arial; max-width: 800px; margin: 0 auto; padding: 20px; }
        .user { border: 1px solid #ddd; padding: 15px; margin: 10px 0; }
        button { padding: 10px 20px; background: #28a745; color: white; border: none; }
    </style>
</head>
<body>
    <h2>Danh Sách Người Dùng</h2>
    <a href="posts">Quay lại</a>
    
    <c:forEach items="${users}" var="u">
        <div class="user">
            <h4>${u.username} (${u.role})</h4>
            <c:if test="${u.id != user.id}">
                <form action="follow" method="post">
                    <input type="hidden" name="userId" value="${u.id}">
                    <button type="submit">Follow</button>
                </form>
            </c:if>
        </div>
    </c:forEach>
</body>
</html>