<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>Diễn đàn - Kết nối & Chia sẻ</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #e4e8f0 100%);
            min-height: 100vh;
            color: #1e293b;
        }

        /* HEADER */
        .header {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
            padding: 15px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 100;
            border-bottom: 1px solid rgba(226, 232, 240, 0.6);
        }

        .logo {
            font-size: 24px;
            font-weight: 700;
            background: linear-gradient(135deg, #3b82f6, #8b5cf6);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .logo i {
            background: linear-gradient(135deg, #3b82f6, #8b5cf6);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            font-size: 28px;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 20px;
            background: white;
            padding: 8px 20px;
            border-radius: 40px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.03);
            border: 1px solid #e2e8f0;
        }

        .user-info span {
            color: #1e293b;
            font-weight: 500;
        }

        .user-info b {
            color: #3b82f6;
            font-weight: 600;
        }

        .logout-btn {
            color: #64748b;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 5px;
            transition: all 0.3s;
            font-size: 14px;
        }

        .logout-btn:hover {
            color: #ef4444;
        }

        /* CONTAINER */
        .container {
            max-width: 1000px;
            margin: 40px auto;
            padding: 0 20px;
        }

        /* POST FORM */
        .post-form {
            background: white;
            padding: 30px;
            border-radius: 24px;
            box-shadow: 0 20px 40px -15px rgba(0, 0, 0, 0.1);
            margin-bottom: 40px;
            border: 1px solid rgba(255, 255, 255, 0.5);
            backdrop-filter: blur(5px);
        }

        .post-form h3 {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 20px;
            color: #0f172a;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .post-form h3 i {
            color: #3b82f6;
            font-size: 24px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .post-form input,
        .post-form textarea {
            width: 100%;
            padding: 14px 18px;
            border: 2px solid #e2e8f0;
            border-radius: 16px;
            font-family: 'Inter', sans-serif;
            font-size: 15px;
            transition: all 0.3s;
            background: #f8fafc;
        }

        .post-form input:focus,
        .post-form textarea:focus {
            border-color: #3b82f6;
            outline: none;
            background: white;
            box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.1);
        }

        /* Toggle switch */
        .toggle-container {
            display: flex;
            align-items: center;
            gap: 15px;
            margin: 20px 0;
        }

        .toggle-label {
            font-weight: 500;
            color: #475569;
        }

        .toggle-switch {
            position: relative;
            display: inline-block;
            width: 60px;
            height: 30px;
        }

        .toggle-switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }

        .toggle-slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: #e2e8f0;
            transition: .3s;
            border-radius: 30px;
            box-shadow: inset 0 1px 3px rgba(0,0,0,0.1);
        }

        .toggle-slider:before {
            position: absolute;
            content: "";
            height: 24px;
            width: 24px;
            left: 3px;
            bottom: 3px;
            background: white;
            transition: .3s;
            border-radius: 50%;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }

        input:checked + .toggle-slider {
            background: linear-gradient(135deg, #22c55e, #16a34a);
        }

        input:checked + .toggle-slider:before {
            transform: translateX(30px);
        }

        .toggle-status {
            font-weight: 600;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 13px;
        }

        .status-draft {
            color: #64748b;
        }

        .status-published {
            color: #22c55e;
        }

        .submit-btn {
            padding: 14px 30px;
            background: linear-gradient(135deg, #3b82f6, #8b5cf6);
            border: none;
            color: white;
            border-radius: 40px;
            cursor: pointer;
            font-weight: 600;
            font-size: 16px;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            box-shadow: 0 10px 20px rgba(59, 130, 246, 0.3);
            transition: all 0.3s;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 15px 25px rgba(59, 130, 246, 0.4);
        }

        /* POSTS */
        .posts-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .posts-header h3 {
            font-size: 22px;
            font-weight: 600;
            color: #0f172a;
        }

        .post-count {
            background: white;
            padding: 8px 16px;
            border-radius: 30px;
            font-size: 14px;
            color: #475569;
            border: 1px solid #e2e8f0;
        }

        .post {
            display: flex;
            background: white;
            margin-bottom: 20px;
            border-radius: 20px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.03);
            transition: all 0.3s;
            border: 1px solid #eef2f6;
            overflow: hidden;
        }

        .post:hover {
            transform: translateY(-3px);
            box-shadow: 0 20px 30px -10px rgba(0, 0, 0, 0.1);
        }

        /* AVATAR - ĐÃ THÊM NÚT FOLLOW */
        .avatar {
            width: 160px; /* Tăng width để chứa nút follow */
            background: linear-gradient(145deg, #f8fafc, #f1f5f9);
            text-align: center;
            padding: 20px 10px;
            border-right: 2px dashed #e2e8f0;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .avatar img {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            border: 4px solid white;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s;
            margin-bottom: 8px;
        }

        .post:hover .avatar img {
            transform: scale(1.05);
        }

        .avatar p {
            font-weight: 600;
            font-size: 14px;
            color: #0f172a;
            background: white;
            padding: 5px 12px;
            border-radius: 30px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.02);
            margin-bottom: 10px;
            max-width: 140px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        /* NÚT FOLLOW MỚI */
        .follow-btn {
            background: linear-gradient(135deg, #3b82f6, #8b5cf6);
            border: none;
            color: white;
            padding: 6px 15px;
            border-radius: 30px;
            font-size: 12px;
            font-weight: 600;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 5px;
            box-shadow: 0 4px 10px rgba(59, 130, 246, 0.3);
            transition: all 0.3s;
            border: 1px solid rgba(255, 255, 255, 0.2);
            width: fit-content;
        }

        .follow-btn i {
            font-size: 11px;
        }

        .follow-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 15px rgba(59, 130, 246, 0.4);
            background: linear-gradient(135deg, #2563eb, #7c3aed);
        }

        .follow-btn.following {
            background: linear-gradient(135deg, #10b981, #059669);
        }

        .follow-btn.following:hover {
            background: linear-gradient(135deg, #ef4444, #dc2626);
        }

        .follow-btn.following i {
            transform: rotate(0deg);
        }

        /* CONTENT */
        .content {
            flex: 1;
            padding: 25px;
        }

        .content h4 {
            margin: 0 0 12px 0;
            font-size: 18px;
            font-weight: 600;
            color: #0f172a;
            line-height: 1.4;
        }

        .meta {
            display: flex;
            gap: 20px;
            color: #64748b;
            font-size: 13px;
            margin-bottom: 15px;
            align-items: center;
            flex-wrap: wrap;
        }

        .meta i {
            margin-right: 5px;
            font-size: 12px;
        }

        .status-badge {
            padding: 4px 12px;
            border-radius: 40px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-published-badge {
            background: #dcfce7;
            color: #166534;
        }

        .status-draft-badge {
            background: #f1f5f9;
            color: #475569;
        }

        .post-body {
            color: #334155;
            line-height: 1.6;
            font-size: 15px;
            word-break: break-word;
        }

        /* Action buttons */
        .post-actions {
            margin-top: 15px;
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }

        .action-btn {
            background: none;
            border: none;
            color: #64748b;
            font-size: 14px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 5px;
            padding: 5px 10px;
            border-radius: 30px;
            transition: all 0.2s;
        }

        .action-btn:hover {
            background: #f1f5f9;
            color: #3b82f6;
        }

        .action-btn.like:hover {
            color: #ef4444;
        }

        hr {
            border: none;
            border-top: 2px dashed #e2e8f0;
            margin: 20px 0;
        }

        .avatar img {
            animation: avatarFadeIn 0.5s ease-out;
        }

        @keyframes avatarFadeIn {
            from {
                opacity: 0;
                transform: scale(0.8);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }
    </style>
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
        <!-- AVATAR VỚI NÚT FOLLOW -->
        <div class="avatar">
            <img src="https://i.pravatar.cc/150?u=${post.id != null ? post.id : loop.index + 1}" 
                 alt="avatar"
                 onerror="this.src='https://ui-avatars.com/api/?name=${user.username}&background=random&size=150'">
            <p>${user.username}</p>
            
            <!-- NÚT FOLLOW VỚI ICON + -->
            <button class="follow-btn" onclick="toggleFollow(this)">
                <i class="fas fa-plus"></i> Follow
            </button>
        </div>

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
    <div style="text-align: center; padding: 20px; color: #64748b;">
        <i class="fas fa-heart" style="color: #ef4444;"></i> 
        Cảm ơn bạn đã tham gia diễn đàn!
    </div>

</div>

<script>
    // Xử lý toggle switch
    const toggle = document.getElementById('statusToggle');
    const toggleText = document.getElementById('toggleStatusText');

    function updateToggleText() {
        if (toggle.checked) {
            toggleText.textContent = 'Published';
            toggleText.style.color = '#22c55e';
        } else {
            toggleText.textContent = 'Draft';
            toggleText.style.color = '#64748b';
        }
    }

    if (toggle) {
        toggle.addEventListener('change', updateToggleText);
        updateToggleText();
    }

    // Hàm xử lý nút Follow
    function toggleFollow(button) {
        button.classList.toggle('following');
        
        if (button.classList.contains('following')) {
            button.innerHTML = '<i class="fas fa-check"></i> Following';
        } else {
            button.innerHTML = '<i class="fas fa-plus"></i> Follow';
        }
    }

    // Tạo màu ngẫu nhiên cho avatar dự phòng
    function getRandomColor() {
        const letters = '0123456789ABCDEF';
        let color = '#';
        for (let i = 0; i < 6; i++) {
            color += letters[Math.floor(Math.random() * 16)];
        }
        return color;
    }

    // Xử lý lỗi avatar
    document.querySelectorAll('.avatar img').forEach(img => {
        img.addEventListener('error', function() {
            const name = this.alt || 'User';
            const color = getRandomColor().substring(1);
            this.src = 'https://ui-avatars.com/api/?name=' + encodeURIComponent(name) + '&background=' + color + '&color=fff&size=150';
        });
    });
</script>

</body>
</html>