package dao;
import model.*;
import java.sql.*;
import java.util.*;

public class PostDAO {
    public List<Post> getAllPosts() {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT * FROM posts ORDER BY created_at DESC";
        try (Connection conn = Database.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                posts.add(new Post(rs.getInt("id"), rs.getString("title"),
                                  rs.getString("body"), rs.getInt("user_id"),
                                  rs.getString("status"), rs.getTimestamp("created_at")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }
    
    public boolean createPost(int userId, String title, String body, String status) {
        String sql = "INSERT INTO posts(title, body, user_id, status) VALUES(?,?,?,?)";
        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, title);
            stmt.setString(2, body);
            stmt.setInt(3, userId);
            stmt.setString(4, status);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}