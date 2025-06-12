<%-- 
    Document   : hapusBuku
    Created on : 12 Jun 2025, 09.51.46
    Author     : hp
--%>

<%@page import="classes.JDBC"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String bookID = request.getParameter("bookID");

    try {
        Connection conn = JDBC.getConnection();
        String sql = "DELETE FROM books WHERE bookID = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, bookID);
        pstmt.executeUpdate();
        pstmt.close();
        conn.close();
        response.sendRedirect("daftarBuku.jsp");
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>