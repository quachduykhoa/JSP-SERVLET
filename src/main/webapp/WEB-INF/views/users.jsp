<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>Danh Sách Người Dùng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style/users.css">
</head>
<body>
    <div class="page-wrapper">
        <h2>Danh sách người dùng</h2>

        <c:forEach items="${users}" var="u">
            <div class="user">
                <div>
                    <h4>${u.username}</h4>
                    <span>Vai trò: ${u.role}</span>
                </div>

                <c:if test="${u.id != user.id}">
                    <c:choose>
                        <c:when test="${followingIds != null && followingIds.contains(u.id)}">
                            <span>Đã follow</span>
                        </c:when>
                        <c:otherwise>
                            <form action="follow" method="post">
                                <input type="hidden" name="userId" value="${u.id}">
                                <button type="submit">Follow</button>
                            </form>
                        </c:otherwise>
                    </c:choose>
                </c:if>
            </div>
        </c:forEach>

        <a href="posts">← Quay lại trang bài viết</a>
    </div>
</body>
</html>