/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author HP
 */
public class Admin extends Pengguna {

    @Override
    public void aksesDashboard() {
        System.out.println("Akses dashboard admin");
    }

    public void tambahBuku(Buku buku) {
        // implementasi tambah buku
    }

    public void hapusBuku(String bookID) {
        // implementasi hapus buku
    }
    
    public void updateBuku(Buku buku) {
        // implementasi update buku
    }
    
    public void lihatSemuaBuku() {
        // implementasi tampil semua buku
    }
    
    public Buku cariBuku(String judul) {
        // implementasi pencarian buku
        return null; // kembalikan buku yang ditemukan
    }
    
    public void kelolaPengguna(Pengguna pengguna) {
        // implementasi untuk kelola pengguna
    }
}

