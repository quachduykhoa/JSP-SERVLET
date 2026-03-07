package controller;
import dao.PostDAO;
import model.Post;
import model.User;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/posts")
public class PostServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Post> posts = new PostDAO().getAllPosts();
        request.setAttribute("posts", posts);
        request.getRequestDispatcher("/WEB-INF/views/posts.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        String title = request.getParameter("title");
        String body = request.getParameter("body");
        String status = request.getParameter("status");
        
        if (user != null && title != null) {
            new PostDAO().createPost(user.getId(), title, body, status);
        }
        response.sendRedirect("posts");
    }
}