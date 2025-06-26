<?php

namespace App\Filters;

use CodeIgniter\HTTP\RequestInterface;
use CodeIgniter\HTTP\ResponseInterface;
use CodeIgniter\Filters\FilterInterface;
use App\Models\MLogin;

class AuthFilter implements FilterInterface
{
    public function before(RequestInterface $request, $arguments = null)
    {
        // Ambil token dari header Authorization
        $authHeader = $request->getHeaderLine('Authorization');

        // Jika token tidak ada atau format salah
        if (!$authHeader || !str_starts_with($authHeader, 'Bearer ')) {
            return response()->setJSON([
                'code' => 401,
                'status' => false,
                'message' => 'Token tidak ditemukan atau format salah',
            ])->setStatusCode(401);
        }

        // Mengambil token dari header Authorization
        $token = trim(str_replace('Bearer ', '', $authHeader));

        $loginModel = new MLogin();

        // Mengecek validitas token
        $valid = $loginModel->where('auth_key', $token)->first();

        // Jika token tidak valid atau kedaluwarsa
        if (!$valid) {
            return response()->setJSON([
                'code' => 401,
                'status' => false,
                'message' => 'Token tidak valid atau kedaluwarsa',
            ])->setStatusCode(401);
        }

        // Menyimpan user_id ke dalam session
        session()->set('user_id', $valid['member_id']);
    }

    public function after(RequestInterface $request, ResponseInterface $response, $arguments = null)
    {
        // Tidak ada perubahan setelah request diproses
    }
}

