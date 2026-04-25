📋 HƯỚNG DẪN CHẠY DỰ ÁN JSP-SERVLET
Bước 1: Clone project từ kho lưu trữ về máy cục bộ.

Bước 2: Nhấn vào tab Servers ở khu vực phía dưới (nằm cùng thanh ngang với tab Console/Problems).

Bước 3: Click vào dòng chữ màu xanh: "No servers are available. Click this link to create a new server..."

Bước 4: Chọn thư mục Apache -> Chọn phiên bản Tomcat v9.0 -> Nhấn Finish.

```sql
-- 1. Tạo Database nếu chưa tồn tại
USE employees;

-- 2. Tạo bảng users
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE,
    password VARCHAR(100),
    role VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Tạo bảng posts
CREATE TABLE IF NOT EXISTS posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    body TEXT,
    user_id INT,
    status VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- 4. Tạo bảng follows
CREATE TABLE IF NOT EXISTS follows (
    following_user_id INT,
    followed_user_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (following_user_id, followed_user_id),
    FOREIGN KEY (following_user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (followed_user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- 5. Chèn dữ liệu mẫu
INSERT IGNORE INTO users(id, username, password, role) VALUES
(1, 'admin', '123', 'admin'),
(2, 'user1', '123', 'user');

INSERT IGNORE INTO posts(id, title, body, user_id, status) VALUES
(1, 'Bài viết 1', 'Nội dung demo', 1, 'public'),
(2, 'Bài viết 2', 'Hello world', 2, 'public');
```
