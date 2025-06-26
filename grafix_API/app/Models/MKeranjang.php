<?php

namespace App\Models;

use CodeIgniter\Model;

class MKeranjang extends Model
{
    protected $table = 'keranjang';
    protected $primaryKey = 'id';
    protected $allowedFields = ['user_id', 'produk_id', 'jumlah', 'storage', 'color', 'image', 'name', 'price'];

    public function getKeranjangByUser($userID)
{
    $builder = $this->db->table('keranjang');
    $builder->select('keranjang.*, produk.name as name, produk.price as price, produk.image, produk.rating, produk.brand, produk.kategori');
    $builder->join('produk', 'produk.id = keranjang.produk_id');
    $builder->where('keranjang.user_id', $userID);
    $query = $builder->get();

    return $query->getResultArray(); // supaya bisa langsung di-parse Flutter
}

}
