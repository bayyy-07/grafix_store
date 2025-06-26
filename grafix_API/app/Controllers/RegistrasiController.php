<?php

namespace App\Controllers;

use App\Models\MRegistrasi;

class RegistrasiController extends RestfulController
{
    public function registrasi()
    {
        $data = [
            'nama' => $this->request->getVar('nama'),
            'email' => $this->request->getVar('email'),
            'password' => password_hash($this->request->getVar('password'), PASSWORD_DEFAULT)
        ];
    
        $model = new MRegistrasi();
        if (!$model->save($data)) {
            // Menampilkan pesan error jika gagal
            return $this->responseHasil(500, false, "Gagal registrasi.", $model->errors());
        }
        
        return $this->responseHasil(200, true, "Registrasi berhasil");
    }
}