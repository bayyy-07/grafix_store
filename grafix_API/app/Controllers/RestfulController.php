<?php

namespace App\Controllers;

use CodeIgniter\RESTful\ResourceController;

class RestfulController extends ResourceController
{
    protected function responseHasil(int $code, bool $status, string $message, array $data = null)
{
    $response = [
        'code' => $code,
        'status' => $status,
        'message' => $message,
    ];

    if ($data !== null) {
        $response['data'] = $data;
    }

    return $this->respond($response, $code);
}


}
