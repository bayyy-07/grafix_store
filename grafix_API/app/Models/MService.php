<?php

 namespace App\Models;

use CodeIgniter\Model;

class MService extends Model
{
protected $table = 'service';
protected $primaryKey = 'id';
protected $allowedFields = ['perangkat','user_id', 'no_seri', 'merek_perangkat', 'pelayanan', 'jenis_kerusakan', 'detail_kerusakan'];
}