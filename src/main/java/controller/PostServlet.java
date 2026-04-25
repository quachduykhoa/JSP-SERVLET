package controller;

import dao.PostDAO;
import dao.UserDAO;
import dao.FollowDAO;
import model.Post;
import model.User;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;
import java.util.ArrayList;

@WebServlet("/posts")
public class PostServlet extends HttpServlet {

    private PostDAO postDAO;
    private UserDAO userDAO;
    private FollowDAO followDAO;

    @Override
    public void init() throws ServletException {
        postDAO = new PostDAO();
        userDAO = new UserDAO();
        followDAO = new FollowDAO();
    }

    // ===================== GET FEED =====================
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        int userId = user.getId();

        // ===== Pagination =====
        int page = 1;
        int limit = 5;

        String pageParam = request.getParameter("page");
        if (pageParam != null && pageParam.matches("\\d+")) {
            page = Integer.parseInt(pageParam);
        }

        int offset = (page - 1) * limit;

        // ===== GET POSTS =====
        List<Post> posts = postDAO.getFeedPosts(userId, offset, limit);

        // ===== TỔNG SỐ BÀI VIẾT (để phân trang) =====
        int totalPosts = postDAO.countFeedPosts(userId);
        int totalPages = (int) Math.ceil((double) totalPosts / limit);

        // ===== SET ATTRIBUTES =====
        request.setAttribute("posts", posts);
        request.setAttribute("user", user);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        // ===== NGƯỜI DÙNG ĐƯỢC ĐỀ XUẤT =====
        List<User> allUsers = userDAO.getAllUsers();
        List<Integer> followingIds = followDAO.getFollowingList(userId);
        List<User> suggestedUsers = new ArrayList<>();

        for (User u : allUsers) {
            if (u.getId() != userId &&
                (followingIds == null || !followingIds.contains(u.getId()))) {
                suggestedUsers.add(u);
            }
        }

        request.setAttribute("suggestedUsers", suggestedUsers);

        request.getRequestDispatcher("/WEB-INF/views/posts.jsp")
               .forward(request, response);
    }

    // ===================== CREATE POST =====================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("doPost() được gọi");

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        String title = request.getParameter("title");
        String body = request.getParameter("body");
        String status = request.getParameter("status");

        if (status == null) {
            status = "draft";
        }

        if (title != null && !title.trim().isEmpty()) {
            postDAO.createPost(user.getId(), title, body, status);
        }

        response.sendRedirect("posts");
    }
}