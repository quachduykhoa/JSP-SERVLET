# 📋 HƯỚNG DẪN CHẠY DỰ ÁN JSP-SERVLET

Bước 1: Downloand tomcat9 trước https://tomcat.apache.org/download-90.cgi

Bước 2: Clone project từ kho lưu trữ về máy cục bộ.

Bước 3: Nhấn vào tab Servers ở khu vực phía dưới (nằm cùng thanh ngang với tab Console/Problems).

Bước 4: Click vào dòng chữ màu xanh: "No servers are available. Click this link to create a new server..."

Bước 5: Chọn thư mục Apache -> Chọn phiên bản Tomcat v9.0 -> Nhấn Finish.

```
-- =========================
-- 1. DATABASE
-- =========================
USE employees;

-- =========================
-- 2. USERS
-- =========================
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE,
    password VARCHAR(100),
    role VARCHAR(20) DEFAULT 'user',
    avatar VARCHAR(255) DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- 3. POSTS
-- =========================
CREATE TABLE IF NOT EXISTS posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    body TEXT,
    user_id INT,
    status VARCHAR(20) DEFAULT 'published',
    file_path VARCHAR(255) DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- =========================
-- 4. COMMENTS 
-- =========================
CREATE TABLE IF NOT EXISTS comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT,
    user_id INT,
    content TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- =========================
-- 5. LIKES
-- =========================
CREATE TABLE IF NOT EXISTS likes (
    user_id INT,
    post_id INT,
    PRIMARY KEY (user_id, post_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE
);

-- =========================
-- 6. FOLLOWS
-- =========================
CREATE TABLE IF NOT EXISTS follows (
    following_user_id INT,
    followed_user_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (following_user_id, followed_user_id),
    FOREIGN KEY (following_user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (followed_user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- =========================
-- 7. DATA TEST 
-- =========================
INSERT IGNORE INTO users(id, username, password, role, avatar) VALUES
(1, 'admin', '123', 'admin', NULL),
(2, 'user1', '123', 'user', NULL),
(3, 'user2', '123', 'user', NULL);

INSERT IGNORE INTO posts(id, title, body, user_id, status, file_path) VALUES
(1, 'Bài viết 1', 'Nội dung demo', 1, 'published', NULL),
(2, 'Bài viết 2', 'Hello world', 2, 'published', NULL),
(3, 'Tin tức HOT', 'Admin chia sẻ tin tức quan trọng!', 1, 'published', NULL);

-- comments demo
INSERT IGNORE INTO comments(id, post_id, user_id, content) VALUES
(1, 1, 2, 'Hay quá!'),
(2, 1, 3, 'Bài viết hữu ích');

-- likes demo
INSERT IGNORE INTO likes(user_id, post_id) VALUES
(2, 2),
(3, 2);
```
