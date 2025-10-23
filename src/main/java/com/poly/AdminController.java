package com.poly;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.poly.entities.NewsEntity;
import com.poly.entities.Users;
import com.poly.services.NewsServices;
import com.poly.services.UsersServices;

@WebServlet({"/dashboard", "/admin/users", "/admin/news", "/admin/categories", "/admin/roles"})
public class AdminController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final UsersServices usersServices = new UsersServices();
    private final NewsServices newsServices = new NewsServices();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        Users currentUser = (Users) session.getAttribute("user");
        if (!"ADMIN".equals(currentUser.getRole())) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Chỉ ADMIN mới truy cập trang quản trị!");
            return;
        }

        String path = req.getServletPath();
        switch (path) {
            case "/dashboard":
                showDashboard(req, resp);
                break;
            case "/admin/users":
                showUsers(req, resp);
                break;
            case "/admin/news":
                showNews(req, resp);
                break;
            case "/admin/categories":
                showCategories(req, resp);
                break;
            case "/admin/roles":
                showRoles(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/dashboard");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        Users currentUser = (Users) session.getAttribute("user");
        if (!"ADMIN".equals(currentUser.getRole())) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Chỉ ADMIN mới truy cập trang quản trị!");
            return;
        }

        String path = req.getServletPath();
        if ("/admin/users".equals(path)) {
            String action = req.getParameter("action");
            if ("update".equals(action)) {
                handleUpdateUser(req, resp);
            } else if ("delete".equals(action)) {
                handleDeleteUser(req, resp);
            } else {
                handleCreateUser(req, resp);
            }
        } else if ("/admin/categories".equals(path)) {
            String action = req.getParameter("action");
            if ("create".equals(action)) {
                handleCreateCategory(req, resp);
            } else if ("update".equals(action)) {
                handleUpdateCategory(req, resp);
            } else if ("delete".equals(action)) {
                handleDeleteCategory(req, resp);
            } else {
                showCategories(req, resp);
            }
        } else if ("/admin/roles".equals(path)) {
            handleUpdateRole(req, resp);
        } else {
            doGet(req, resp);
        }
    }

    private void showDashboard(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Simple counts
        List<Users> users = usersServices.listAllUsers();
        List<NewsEntity> allNews = newsServices.getAllActiveNews();
        req.setAttribute("usersCount", users.size());
        req.setAttribute("newsCount", allNews.size());
        req.getRequestDispatcher("/admin/dashboard.jsp").forward(req, resp);
    }

    private void showUsers(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Users> users = usersServices.listAllUsers();
        req.setAttribute("users", users);
        req.getRequestDispatcher("/admin/users.jsp").forward(req, resp);
    }

    private void showNews(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Admin: list all news (active and inactive)
        List<NewsEntity> newsList = newsServices.getAllNews();
        req.setAttribute("newsList", newsList);
        req.getRequestDispatcher("/admin/news.jsp").forward(req, resp);
    }

    private void showCategories(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("categories", newsServices.getAllCategoriesAdmin());
        req.getRequestDispatcher("/admin/categories.jsp").forward(req, resp);
    }

    private void showRoles(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("users", usersServices.listAllUsers());
        req.getRequestDispatcher("/admin/roles.jsp").forward(req, resp);
    }

    private void handleCreateUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String email = req.getParameter("email");
        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");
        String birthDate = req.getParameter("birthDate");
        String role = req.getParameter("role");
        String isActiveStr = req.getParameter("isActive");

        Users user = new Users();
        user.setUsername(username);
        user.setPassword(password);
        user.setEmail(email);
        user.setFullname(fullname);
        user.setPhone(phone);
        user.setAddress(address);
        if (birthDate != null && !birthDate.trim().isEmpty()) {
            try { user.setBirthDate(java.sql.Date.valueOf(birthDate)); } catch (Exception ignored) {}
        }
        user.setRole(role != null && !role.isEmpty() ? role : "USER");
        user.setActive("on".equalsIgnoreCase(isActiveStr) || "1".equals(isActiveStr) || "true".equalsIgnoreCase(isActiveStr));

        boolean success = usersServices.createUser(user);
        if (success) {
            req.setAttribute("success", "Tạo người dùng thành công");
        } else {
            req.setAttribute("error", "Tạo người dùng thất bại");
        }
        showUsers(req, resp);
    }

    private void handleUpdateUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Users user = new Users();
        user.setId(id);
        user.setFullname(req.getParameter("fullname"));
        user.setEmail(req.getParameter("email"));
        user.setPhone(req.getParameter("phone"));
        user.setAddress(req.getParameter("address"));
        String birthDate = req.getParameter("birthDate");
        if (birthDate != null && !birthDate.trim().isEmpty()) {
            try { user.setBirthDate(java.sql.Date.valueOf(birthDate)); } catch (Exception ignored) {}
        }
        // Preserve existing role if not provided in this screen
        String roleParam = req.getParameter("role");
        if (roleParam == null || roleParam.trim().isEmpty()) {
            Users existed = usersServices.getUserById(id);
            user.setRole(existed != null ? existed.getRole() : "USER");
        } else {
            user.setRole(roleParam);
        }
        user.setActive("on".equalsIgnoreCase(req.getParameter("isActive")) || "1".equals(req.getParameter("isActive")) || "true".equalsIgnoreCase(req.getParameter("isActive")));
        boolean success = usersServices.updateUserAdmin(user);
        req.setAttribute(success ? "success" : "error", success ? "Cập nhật người dùng thành công" : "Cập nhật người dùng thất bại");
        showUsers(req, resp);
    }

    private void handleDeleteUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        boolean success = usersServices.deleteUser(id);
        req.setAttribute(success ? "success" : "error", success ? "Đã vô hiệu hóa người dùng" : "Xóa người dùng thất bại");
        showUsers(req, resp);
    }

    private void handleCreateCategory(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        com.poly.entities.Category c = new com.poly.entities.Category();
        c.setName(req.getParameter("name"));
        c.setDescription(req.getParameter("description"));
        boolean success = newsServices.createCategory(c);
        req.setAttribute(success ? "success" : "error", success ? "Tạo danh mục thành công" : "Tạo danh mục thất bại");
        showCategories(req, resp);
    }

    private void handleUpdateCategory(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        com.poly.entities.Category c = new com.poly.entities.Category();
        c.setId(Integer.parseInt(req.getParameter("id")));
        c.setName(req.getParameter("name"));
        c.setDescription(req.getParameter("description"));
        c.setActive("on".equalsIgnoreCase(req.getParameter("isActive")) || "1".equals(req.getParameter("isActive")) || "true".equalsIgnoreCase(req.getParameter("isActive")));
        boolean success = newsServices.updateCategory(c);
        req.setAttribute(success ? "success" : "error", success ? "Cập nhật danh mục thành công" : "Cập nhật danh mục thất bại");
        showCategories(req, resp);
    }

    private void handleDeleteCategory(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        boolean success = newsServices.deleteCategoryHard(id);
        req.setAttribute(success ? "success" : "error", success ? "Đã xóa danh mục" : "Xóa danh mục thất bại (có thể đang được sử dụng bởi bài viết)");
        showCategories(req, resp);
    }

    private void handleUpdateRole(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        String role = req.getParameter("role");
        boolean success = usersServices.updateUserRole(id, role);
        req.setAttribute(success ? "success" : "error", success ? "Cập nhật quyền thành công" : "Cập nhật quyền thất bại");
        showRoles(req, resp);
    }
}
