package com.mangestudent.signup;
import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter(urlPatterns = {
        "/adminDashboard.jsp",
        "/teacherDashboard.jsp",
        "/studentDashboard.jsp"
})
public class AuthFilter implements Filter {

    public void init(FilterConfig filterConfig) throws ServletException {}

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);

        String uri = req.getRequestURI();

        if (session == null ||
            session.getAttribute("username") == null ||
            session.getAttribute("role") == null) {

            res.sendRedirect("login.jsp");
            return;
        }

        String role = session.getAttribute("role").toString();

        // Role-based page access
        if (uri.contains("adminDashboard.jsp") && !role.equals("admin")) {
            res.sendRedirect("login.jsp");
            return;
        }

        if (uri.contains("teacherDashboard.jsp") && !role.equals("teacher")) {
            res.sendRedirect("login.jsp");
            return;
        }

        if (uri.contains("studentDashboard.jsp") && !role.equals("student")) {
            res.sendRedirect("login.jsp");
            return;
        }

        // User is authorized
        chain.doFilter(request, response);
    }

    public void destroy() {}
}

