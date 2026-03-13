package controller;

import dao.UserDAO;
import dao.FollowDAO;
import model.User;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/users")
public class UsersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        // Nếu chưa đăng nhập, quay lại trang login
        if (currentUser == null) {
            response.sendRedirect("login");
            return;
        }

        UserDAO userDAO = new UserDAO();
        FollowDAO followDAO = new FollowDAO();

        // Lấy toàn bộ user từ DB
        List<User> users = userDAO.getAllUsers();
        // Lấy danh sách id những người mà currentUser đang follow
        List<Integer> followingIds = followDAO.getFollowingList(currentUser.getId());

        // Đưa data cho JSP
        request.setAttribute("users", users);
        request.setAttribute("followingIds", followingIds);
        // user hiện tại đã có sẵn trong session, JSP đang dùng `${user}`

        request.getRequestDispatcher("/WEB-INF/views/users.jsp").forward(request, response);
    }
}