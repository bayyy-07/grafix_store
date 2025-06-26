<?php

namespace App\Controllers;
use App\Controllers\BaseController;
use App\Models\MToken;
use App\Models\MMember;

class ProfileController extends BaseController
{
    public function getProfile()
    {
        $authHeader = $this->request->getHeaderLine('Authorization');
        $authKey = str_replace('Bearer ', '', $authHeader);  // Hilangkan "Bearer "

        log_message('debug', 'Raw Header: ' . $authHeader);
        log_message('debug', 'Clean Token: ' . $authKey);


        $tokenModel = new MToken();
        $tokenData = $tokenModel->getUserIdByAuthKey($authKey);

        if (!$tokenData) {
            return $this->response->setJSON([
                'status' => false,
                'message' => 'Auth key tidak valid',
            ])->setStatusCode(401);
        }
        $memberId = $tokenData['member_id'];
        $MMember = new MMember();
        $user = $MMember->find($memberId);

        if (!$user) {
            return $this->response->setJSON([
                'status' => false,
                'message' => 'User tidak ditemukan',
            ])->setStatusCode(404);
        }

        return $this->response->setJSON([
            'status' => true,
            'data' => $user,
        ]);
    }
}

