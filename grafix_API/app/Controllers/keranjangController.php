<?php

namespace App\Controllers;

use App\Models\MKeranjang;
use App\Models\MToken;
use CodeIgniter\RESTful\ResourceController;

class KeranjangController extends ResourceController
{
    protected $model;

    public function __construct()
    {
        // Inisialisasi model MKeranjang
        $this->model = new MKeranjang();
    }

    // Ambil keranjang berdasarkan token user
    public function getByUser()
    {
        $authKey = $this->request->getHeaderLine('Authorization');
        $authKey = str_replace('Bearer ', '', $authKey); // Hapus 'Bearer ' 

        if (!$authKey) {
            return $this->failUnauthorized('Token tidak ditemukan');
        }

        $tokenModel = new MToken();
        $tokenData = $tokenModel->getUserIdByAuthKey($authKey);

        if (!$tokenData) {
            return $this->failUnauthorized('Token tidak valid atau telah kedaluwarsa');
        }

        $userId = $tokenData['member_id']; // Ambil dari field member_id

        $keranjangModel = new MKeranjang();
        $data = $keranjangModel->getKeranjangByUser($userId);

        return $this->respond($data);
    }

    // Tambah produk ke keranjang
    public function tambah()
    {
        $authKey = $this->request->getHeaderLine('Authorization');
        $authKey = str_replace('Bearer ', '', $authKey);

        if (!$authKey) {
            return $this->failUnauthorized('Token tidak ditemukan');
        }

        $tokenModel = new MToken();
        $tokenData = $tokenModel->getUserIdByAuthKey($authKey);

        if (!$tokenData) {
            return $this->failUnauthorized('Token tidak valid atau telah kedaluwarsa');
        }

        $userID     = $tokenData['member_id'];
        $namaProduk  = $this->request->getPost('name');
        $hargaProduk  = $this->request->getPost('price');
        $produkId   = $this->request->getPost('produk_id');
        $jumlah     = (int) $this->request->getPost('jumlah');
        $storage     = $this->request->getPost('storage');
        $color      = $this->request->getPost('color');
        $image      = $this->request->getPost('image');
        
        if (!$produkId || !$jumlah) {
            return $this->fail('Produk ID dan jumlah wajib diisi.');
        }

        $keranjangModel = new MKeranjang();

        // Cek apakah produk dengan varian yang sama sudah ada
        $existing = $keranjangModel
            ->where([
                'user_id'   => $userID,
                'produk_id' => $produkId,
                'storage'    => $storage,
                'color'     => $color,
                'image'     => $image,
                'name'     => $namaProduk,
                'price'     => $hargaProduk
            ])
            ->first();

        if ($existing) {
            // Update jumlah
            $newJumlah = $existing['jumlah'] + $jumlah;
            $keranjangModel->update($existing['id'], ['jumlah' => $newJumlah]);

            return $this->respond([
                'status'  => 'success',
                'message' => 'Jumlah produk diperbarui di keranjang.'
            ]);
        } else {
            // Tambah item baru
            $data = [
                'user_id'   => $userID,
                'produk_id' => $produkId,
                'jumlah'    => $jumlah,
                'storage'    => $storage,
                'color'     => $color,
                'image'     => $image,
                'name'     => $namaProduk,
                'price'     => $hargaProduk,
            ];

            if ($keranjangModel->insert($data)) {
                return $this->respond([
                    'status'  => 'success',
                    'message' => 'Produk berhasil ditambahkan ke keranjang.'
                ]);
            } else {
                return $this->failServerError('Gagal menambahkan ke keranjang.');
            }
        }
    }

    // Hapus item dari keranjang
    public function hapus($id = null)
    {
        // Ambil token dari header
        $authKey = $this->request->getHeaderLine('Authorization');
        $authKey = str_replace('Bearer ', '', $authKey);

        if (!$authKey) {
            return $this->failUnauthorized('Token tidak ditemukan');
        }

        $tokenModel = new MToken();
        $tokenData = $tokenModel->getUserIdByAuthKey($authKey);

        if (!$tokenData) {
            return $this->failUnauthorized('Token tidak valid atau telah kedaluwarsa');
        }

        $userID = $tokenData['member_id']; // Ambil user_id dari token

        // Cek apakah item keranjang ada dan milik user
        $item = $this->model->find($id);
        if (!$item) {
            return $this->failNotFound("Item keranjang dengan ID $id tidak ditemukan.");
        }

        // Pastikan item milik user yang sedang login
        if ($item['user_id'] != $userID) {
            return $this->failForbidden('Anda tidak dapat menghapus item milik orang lain.');
        }

        // Hapus item keranjang
        if (!$this->model->delete($id)) {
            return $this->failServerError('Gagal menghapus item keranjang.');
        }

        return $this->respondDeleted([
            'status' => true,
            'message' => "Item keranjang dengan ID $id berhasil dihapus."
        ]);
    }


    // update jumlah produk dikeranjang
    public function updateJumlah($id)
{
    $keranjangModel = new MKeranjang();
    $request = $this->request->getJSON(true);

    if (!isset($request['jumlah'])) {
        return $this->response->setJSON([
            'status' => false,
            'message' => 'Jumlah tidak boleh kosong',
        ])->setStatusCode(400);
    }

    $jumlahBaru = (int) $request['jumlah'];

    if ($jumlahBaru < 1) {
        return $this->response->setJSON([
            'status' => false,
            'message' => 'Jumlah tidak valid',
        ])->setStatusCode(400);
    }

    $update = $keranjangModel->update($id, [
        'jumlah' => $jumlahBaru,
    ]);

    if ($update) {
        return $this->response->setJSON([
            'status' => true,
            'message' => 'Jumlah berhasil diperbarui',
        ]);
    } else {
        return $this->response->setJSON([
            'status' => false,
            'message' => 'Gagal memperbarui jumlah',
        ])->setStatusCode(500);
    }
}

}
