<?php

 namespace App\Models;

use CodeIgniter\Model;

class MProduk extends Model
{
protected $table = 'produk';
protected $primaryKey = 'id';
protected $allowedFields = ['name', 'image',
'price', 
'processor', 
'front_camera', 
'back_camera', 
'ukuran_layar', 
'kamera_wideangle', 
'kamera_telephoto', 
'processor', 
'sistem_operasi', 
'baterai', 
'kamera_depth' ];


public function getProdukById($id)
{
    return $this->where('id', $id)->first();
}

}

