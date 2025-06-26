<?php

namespace App\Controllers;
use Midtrans\Snap;
use Midtrans\Config;
use App\Models\MKeranjang;

class PaymentController extends BaseController
{
    public function token()
    {
        helper(['text']);

        $request = service('request');
        $json = $request->getJSON(true);
        $userId = $json['user_id'];

        $keranjangModel = new MKeranjang();
        $items = $keranjangModel->getKeranjangByUser($userId); // Asumsikan kamu sudah punya fungsi ini

        $item_details = [];
        $gross_amount = 0;

        foreach ($items as $item) {
            $item_details[] = [
                'id' => $item['produk_id'],
                'price' => (int) $item['price'],
                'quantity' => (int) $item['jumlah'],
                'name' => $item['name'],
            ];
            $gross_amount += (int)$item['price'] * (int)$item['jumlah'];
        }

        Config::$serverKey = 'SB-Mid-server-dVl9d44cDu4UY9KrFEZQK3Jy';
        Config::$isProduction = false;

        $transaction = [
            'transaction_details' => [
                'order_id' => uniqid('ORDER-'),
                'gross_amount' => $gross_amount,
            ],
            'item_details' => $item_details,
        ];

        try {
            $snapToken = Snap::getSnapToken($transaction);
            return $this->response->setJSON(['token' => $snapToken]);
        } catch (\Exception $e) {
            return $this->response->setStatusCode(500)->setJSON(['error' => $e->getMessage()]);
        }
    }
}
