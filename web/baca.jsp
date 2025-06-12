<%-- 
    Document   : baca
    Created on : 28 May 2025, 13.20.09
    Author     : HP
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="classes.JDBC" %>
<%@ page import="model.Pengguna" %>
<%@ page import="java.sql.*" %>

<%
    
    if (session == null || session.getAttribute("pengguna") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    Pengguna pengguna = (Pengguna) session.getAttribute("pengguna");
    String userID = pengguna.getUserID();

    String bookID = request.getParameter("bookID");
    if (bookID == null || bookID.trim().isEmpty()) {
        out.println("<h3>Book ID tidak ditemukan!</h3>");
        return;
    }

    String judul = "";
    String penulis = "";
    String konten = ""; // nanti ambil dari DB kalau ada kolom konten
    String statusBaca = "";

    try (Connection conn = JDBC.getConnection()) {
        // Ambil data buku
        String sqlBook = "SELECT judul, penulis FROM books WHERE bookID = ?";
        PreparedStatement psBook = conn.prepareStatement(sqlBook);
        psBook.setString(1, bookID);
        ResultSet rsBook = psBook.executeQuery();
        if (rsBook.next()) {
            judul = rsBook.getString("judul");
            penulis = rsBook.getString("penulis");
        }
        rsBook.close();
        psBook.close();

        // Ambil status baca dari wishlist
        String sqlStatus = "SELECT statusBaca FROM wishlist WHERE userID = ? AND bookID = ?";
        PreparedStatement psStatus = conn.prepareStatement(sqlStatus);
        psStatus.setString(1, userID);
        psStatus.setString(2, bookID);
        ResultSet rsStatus = psStatus.executeQuery();
        if (rsStatus.next()) {
            statusBaca = rsStatus.getString("statusBaca");
        }
        rsStatus.close();
        psStatus.close();

        // Jika status masih belum dibaca, update ke sedang dibaca (user mulai baca)
        if ("belum dibaca".equals(statusBaca)) {
            String updateStatus = "UPDATE wishlist SET statusBaca = 'sedang dibaca' WHERE userID = ? AND bookID = ?";
            PreparedStatement psUpdate = conn.prepareStatement(updateStatus);
            psUpdate.setString(1, userID);
            psUpdate.setString(2, bookID);
            psUpdate.executeUpdate();
            psUpdate.close();
            statusBaca = "sedang dibaca";
        }

        // Untuk demo, isi konten dummy panjang:
        konten = "Ini adalah isi buku '" + judul + "'.\n\n" +
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\n\n" +
                "Anda bisa mengganti bagian ini dengan konten asli buku yang disimpan di database.";

    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Baca Buku - <%= judul %></title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; line-height: 1.6; }
        .header { margin-bottom: 20px; }
        .content { height: 70vh; overflow-y: scroll; border: 1px solid #ccc; padding: 20px; white-space: pre-wrap; background-color: #fafafa; }
        .btn { margin-top: 15px; padding: 10px 15px; background-color: #28a745; color: white; border: none; border-radius: 5px; cursor: pointer; }
        .btn:disabled { background-color: #ccc; cursor: not-allowed; }
        a { text-decoration: none; color: #007bff; }
    </style>
</head>
<body>
    <div class="header">
        <a href="wishlist.jsp">⬅ Kembali ke Wishlist</a>
        <h2><%= judul %></h2>
        <p><em>Penulis: <%= penulis %></em></p>
        <p>Status baca: <strong><%= statusBaca %></strong></p>
    </div>

    <div class="content" id="bookContent">
        <%= konten %>
    </div>

    <form action="UpdateStatusBacaServlet" method="post">
        <input type="hidden" name="userID" value="<%= userID %>">
        <input type="hidden" name="bookID" value="<%= bookID %>">
        <button type="submit" class="btn" <%= "sudah dibaca".equals(statusBaca) ? "disabled" : "" %>>Tandai Sudah Dibaca</button>
    </form>

</body>
</html>

