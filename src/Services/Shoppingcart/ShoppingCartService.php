<?php

namespace App\Service\Shoppingcart;

use Symfony\Component\HttpFoundation\Session\SessionInterface;

class ShoppingCartService {

    protected $session;

    public function __construct(SessionInterface $session) 
    {
        $this->session = $session;
    }

    public function add(int $id)
    {
        $shoppingCart = $this->session->get('shoppingcart', []);

        if(!empty($shoppingCart[$id])) {
            $shoppingCart[$id]++;
        } else {
            $shoppingCart[$id] = 1;
        }

        $this->session->set('shoppingcart', $shoppingCart);
    }

    public function remove(int $id)
    {
        # code...
    }

/*     public function getFullCart(): array
    {
        # code...
    }

    public function getTotal(): float
    {
        # code...
    } */
}