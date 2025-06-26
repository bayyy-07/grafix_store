<?php

namespace App\Controllers;

use App\Models\MLogin;
use App\Models\MMember;

class LoginController extends RestfulController
{
    /**
     * Proses login
     */
    public function login()
    {
        // Ambil email dan password dari request
        $email = $this->request->getVar('email');
        $password = $this->request->getVar('password');

        // Validasi input email dan password
        if (empty($email) || empty($password)) {
            return $this->responseHasil(400, false, "Email dan password wajib diisi.");
        }

        // Cari member berdasarkan email
        $model = new MMember();
        $member = $model->where(['email' => $email])->first();

        // Jika email tidak ditemukan
        if (!$member) {
            return $this->responseHasil(404, false, "Email tidak ditemukan.");
        }

        // Verifikasi password
        if (!password_verify($password, $member['password'])) {
            return $this->responseHasil(401, false, "Password tidak valid.");
        }

        // Buat auth_key baru
        $auth_key = $this->generateRandomString();

        // Simpan auth_key ke dalam tabel member_token
        $login = new MLogin();
        $login->save([
            'member_id' => $member['id'],
            'auth_key' => $auth_key
        ]);

        // Data yang akan dikembalikan
        $data = [
            'token' => $auth_key,
            'user' => [
                'id' => $member['id'],
                'email' => $member['email'],
            ]
        ];

        // Kirim response berhasil
        return $this->responseHasil(200, true, "Login berhasil.", $data);
    }

    /**
     * Fungsi untuk menghasilkan string acak (token)
     * 
     * @param int $length Panjang string
     * @return string
     */
    private function generateRandomString($length = 100)
    {
        $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
        $charactersLength = strlen($characters);
        $randomString = '';
        for ($i = 0; $i < $length; $i++) {
            $randomString .= $characters[rand(0, $charactersLength - 1)];
        }
        return $randomString;
    }
}
