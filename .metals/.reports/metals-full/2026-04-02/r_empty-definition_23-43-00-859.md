error id: file:///E:/OOSD/test/JSP-SERVLET/src/main/java/config/DatabaseInitializer.java:model/Database#
file:///E:/OOSD/test/JSP-SERVLET/src/main/java/config/DatabaseInitializer.java
empty definition using pc, found symbol in pc: model/Database#
empty definition using semanticdb
empty definition using fallback
non-local guesses:

offset: 169
uri: file:///E:/OOSD/test/JSP-SERVLET/src/main/java/config/DatabaseInitializer.java
text:
```scala
package config;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import model.@@Database;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.Statement;
import java.util.stream.Collectors;

@WebListener
public class DatabaseInitializer implements ServletContextListener {

    @SuppressWarnings("unused")
	@Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("Đang kiểm tra và khởi tạo Database...");
        
        try (Connection conn = Database.getConnection();
             BufferedReader reader = new BufferedReader(new InputStreamReader(
                     sce.getServletContext().getResourceAsStream("/WEB-INF/setup.sql")))) {
            
            if (reader == null) {
                System.out.println("Không tìm thấy file setup.sql");
                return;
            }

            String sql = reader.lines().collect(Collectors.joining("\n"));
            
            String[] queries = sql.split(";");
            
            Statement st = conn.createStatement();
            for (String query : queries) {
                if (!query.trim().isEmpty()) {
                    st.execute(query);
                }
            }
            System.out.println("Khởi tạo Database thành công!");
            
        } catch (Exception e) {
            System.err.println("Lỗi khi tự động khởi tạo DB: " + e.getMessage());
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
    	
    }
}
```


#### Short summary: 

empty definition using pc, found symbol in pc: model/Database#