/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import classes.JDBC;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;

@WebServlet("/PeminjamanServlet")
public class PeminjamanServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userID = request.getParameter("userID");
        String bookID = request.getParameter("bookID");
        String tanggalPinjamStr = request.getParameter("tanggalPinjam");
        String lamaPinjamStr = request.getParameter("lamaPinjam");

        if (userID == null || bookID == null || tanggalPinjamStr == null || lamaPinjamStr == null) {
            response.sendRedirect("books.jsp?error=Data peminjaman tidak lengkap.");
            return;
        }

        try {
            LocalDate tanggalPinjam = LocalDate.parse(tanggalPinjamStr);
            int lamaPinjam = Integer.parseInt(lamaPinjamStr);
            LocalDate tanggalKembali = tanggalPinjam.plusDays(lamaPinjam);

            try (Connection conn = JDBC.getConnection()) {
                // Mulai transaksi agar konsisten update buku dan peminjaman
                conn.setAutoCommit(false);

                // Insert ke tabel peminjaman
                String sqlInsert = "INSERT INTO peminjaman (userID, bookID, tanggalPinjam, tanggalKembali, status) VALUES (?, ?, ?, ?, 'dipinjam')";
                try (PreparedStatement psInsert = conn.prepareStatement(sqlInsert)) {
                    psInsert.setString(1, userID);
                    psInsert.setString(2, bookID);
                    psInsert.setDate(3, Date.valueOf(tanggalPinjam));
                    psInsert.setDate(4, Date.valueOf(tanggalKembali));
                    psInsert.executeUpdate();
                }

                // Update status buku jadi "dipinjam"
                String sqlUpdate = "UPDATE books SET statusKetersediaan = 'dipinjam' WHERE bookID = ?";
                try (PreparedStatement psUpdate = conn.prepareStatement(sqlUpdate)) {
                    psUpdate.setString(1, bookID);
                    psUpdate.executeUpdate();
                }

                conn.commit();
                conn.setAutoCommit(true);
            }

            // Redirect ke dashboard_user agar user lihat status peminjaman terbaru
            response.sendRedirect("dashboard_user.jsp?message=Peminjaman berhasil diajukan.");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("books.jsp?error=Gagal mengajukan peminjaman.");
        }
    }
}
