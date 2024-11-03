package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.File;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.nio.file.Files;

@WebServlet("/resources/*")
public class ResourcesHandler extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String resourcePath = request.getPathInfo(); // Lấy phần đường dẫn của tài nguyên
        String resourceFilePath = getServletContext().getRealPath("/resources" + resourcePath);

        File resourceFile = new File(resourceFilePath);
        if (resourceFile.exists()) {
            response.setContentType(getServletContext().getMimeType(resourceFile.getName()));
            response.setContentLength((int) resourceFile.length());
            Files.copy(resourceFile.toPath(), response.getOutputStream());
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
   
    public static void forwardToClientPage(HttpServletRequest request, HttpServletResponse response, String page)
            throws ServletException, IOException {
        String viewPath = "/WEB-INF/view/client" + page + ".jsp";
        request.getRequestDispatcher(viewPath).forward(request, response);
    }
    
    public static void forwardToAdminPage(HttpServletRequest request, HttpServletResponse response, String page)
            throws ServletException, IOException {
        String viewPath = "/WEB-INF/view/admin" + page + ".jsp";
        request.getRequestDispatcher(viewPath).forward(request, response);
    }

}
