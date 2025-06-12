<%-- 
    Document   : prosesEditBuku
    Created on : 12 Jun 2025, 09.52.43
    Author     : hp
--%>

<%@page import="classes.JDBC"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String bookID = request.getParameter("bookID");
    String judul = request.getParameter("judul");
    String penulis = request.getParameter("penulis");
    String penerbit = request.getParameter("penerbit");
    int tahunTerbit = Integer.parseInt(request.getParameter("tahunTerbit"));

    try {
        Connection conn = JDBC.getConnection();
        String sql = "UPDATE books SET judul = ?, penulis = ?, penerbit = ?, tahunTerbit = ? WHERE bookID = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, judul);
        pstmt.setString(2, penulis);
        pstmt.setString(3, penerbit);
        pstmt.setInt(4, tahunTerbit);
        pstmt.setString(5, bookID);
        pstmt.executeUpdate();
        pstmt.close();
        conn.close();
        response.sendRedirect("daftarBuku.jsp");
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>