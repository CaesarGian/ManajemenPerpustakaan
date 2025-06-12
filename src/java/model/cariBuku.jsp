<%-- 
    Document   : cariBuku
    Created on : 12 Jun 2025, 10.07.12
    Author     : hp
--%>

<%@page import="java.awt.print.Book"%>
<%@page import="java.util.List"%>
<%@page import="model.Buku"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="classes.JDBC" %>
<%@ page import="model.Pengguna" %>


<body>
<form action="cariBuku.jsp" method="POST">
    <input type="text" name="keyword" placeholder="Cari berdasarkan judul atau kategori" />
    <input type="submit" value="Cari" />
</form>
</body>
<%
    String keyword = request.getParameter("keyword");
    if (keyword != null) {
        // Panggil metode untuk mencari buku
        List<Buku> daftarBuku = Buku.getAttribute(keyword);
        // Tampilkan hasil pencarian
        for (Buku buku : daftarBuku) {
            out.println(buku.getJudul() + "<br/>");
        }
    }
%>