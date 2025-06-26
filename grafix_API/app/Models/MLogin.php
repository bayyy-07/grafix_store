<?php

namespace App\Models;

use CodeIgniter\Model;

class MLogin extends Model
{
    protected $table = 'member_token';  // Sesuaikan dengan nama tabel yang kamu gunakan
    protected $primaryKey = 'id';
    protected $allowedFields = ['auth_key', 'member_id', ];  // Pastikan auth_key ada di sini

    // Menambahkan fungsi untuk mengambil validasi token
    public function validateToken($token)
    {
        return $this->where('auth_key', $token)->first();
    }
}
