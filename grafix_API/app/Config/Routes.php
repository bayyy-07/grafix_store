<?php

use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */
// Default route ke Home
$routes->get('/', 'Home::index');

// POST untuk registrasi dan login
$routes->post('/registrasi', 'RegistrasiController::registrasi');
$routes->post('/login', 'LoginController::login');

$routes->get('profile', 'ProfileController::getProfile', ['filter' => 'auth']);

$routes->get('/service', 'ServiceController::getservice', ['filter' => 'auth']);
$routes->post('service/tambah', 'ServiceController::tambah');
$routes->get('service/getByUser', 'ServiceController::getByUser');


$routes->post('/payment/token', 'PaymentController::token');


$routes->get('api/user', 'UserController::getUser', ['filter' => 'auth']);




// Group Produk - untuk produk
$routes->group('produk', function ($routes) {
    $routes->post('/', 'ProdukController::create');
    $routes->get('/', 'ProdukController::list');
    $routes->get('(:segment)', 'ProdukController::detail/$1');
    $routes->put('(:segment)', 'ProdukController::ubah/$1');
    $routes->delete('(:segment)', 'ProdukController::hapus/$1');
    $routes->get('/', 'ProdukController::getProduk/$1');
});


$routes->group('keranjang', ['filter' => 'auth'], function ($routes) {
    $routes->get('/', 'KeranjangController::getByUser'); // Ambil keranjang user
    $routes->post('tambah', 'KeranjangController::tambah'); // Tambah item ke keranjang
    $routes->delete('hapus/(:num)', 'KeranjangController::hapus/$1'); // Hapus item dari keranjang
});

$routes->group('api', ['filter' => 'auth'], function($routes) {
    
    $routes->get('keranjang', 'KeranjangController::getByUser');
    $routes->post('keranjang/tambah', 'KeranjangController::tambah', ['filter' => 'auth']);
    $routes->delete('hapus/(:num)', 'KeranjangController::hapus/$1');
    $routes->post('keranjang/updateJumlah/(:num)', 'KeranjangController::updateJumlah/$1');
    
});







   