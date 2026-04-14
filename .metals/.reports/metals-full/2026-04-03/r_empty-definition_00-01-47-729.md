error id: file:///E:/OOSD/test/JSP-SERVLET/src/main/java/controller/FollowServlet.java:_empty_/WebServlet#
file:///E:/OOSD/test/JSP-SERVLET/src/main/java/controller/FollowServlet.java
empty definition using pc, found symbol in pc: _empty_/WebServlet#
empty definition using semanticdb
empty definition using fallback
non-local guesses:

offset: 187
uri: file:///E:/OOSD/test/JSP-SERVLET/src/main/java/controller/FollowServlet.java
text:
```scala
package controller;
import dao.FollowDAO;
import model.User;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@@@WebServlet("/follow")
public class FollowServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        int followedUserId = Integer.parseInt(request.getParameter("userId"));
        
        if (user != null) {
            new FollowDAO().follow(user.getId(), followedUserId);
        }
        response.sendRedirect("users");
    }
}
```


#### Short summary: 

empty definition using pc, found symbol in pc: _empty_/WebServlet#