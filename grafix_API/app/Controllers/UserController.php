<?php

namespace App\Controllers;

use App\Models\MToken;
use App\Models\MMember;
use CodeIgniter\RESTful\ResourceController;

class UserController extends ResourceController
{
    public function getUser()
    {
        $authKey = $this->request->getHeaderLine('Authorization');
        $authKey = str_replace('Bearer ', '', $authKey);

        if (!$authKey) {
            return $this->failUnauthorized('Token tidak ditemukan');
        }

        $tokenModel = new MToken();
        $tokenData = $tokenModel->getUserIdByAuthKey($authKey);

        if (!$tokenData) {
            return $this->failUnauthorized('Token tidak valid atau telah kedaluwarsa');
        }

        $userId = $tokenData['member_id'];

        $userModel = new MMember();
        $user = $userModel->find($userId);

        if (!$user) {
            return $this->failNotFound('User tidak ditemukan');
        }

        return $this->respond($user);
    }
}
