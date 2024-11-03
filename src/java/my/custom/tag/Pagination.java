/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/TagHandler.java to edit this template
 */
package my.custom.tag;

import jakarta.servlet.jsp.JspWriter;
import jakarta.servlet.jsp.JspException;
import jakarta.servlet.jsp.tagext.JspFragment;
import jakarta.servlet.jsp.tagext.SimpleTagSupport;
import java.io.IOException;

/**
 *
 * @author Ngo Duong Hoang Chau
 */
public class Pagination extends SimpleTagSupport {

    private int totalPages;
    private int currentPage;
    private String url;

    /**
     * Called by the container to invoke this tag. The implementation of this
     * method is provided by the tag library developer, and handles all tag
     * processing, body iteration, etc.
     */
    @Override
    public void doTag() throws JspException, IOException {
        JspWriter out = getJspContext().getOut();

        // Hiển thị nút "Previous"
        if (currentPage > 1) {
            out.print("<a href='" + url + "&page=" + (currentPage - 1) + "' class='btn btn-outline-primary'>Previous</a> ");
        }

        // Hiển thị các trang
        for (int i = 1; i <= totalPages; i++) {
            if (i == currentPage) {
                out.print("<span class='btn btn-secondary'>" + i + "</span> ");
            } else {
                out.print("<a href='" + url + "&page=" + i + "' class='btn btn-outline-primary'>" + i + "</a> ");
            }
        }

        // Hiển thị nút "Next"
        if (currentPage < totalPages) {
            out.print("<a href='" + url + "&page=" + (currentPage + 1) + "' class='btn btn-outline-primary'>Next</a>");
        }
    }

    public void setTotalPages(int totalPages) {
        this.totalPages = totalPages;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    public void setUrl(String url) {
        this.url = url;
    }
    
}
