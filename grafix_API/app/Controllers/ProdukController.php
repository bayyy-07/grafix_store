<?php

namespace App\Controllers;

use App\Models\MProduk;
use CodeIgniter\RESTful\ResourceController;

class ProdukController extends ResourceController
{
    protected $modelName = MProduk::class; // Definisi model untuk digunakan dalam fungsi ResourceController
    protected $format    = 'json'; // Format default untuk output

    // Fungsi untuk membuat produk baru
    public function create()
    {
        $data = [
            'kode_produk' => $this->request->getVar('kode_produk'),
            'nama_produk' => $this->request->getVar('nama_produk'),
            'harga'       => $this->request->getVar('harga'),
        ];

        // Validasi sederhana
        if (empty($data['kode_produk']) || empty($data['nama_produk']) || empty($data['harga'])) {
            return $this->failValidationError('Semua field harus diisi.');
        }

        if (!$this->model->insert($data)) {
            return $this->failServerError('Gagal menambahkan produk.');
        }

        $produk = $this->model->find($this->model->getInsertID());
        return $this->respondCreated(['status' => true, 'data' => $produk]);
    }

    // Fungsi untuk mendapatkan daftar produk
    public function list()
    {
        $produk = $this->model->findAll();
        return $this->respond(['status' => true, 'data' => $produk], 200);
    }

    // Fungsi untuk menampilkan detail produk
    public function detail($id = null)
    {
        $produk = $this->model->find($id);
        if (!$produk) {
            return $this->failNotFound("Produk dengan ID $id tidak ditemukan.");
        }
        return $this->respond(['status' => true, 'data' => $produk], 200);
    }

    // Fungsi untuk mengubah produk
    public function ubah($id = null)
    {
        $data = [
            'kode_produk' => $this->request->getVar('kode_produk'),
            'nama_produk' => $this->request->getVar('nama_produk'),
            'harga'       => $this->request->getVar('harga'),
        ];

        if (!$this->model->find($id)) {
            return $this->failNotFound("Produk dengan ID $id tidak ditemukan.");
        }

        if (!$this->model->update($id, $data)) {
            return $this->failServerError('Gagal mengubah produk.');
        }

        $produk = $this->model->find($id);
        return $this->respond(['status' => true, 'data' => $produk], 200);
    }

    // Fungsi untuk menghapus produk
    public function hapus($id = null)
    {
        if (!$this->model->find($id)) {
            return $this->failNotFound("Produk dengan ID $id tidak ditemukan.");
        }

        if (!$this->model->delete($id)) {
            return $this->failServerError('Gagal menghapus produk.');
        }

        return $this->respondDeleted(['status' => true, 'message' => "Produk dengan ID $id berhasil dihapus."]);
    }

    // Fungsi Perbangingann
    public function getProduk($id)
{
    $produkModel = new MProduk();
    $produk = $produkModel->getProdukById($id);

    if ($produk) {
        return $this->response->setJSON([
            'status' => true,
            'data' => $produk
        ]);
    } else {
        return $this->response->setJSON([
            'status' => false,
            'message' => 'Produk tidak ditemukan'
        ])->setStatusCode(404);
    }
}



}
