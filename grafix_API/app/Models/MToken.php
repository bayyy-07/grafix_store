<?php

namespace App\Models;

use CodeIgniter\Model;

class MToken extends Model
{
    // Nama tabel yang digunakan untuk menyimpan token
    protected $table = 'member_token';
    // Nama primary key di tabel member_token
    protected $primaryKey = 'id';
    // Kolom yang diizinkan untuk diakses
    protected $allowedFields = ['member_id', 'auth_key'];
    // Menonaktifkan penggunaan timestamp otomatis
    protected $useTimestamps = false;

    /**
     * Mendapatkan user_id berdasarkan auth_key
     *
     * @param string $authKey
     * @return array|object|null
     */
    public function getUserIdByAuthKey($authKey)
    {
        // Query untuk mencari user_id berdasarkan auth_key
        return $this->where('auth_key', $authKey)->first();
    }
}
