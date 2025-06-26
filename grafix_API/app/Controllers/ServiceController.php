<?php

namespace App\Controllers;

use App\Models\MService;
use App\Models\MToken;
use CodeIgniter\RESTful\ResourceController;

class ServiceController extends ResourceController {

    protected $model;

    public function __construct()
    {
        
        $this->model = new MService();
    }

     public function getByUser()
    {
        $authKey = $this->request->getHeaderLine('Authorization');
        $authKey = str_replace('Bearer ', '', $authKey);

        $tokenModel = new MToken();
        $tokenData = $tokenModel->getUserIdByAuthKey($authKey);

        if (!$authKey) {
            return $this->failUnauthorized('Token tidak ditemukan');
        }

        $tokenModel = new MToken();
        $tokenData = $tokenModel->getUserIdByAuthKey($authKey);

        if (!$tokenData) {
            return $this->failUnauthorized('Token tidak valid atau telah kedaluwarsa');
        }

        $userId = $tokenData['member_id'];

        $data = $this->model->where('user_id', $userId)->findAll();

        return $this->respond($data);
    }
    

    public function tambah()
{
    $authKey = $this->request->getHeaderLine('Authorization');
    $authKey = str_replace('Bearer ', '', $authKey);

    if (!$authKey) {
        return $this->failUnauthorized('Token tidak ditemukan');
    }

    $tokenModel = new MToken();
    $tokenData = $tokenModel->getUserIdByAuthKey($authKey);

    if (!$tokenData || !isset($tokenData['member_id'])) {
        return $this->failUnauthorized('Token tidak valid atau member_id tidak ditemukan');
    }

    $userId = $tokenData['member_id'];
    $json = $this->request->getJSON(true);

    $data = [
        'user_id'           => $userId,
        'no_seri'           => $json['no_seri'] ?? null,
        'perangkat'         => $json['perangkat'] ?? null,
        'merek_perangkat'   => $json['merek_perangkat'] ?? null,
        'pelayanan'         => $json['pelayanan'] ?? null,
        'jenis_kerusakan'   => $json['jenis_kerusakan'] ?? null,
        'detail_kerusakan'  => $json['detail_kerusakan'] ?? null,
    ];

    // Validasi sederhana semua field wajib
    foreach ($data as $key => $value) {
        if (empty($value) && $value !== '0') {
            return $this->fail("Field {$key} wajib diisi.");
        }
    }

    if ($this->model->insert($data)) {
        return $this->respond([
            'status' => true,
            'message' => 'Data service berhasil ditambahkan.'
        ]);
    }

    return $this->failServerError('Gagal menyimpan data service.');
}


    public function getservice()
{
    $model = new \App\Models\MService();
    $data = $model->orderBy('id', 'DESC')->first();

    if ($data) {
        return $this->response->setJSON($data);
    }

    return $this->response->setJSON(['message' => 'Tidak ada data'], 404);
}

}