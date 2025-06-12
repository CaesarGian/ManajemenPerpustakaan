<%-- 
    Document   : daftarBuku
    Created on : 12 Jun 2025, 09.50.40
    Author     : hp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="classes.JDBC"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Daftar Buku</title>
</head>
<body>
    <h1>Daftar Buku</h1>
    <table border="1">
        <tr>
            <th>Book ID</th>
            <th>Judul</th>
            <th>Penulis</th>
            <th>Penerbit</th>
            <th>Tahun Terbit</th>
            <th>Action</th>
        </tr>
        <%
            try {
                Connection conn = JDBC.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM books");
                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getString("bookID") %></td>
            <td><%= rs.getString("judul") %></td>
            <td><%= rs.getString("penulis") %></td>
            <td><%= rs.getString("penerbit") %></td>
            <td><%= rs.getInt("tahunTerbit") %></td>
            <td>
                <a href="editBuku.jsp?bookID=<%= rs.getString("bookID") %>">Edit</a>
                <a href="hapusBuku.jsp?bookID=<%= rs.getString("bookID") %>">Hapus</a>
            </td>
        </tr>
        <%
                }
                rs.close();
                stmt.close();
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        %>
    </table>
    <br>
    <a href="tambahBuku.jsp">Tambah Buku</a>
</body>
</html>