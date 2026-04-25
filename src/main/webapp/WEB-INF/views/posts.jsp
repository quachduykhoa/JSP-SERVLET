<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.Post, model.User" %>

<%
    User user = (User) request.getAttribute("user");
    List<Post> posts = (List<Post>) request.getAttribute("posts");
    List<User> suggestedUsers = (List<User>) request.getAttribute("suggestedUsers");

    Integer currentPageObj = (Integer) request.getAttribute("currentPage");
    Integer totalPagesObj = (Integer) request.getAttribute("totalPages");

    int currentPage = (currentPageObj != null) ? currentPageObj : 1;
    int totalPages = (totalPagesObj != null && totalPagesObj > 0) ? totalPagesObj : 1;
%>

<!DOCTYPE html>
<html>
<head>
    <title>Diễn đàn</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <!-- FIX CACHE -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style/posts.css?v=3">
</head>

<body>

<!-- HEADER -->
<div class="header">
    <div class="logo">
        <i class="fas fa-comments"></i> ConnectHub
    </div>

    <div class="user-info">
        <span>Xin chào, <b><%= user.getUsername() %></b></span>
        <a href="login" class="logout-btn">Logout</a>
    </div>
</div>

<div class="container">
<div class="layout">

    <!-- LEFT -->
    <aside class="sidebar">
        <div class="nav-card">
            <a class="nav-item" href="posts"><i class="fas fa-house"></i> Trang chủ</a>
            <a class="nav-item" href="users"><i class="fas fa-user-friends"></i> Người dùng</a>
        </div>
    </aside>

    <!-- MAIN -->
    <main class="main-col">

        <!-- FORM -->
        <div class="post-form">
            <h3>Tạo bài viết</h3>

            <form action="posts" method="post">
                <input type="text" name="title" placeholder="Tiêu đề..." required>
                <textarea name="body" rows="4" placeholder="Nội dung..."></textarea>

                <div class="toggle-container">
				    <span id="toggleStatusText">Published</span>
				
				    <label class="switch">
				        <input type="checkbox" id="statusToggle" name="status" value="published" checked>
				        <span class="slider"></span>
				    </label>
				</div>

                <button type="submit" class="submit-btn">Đăng bài</button>
            </form>
        </div>

        <!-- POSTS -->
        <h3 class="posts-header">New Feed (<%= posts.size() %>)</h3>

        <%
            for(Post post : posts){
        %>

        <div class="post">

            <!-- USER -->
            <div class="post-user">
                <img class="post-avatar"
                     src="<%= request.getContextPath() %>/img/default-avatar.png">
				
				
                <div class="post-user-info">
                    <div class="post-username"><%= post.getUsername() %></div>
                    <div class="meta"><%= post.getCreatedAt() %></div>
                	<div class="meta">
				    <% if ("published".equals(post.getStatus())) { %>
				        <span style="color: #22c55e; font-weight: bold;">
				            <i class="fas fa-globe"></i> Công khai
				        </span>
				    <% } else { %>
				        <span style="color: #64748b; font-style: italic;">
				            <i class="fas fa-lock"></i> Bản nháp (Chỉ bạn thấy)
				        </span>
				    <% } %>
				</div>
                </div>
            </div>

            <!-- CONTENT -->
            <div class="content">
                <h4><%= post.getTitle() %></h4>

                <div class="post-body">
                    <%= post.getBody() %>
                </div>

                <div class="post-actions">
                    <button>❤️ <%= post.getLikeCount() %></button>
                    <button>💬 <%= post.getCommentCount() %></button>
                    <button>🔁 Share</button>
                </div>
            </div>

        </div>

        <% } %>

        <!-- PAGINATION -->
        <div class="pagination">
		    <% if(currentPage > 1){ %>
		        <a class="page-btn" href="posts?page=<%= currentPage - 1 %>">
		            <i class="fas fa-chevron-left"></i> Trang trước
		        </a>
		    <% } %>
		
		    <% for(int i = 1; i <= totalPages; i++){ %>
		        <a class="page-btn <%= (i == currentPage ? "active" : "") %>"
		           href="posts?page=<%= i %>">
		            <%= i %>
		        </a>
		    <% } %>
		
		    <% if(currentPage < totalPages){ %>
		        <a class="page-btn" href="posts?page=<%= currentPage + 1 %>">
		            Trang sau <i class="fas fa-chevron-right"></i>
		        </a>
		    <% } %>
		
		</div>

    </main>

    <!-- RIGHT -->
    <aside class="right-rail">

        <div class="right-card">
            <h4>Gợi ý theo dõi</h4>

            <%
                for(User u : suggestedUsers){
            %>

            <form action="follow" method="post" class="suggest-item">
                <span><%= u.getUsername() %></span>
                <input type="hidden" name="userId" value="<%= u.getId() %>">
                <button class="follow-btn">Follow</button>
            </form>

            <% } %>

        </div>

    </aside>

</div>
</div>

<script src="<%= request.getContextPath() %>/js/posts.js"></script>

</body>
</html>