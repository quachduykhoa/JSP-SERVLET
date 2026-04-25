package dao;
import model.*;
import java.sql.*;
import java.util.*;

public class PostDAO {
	public List<Post> getAllPosts() {
	    List<Post> posts = new ArrayList<>();

	    String sql =
	        "SELECT " +
	        "p.id, p.title, p.body, p.user_id, p.status, p.created_at, " +
	        "u.username, u.avatar, " +
	        "COUNT(DISTINCT l.user_id) AS like_count, " +
	        "COUNT(DISTINCT c.id) AS comment_count " +
	        "FROM posts p " +
	        "JOIN users u ON p.user_id = u.id " +
	        "LEFT JOIN likes l ON p.id = l.post_id " +
	        "LEFT JOIN comments c ON p.id = c.post_id " +
	        "GROUP BY p.id, u.username, u.avatar " +
	        "ORDER BY p.created_at DESC";

	    try (Connection conn = Database.getConnection();
	         PreparedStatement stmt = conn.prepareStatement(sql);
	         ResultSet rs = stmt.executeQuery()) {

	        while (rs.next()) {
	            Post p = new Post();

	            p.setId(rs.getInt("id"));
	            p.setTitle(rs.getString("title"));
	            p.setBody(rs.getString("body"));
	            p.setUserId(rs.getInt("user_id"));
	            p.setStatus(rs.getString("status"));
	            p.setCreatedAt(rs.getTimestamp("created_at"));

	            p.setUsername(rs.getString("username"));
	            p.setAvatar(rs.getString("avatar"));
	            p.setLikeCount(rs.getInt("like_count"));
	            p.setCommentCount(rs.getInt("comment_count"));

	            posts.add(p);
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return posts;
	}
    
	public boolean createPost(int userId, String title, String body, String status) {
	    String sql = "INSERT INTO posts(title, body, user_id, status, created_at) VALUES(?,?,?,?,NOW())";

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

	public List<Post> getFeedPosts(int userId, int offset, int limit) {
	    List<Post> posts = new ArrayList<>();

	    String sql =
	        "SELECT " +
	        "p.id, p.title, p.body, p.user_id, p.status, p.created_at, " +
	        "u.username, u.avatar, " +
	        "COUNT(DISTINCT l.user_id) AS like_count, " +
	        "COUNT(DISTINCT c.id) AS comment_count, " +
	        "(COUNT(DISTINCT l.user_id) + COUNT(DISTINCT c.id)) AS total_interaction " + // Tính tổng tương tác
	        "FROM posts p " +
	        "JOIN users u ON p.user_id = u.id " +
	        "LEFT JOIN likes l ON p.id = l.post_id " +
	        "LEFT JOIN comments c ON p.id = c.post_id " +
	        "WHERE (p.status = 'published' OR p.user_id = ?) " +
	        "AND (p.user_id = ? OR p.user_id IN " +
	        "  (SELECT followed_user_id FROM follows WHERE following_user_id = ?)) " +
	        "AND DATE(p.created_at) = CURDATE() " + 
	        "GROUP BY p.id, u.username, u.avatar " +
	        "ORDER BY total_interaction DESC, p.created_at DESC " + 
	        "LIMIT ? OFFSET ?";

	    try (Connection conn = Database.getConnection();
	         PreparedStatement stmt = conn.prepareStatement(sql)) {

	        stmt.setInt(1, userId);
	        stmt.setInt(2, userId);
	        stmt.setInt(3, userId);
	        stmt.setInt(4, limit);
	        stmt.setInt(5, offset);

	        ResultSet rs = stmt.executeQuery();

	        while (rs.next()) {
	            Post p = new Post();
	            p.setId(rs.getInt("id"));
	            p.setTitle(rs.getString("title"));
	            p.setBody(rs.getString("body"));
	            p.setUserId(rs.getInt("user_id"));
	            p.setStatus(rs.getString("status"));
	            p.setCreatedAt(rs.getTimestamp("created_at"));
	            p.setUsername(rs.getString("username"));
	            p.setAvatar(rs.getString("avatar"));
	            p.setLikeCount(rs.getInt("like_count"));
	            p.setCommentCount(rs.getInt("comment_count"));

	            posts.add(p);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return posts;
	}
	
	public int countFeedPosts(int userId) {
	    String sql =
	        "SELECT COUNT(*) FROM posts p " +
	        "WHERE (p.status = 'published' OR p.user_id = ?) " + 
	        "AND (p.user_id = ? OR p.user_id IN " +
	        "(SELECT followed_user_id FROM follows WHERE following_user_id = ?))";

	    try (Connection conn = Database.getConnection();
	         PreparedStatement stmt = conn.prepareStatement(sql)) {

	        stmt.setInt(1, userId);
	        stmt.setInt(2, userId);
	        stmt.setInt(3, userId);

	        ResultSet rs = stmt.executeQuery();
	        if (rs.next()) {
	            return rs.getInt(1);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return 0;
	}
}