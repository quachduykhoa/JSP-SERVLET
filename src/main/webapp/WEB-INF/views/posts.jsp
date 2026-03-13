<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>Diễn đàn - Kết nối & Chia sẻ</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- CSS riêng cho trang posts -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style/posts.css">
</head>
<body>

<div class="header">
    <div class="logo">
        <i class="fas fa-comments"></i>
        <span>ConnectHub</span>
    </div>
    <div class="user-info">
        <i class="fas fa-user-circle" style="color: #3b82f6; font-size: 20px;"></i>
        <span>Xin chào, <b>${user.username}</b></span>
        <a href="http://localhost:8080/SocialDemo/login" class="logout-btn">
            <i class="fas fa-sign-out-alt"></i>
            Đăng xuất
        </a>
    </div>
</div>

<div class="container">
  <div class="layout">
    <!-- LEFT SIDEBAR -->
    <aside class="sidebar">
      <div class="nav-card">
        <a class="nav-item" href="posts">
          <i class="fas fa-house"></i>
          <span>Trang chủ</span>
        </a>
        <a class="nav-item" href="users">
          <i class="fas fa-user-friends"></i>
          <span>Người dùng</span>
        </a>
      </div>
    </aside>

    <!-- MAIN FEED -->
    <main class="main-col">
      <!-- FORM ĐĂNG BÀI -->
      <div class="post-form">
        <h3>
            <i class="fas fa-pen-fancy"></i>
            Tạo bài viết mới
        </h3>

        <form action="posts" method="post">
            <div class="form-group">
                <input type="text" name="title" placeholder="Tiêu đề bài viết..." required>
            </div>

            <div class="form-group">
                <textarea name="body" rows="4" placeholder="Nội dung bài viết... (Chia sẻ suy nghĩ của bạn)"></textarea>
            </div>

            <!-- Toggle switch -->
            <div class="toggle-container">
                <span class="toggle-label">Trạng thái:</span>
                <label class="toggle-switch">
                    <input type="checkbox" name="status" value="published" checked id="statusToggle">
                    <span class="toggle-slider"></span>
                </label>
                <span class="toggle-status" id="toggleStatusText">Published</span>
            </div>

            <button type="submit" class="submit-btn">
                <i class="fas fa-paper-plane"></i>
                Đăng bài ngay
            </button>
        </form>
      </div>

      <!-- DANH SÁCH BÀI VIẾT -->
      <div class="posts-header">
        <h3>
            <i class="fas fa-newspaper" style="margin-right: 10px; color: #3b82f6;"></i>
            Bài viết mới nhất
        </h3>
        <span class="post-count">
            <i class="fas fa-file-alt"></i> ${posts.size()} bài viết
        </span>
      </div>

      <c:forEach items="${posts}" var="post" varStatus="loop">
      <div class="post">

        <div class="content">
            <h4>${post.title}</h4>

            <div class="meta">
                <span><i class="far fa-clock"></i> ${post.createdAt}</span>
                <c:choose>
                    <c:when test="${post.status == 'published'}">
                        <span class="status-badge status-published-badge">
                            <i class="fas fa-globe"></i> Công khai
                        </span>
                    </c:when>
                    <c:otherwise>
                        <span class="status-badge status-draft-badge">
                            <i class="fas fa-lock"></i> Bản nháp
                        </span>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="post-body">
                ${post.body}
            </div>

            <!-- Các nút tương tác -->
            <div class="post-actions">
                <button class="action-btn like" onclick="alert('Đã thích bài viết!')">
                    <i class="far fa-heart"></i> Thích
                </button>
                <button class="action-btn" onclick="alert('Mở comment!')">
                    <i class="far fa-comment"></i> Bình luận
                </button>
                <button class="action-btn" onclick="alert('Chia sẻ!')">
                    <i class="far fa-share-square"></i> Chia sẻ
                </button>
            </div>
        </div>
      </div>
      </c:forEach>

      <hr>
      <div style="text-align: center; padding: 14px; color: #64748b;">
          <i class="fas fa-heart" style="color: #ef4444;"></i>
          Cảm ơn bạn đã tham gia diễn đàn!
      </div>
    </main>

    <!-- RIGHT RAIL (suggestions) -->
    <aside class="right-rail">
      <div class="right-card">
        <div class="suggestions">
          <div class="suggestions-header">
              <i class="fas fa-user-friends" style="color: #3b82f6;"></i>
              <span>Gợi ý theo dõi</span>
          </div>

          <c:if test="${empty suggestedUsers}">
              <div class="suggest-empty">
                  Hiện không còn tài khoản nào để gợi ý.
              </div>
          </c:if>

          <c:forEach items="${suggestedUsers}" var="u">
              <form action="follow" method="post" class="suggest-item">
                  <span class="suggest-username">${u.username}</span>
                  <input type="hidden" name="userId" value="${u.id}" />
                  <button type="submit" class="follow-btn">
                      <i class="fas fa-plus"></i> Follow
                  </button>
              </form>
          </c:forEach>
        </div>
      </div>
    </aside>
  </div>
</div>

<!-- JS riêng cho trang posts -->
<script src="${pageContext.request.contextPath}/js/posts.js"></script>

</body>
</html>