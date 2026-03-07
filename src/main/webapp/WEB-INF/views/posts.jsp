<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>Danh Sách Bài Viết</title>
    <style>
        body { font-family: Arial; max-width: 800px; margin: 0 auto; padding: 20px; }
        .post { border: 1px solid #ddd; padding: 15px; margin: 10px 0; }
        textarea, input[type="text"] { width: 100%; margin: 5px 0; }
        button { padding: 10px 20px; background: #007bff; color: white; border: none; }
    </style>
</head>
<body>
    <h2>Xin chào, ${user.username}!</h2>
    <a href="logout">Đăng xuất</a>
    
    <h3>Đăng bài mới</h3>
    <form action="posts" method="post">
        <input type="text" name="title" placeholder="Tiêu đề" required><br>
        <textarea name="body" placeholder="Nội dung..." required></textarea><br>
        <select name="status">
            <option value="published">Published</option>
            <option value="draft">Draft</option>
        </select><br>
        <button type="submit">Đăng</button>
    </form>
    
    <h3>Các bài viết</h3>
    <c:forEach items="${posts}" var="post">
        <div class="post">
            <h4>${post.title}</h4>
            <p>${post.body}</p>
            <small>Status: ${post.status} | Date: ${post.createdAt}</small>
        </div>
    </c:forEach>
</body>
</html>