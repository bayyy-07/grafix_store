<?php

namespace App\Models;

use CodeIgniter\Model;

class MMember extends Model
{
    protected $table = 'member';
    protected $primaryKey = 'id';
    protected $allowedFields = ['id', 'nama', 'email', 'created_at', 'updated_at'];  // Menambahkan 'id' jika perlu
    protected $useTimestamps = true;  // Jika kamu memiliki kolom timestamp di database (created_at, updated_at)

    // Optional: Tambahkan method untuk mengambil member berdasarkan ID
    public function getMemberById($id)
    {
        return $this->find($id);  // Mengambil member berdasarkan ID
    }
}
