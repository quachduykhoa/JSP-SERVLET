error id: file:///E:/OOSD/test/JSP-SERVLET/src/main/java/controller/PostServlet.java:_empty_/FollowDAO#getFollowingList#
file:///E:/OOSD/test/JSP-SERVLET/src/main/java/controller/PostServlet.java
empty definition using pc, found symbol in pc: _empty_/FollowDAO#getFollowingList#
empty definition using semanticdb
empty definition using fallback
non-local guesses:

offset: 1280
uri: file:///E:/OOSD/test/JSP-SERVLET/src/main/java/controller/PostServlet.java
text:
```scala
package controller;
import dao.PostDAO;
import model.Post;
import model.User;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

import dao.UserDAO;
import dao.FollowDAO;
import java.util.ArrayList;

@WebServlet("/posts")
public class PostServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Nếu chưa đăng nhập thì quay lại trang login
        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        int userId = user.getId();

        // 1. Lấy danh sách bài viết (mình + người mình follow)
        PostDAO postDAO = new PostDAO();
        List<Post> posts = postDAO.getFeedPosts(userId);
        request.setAttribute("posts", posts);

        // 2. Lấy danh sách user để gợi ý follow
        UserDAO userDAO = new UserDAO();
        FollowDAO followDAO = new FollowDAO();

        List<User> allUsers = userDAO.getAllUsers();
        List<Integer> followingIds = followDAO.@@getFollowingList(userId);

        List<User> suggestedUsers = new ArrayList<>();
        for (User u : allUsers) {
            // Bỏ chính mình và những người đã follow rồi
            if (u.getId() != userId && !followingIds.contains(u.getId())) {
                suggestedUsers.add(u);
            }
        }

        request.setAttribute("suggestedUsers", suggestedUsers);

        // 3. Forward sang JSP
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
```


#### Short summary: 

empty definition using pc, found symbol in pc: _empty_/FollowDAO#getFollowingList#