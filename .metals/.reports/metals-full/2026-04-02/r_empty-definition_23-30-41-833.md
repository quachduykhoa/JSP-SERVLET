error id: file:///E:/OOSD/test/JSP-SERVLET/src/main/java/controller/LoginServlet.java:dao/UserDAO#
file:///E:/OOSD/test/JSP-SERVLET/src/main/java/controller/LoginServlet.java
empty definition using pc, found symbol in pc: dao/UserDAO#
empty definition using semanticdb
empty definition using fallback
non-local guesses:

offset: 32
uri: file:///E:/OOSD/test/JSP-SERVLET/src/main/java/controller/LoginServlet.java
text:
```scala
package controller;
import dao.@@UserDAO;
import model.User;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        User user = new UserDAO().login(username, password);
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            response.sendRedirect("posts");
        } else {
            request.setAttribute("error", "Sai tên đăng nhập hoặc mật khẩu!");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }
}
```


#### Short summary: 

empty definition using pc, found symbol in pc: dao/UserDAO#