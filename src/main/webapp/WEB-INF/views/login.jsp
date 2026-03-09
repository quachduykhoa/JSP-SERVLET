<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập - Diễn Đàn Cộng Đồng</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --primary: #2563eb;
            --primary-light: #3b82f6;
            --secondary: #7c3aed;
            --text-dark: #0f172a;
            --text-light: #475569;
            --white: #ffffff;
            --error-bg: #fee2e2;
            --error-text: #b91c1c;
            --shadow: 0 20px 40px -10px rgba(0, 0, 0, 0.2);
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(145deg, #f1f5f9 0%, #e6edf5 100%);
            height: 100vh;
            display: flex;
            overflow: hidden;
        }

        /* Left side - Image slideshow (chiếm 75% màn hình) */
        .slideshow-container {
            flex: 3;
            position: relative;
            overflow: hidden;
            background: #0f172a;
            box-shadow: inset 0 0 50px rgba(0, 0, 0, 0.4);
        }

        .slideshow {
            width: 100%;
            height: 100%;
            position: relative;
        }

        .slide {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            opacity: 0;
            transition: opacity 1.5s ease-in-out;
            display: flex;
            align-items: flex-end;
            padding: 60px;
        }

        .slide.active {
            opacity: 1;
        }

        .slide::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, rgba(15, 23, 42, 0.8) 0%, rgba(15, 23, 42, 0.4) 60%, transparent 100%);
            z-index: 1;
        }

        .slide-content {
            position: relative;
            z-index: 2;
            color: white;
            max-width: 600px;
            transform: translateY(30px);
            transition: transform 1s ease 0.5s;
        }

        .slide.active .slide-content {
            transform: translateY(0);
        }

        .slide-content h3 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
        }

        .slide-content p {
            font-size: 1.1rem;
            line-height: 1.6;
            opacity: 0.95;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.4);
        }

        /* Indicators */
        .indicators {
            position: absolute;
            bottom: 30px;
            right: 30px;
            z-index: 10;
            display: flex;
            gap: 12px;
        }

        .indicator {
            width: 12px;
            height: 12px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.5);
            cursor: pointer;
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }

        .indicator.active {
            background: var(--primary);
            transform: scale(1.2);
            box-shadow: 0 0 20px var(--primary);
            border-color: white;
        }

        /* Right side - Login form */
        .login-wrapper {
            flex: 1;
            min-width: 420px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: var(--white);
            box-shadow: var(--shadow);
            position: relative;
            overflow-y: auto;
            border-radius: 40px 0 0 40px;
        }

        .login-container {
            width: 100%;
            max-width: 400px;
            padding: 40px 30px;
        }

        .brand {
            margin-bottom: 40px;
            text-align: center;
        }

        /* LOGO GIỐNG TRONG POST */
        .brand .logo {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            margin: 0 auto 20px;
            background: linear-gradient(135deg, #3b82f6, #8b5cf6);
            width: 80px;
            height: 80px;
            border-radius: 24px;
            box-shadow: 0 10px 25px rgba(59, 130, 246, 0.4);
        }

        .brand .logo i {
            font-size: 40px;
            color: white;
            background: none;
            -webkit-background-clip: unset;
            -webkit-text-fill-color: white;
        }

        .brand .logo-text {
            display: block;
            font-size: 28px;
            font-weight: 700;
            background: linear-gradient(135deg, #3b82f6, #8b5cf6);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-top: 5px;
        }

        .brand h2 {
            color: var(--text-dark);
            font-size: 26px;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .brand p {
            color: var(--text-light);
            font-size: 15px;
        }

        .error-box {
            background: var(--error-bg);
            color: var(--error-text);
            padding: 14px 16px;
            border-radius: 12px;
            margin-bottom: 24px;
            font-size: 14px;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 10px;
            border-left: 4px solid var(--error-text);
        }

        .input-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-size: 13px;
            font-weight: 600;
            color: var(--text-dark);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        input {
            width: 100%;
            padding: 14px 18px;
            border: 2px solid #e2e8f0;
            border-radius: 14px;
            box-sizing: border-box;
            outline: none;
            transition: all 0.3s ease;
            font-size: 15px;
            background: #f8fafc;
        }

        input:focus {
            border-color: var(--primary);
            background: var(--white);
            box-shadow: 0 0 0 4px rgba(37, 99, 235, 0.1);
        }

        button {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: white;
            border: none;
            border-radius: 14px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            box-shadow: 0 10px 20px rgba(37, 99, 235, 0.3);
            transition: all 0.3s ease;
            margin-top: 10px;
        }

        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 15px 25px rgba(37, 99, 235, 0.4);
        }

        .footer-text {
            margin-top: 30px;
            text-align: center;
            font-size: 14px;
            color: var(--text-light);
        }

        .footer-text a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s;
        }

        .footer-text a:hover {
            color: var(--secondary);
        }

        @media (max-width: 1024px) {
            .slideshow-container { flex: 2; }
        }

        @media (max-width: 768px) {
            body { flex-direction: column; }
            .slideshow-container { flex: 1; min-height: 300px; }
            .login-wrapper { min-width: 100%; border-radius: 40px 40px 0 0; }
        }
    </style>
</head>
<body>

    <!-- Left side: Slideshow với 5 hình ảnh diễn đàn -->
    <div class="slideshow-container">
        <div class="slideshow">
            <!-- Slide 1: Cộng đồng sôi động -->
            <div class="slide active" style="background-image: url('https://images.pexels.com/photos/3184291/pexels-photo-3184291.jpeg?auto=compress&cs=tinysrgb&w=1920&h=1080&fit=crop');">
                <div class="slide-content">
                    <h3>Cộng đồng sôi động</h3>
                    <p>Hơn 50.000 thành viên đang thảo luận sôi nổi mỗi ngày. Tham gia ngay để kết nối với những người cùng đam mê!</p>
                </div>
            </div>
            <!-- Slide 2: Chia sẻ kiến thức -->
            <div class="slide" style="background-image: url('https://images.pexels.com/photos/5428830/pexels-photo-5428830.jpeg?auto=compress&cs=tinysrgb&w=1920&h=1080&fit=crop');">
                <div class="slide-content">
                    <h3>Chia sẻ kiến thức</h3>
                    <p>Hàng ngàn bài viết chất lượng từ các chuyên gia và thành viên giàu kinh nghiệm trong mọi lĩnh vực.</p>
                </div>
            </div>
            <!-- Slide 3: Hỏi đáp nhanh chóng -->
            <div class="slide" style="background-image: url('https://images.pexels.com/photos/3769021/pexels-photo-3769021.jpeg?auto=compress&cs=tinysrgb&w=1920&h=1080&fit=crop');">
                <div class="slide-content">
                    <h3>Hỏi đáp nhanh chóng</h3>
                    <p>Có thắc mắc? Đặt câu hỏi và nhận câu trả lời từ cộng đồng chỉ trong vài phút. Luôn sẵn sàng giúp đỡ!</p>
                </div>
            </div>
            <!-- Slide 4: Giao lưu, kết bạn -->
            <div class="slide" style="background-image: url('https://images.pexels.com/photos/4050319/pexels-photo-4050319.jpeg?auto=compress&cs=tinysrgb&w=1920&h=1080&fit=crop');">
                <div class="slide-content">
                    <h3>Giao lưu, kết bạn</h3>
                    <p>Không chỉ là diễn đàn, đây còn là nơi kết nối những con người, xây dựng những mối quan hệ bền vững.</p>
                </div>
            </div>
            <!-- Slide 5: Sự kiện & hoạt động -->
            <div class="slide" style="background-image: url('https://images.pexels.com/photos/2774556/pexels-photo-2774556.jpeg?auto=compress&cs=tinysrgb&w=1920&h=1080&fit=crop');">
                <div class="slide-content">
                    <h3>Sự kiện & hoạt động</h3>
                    <p>Tham gia các sự kiện online/offline, workshop, talkshow với những diễn giả nổi tiếng hàng tháng.</p>
                </div>
            </div>
        </div>

        <!-- Slide indicators -->
        <div class="indicators">
            <div class="indicator active" onclick="currentSlide(0)"></div>
            <div class="indicator" onclick="currentSlide(1)"></div>
            <div class="indicator" onclick="currentSlide(2)"></div>
            <div class="indicator" onclick="currentSlide(3)"></div>
            <div class="indicator" onclick="currentSlide(4)"></div>
        </div>
    </div>

    <!-- Right side: Login form -->
    <div class="login-wrapper">
        <div class="login-container">
            <div class="brand">
                <div class="logo">
                    <i class="fas fa-comments"></i>
                </div>
                <span class="logo-text">ConnectHub</span>
                <h2>Chào mừng trở lại!</h2>
                <p>Đăng nhập để tham gia thảo luận</p>
            </div>

            <% if (request.getAttribute("error") != null) { %>
                <div class="error-box">
                    ⚠️ <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <form action="login" method="post">
                <div class="input-group">
                    <label for="username">Tên đăng nhập</label>
                    <input type="text" id="username" name="username" placeholder="Nhập tên đăng nhập của bạn" required>
                </div>
                
                <div class="input-group">
                    <label for="password">Mật khẩu</label>
                    <input type="password" id="password" name="password" placeholder="••••••••" required>
                </div>

                <button type="submit">Đăng Nhập Vào Diễn Đàn</button>
            </form>

            <p class="footer-text">
                Chưa có tài khoản? <a href="#">Đăng ký thành viên</a>
            </p>
        </div>
    </div>

    <script>
        let slides = document.querySelectorAll('.slide');
        let indicators = document.querySelectorAll('.indicator');
        let currentIndex = 0;
        let slideInterval;

        function showSlide(index) {
            if (index < 0) index = slides.length - 1;
            if (index >= slides.length) index = 0;
            
            slides.forEach(slide => slide.classList.remove('active'));
            indicators.forEach(ind => ind.classList.remove('active'));
            
            slides[index].classList.add('active');
            indicators[index].classList.add('active');
            
            currentIndex = index;
        }

        function nextSlide() {
            showSlide(currentIndex + 1);
        }

        window.currentSlide = function(index) {
            showSlide(index);
            resetInterval();
        }

        function resetInterval() {
            clearInterval(slideInterval);
            slideInterval = setInterval(nextSlide, 5000);
        }

        slideInterval = setInterval(nextSlide, 5000);

        const slideshowContainer = document.querySelector('.slideshow-container');
        slideshowContainer.addEventListener('mouseenter', () => {
            clearInterval(slideInterval);
        });

        slideshowContainer.addEventListener('mouseleave', () => {
            slideInterval = setInterval(nextSlide, 5000);
        });
    </script>

    <!-- Ảnh từ Pexels (miễn phí sử dụng) -->
    <div style="display: none;">Photos provided by Pexels</div>

</body>
</html>