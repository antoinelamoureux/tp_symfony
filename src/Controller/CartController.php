<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Session\SessionInterface;
use App\Repository\ProductRepository;

class CartController extends AbstractController
{
    /**
     * @Route("/shoppingcart", name="shoppingcart_index")
     */
    public function index(SessionInterface $session, ProductRepository $productRepository) 
    {
        $shoppingCart = $session->get('shoppingcart', []);

        $shoppingCartWithData = [];

        foreach ($shoppingCart as $id => $quantity) {
            $shoppingCartWithData[] = [
                'product' => $productRepository->find($id),
                'quantity' => $quantity
            ];

        }

        $total = 0;

        foreach($shoppingCartWithData as $item) {
            $totalItem = $item['product']->getPrice() * $item['quantity'];
            $total += $totalItem;
        }

        return $this->render('cart/index.html.twig', [
            'items' => $shoppingCartWithData,
            'total' => $total
        ]);
    }

    /**
     *  @Route("/shoppingcart/add/{id}", name="shoppingcart_add")
     */

    public function add($id, SessionInterface $session)
    {
        $shoppingCart = $session->get('shoppingcart', []);

        if(!empty($shoppingCart[$id])) {
            $shoppingCart[$id]++;
        } else {
            $shoppingCart[$id] = 1;
        }

        $session->set('shoppingcart', $shoppingCart);
        
        return $this->redirectToRoute('shoppingcart_index');
    }

    /**
     * @Route("/shoppingcart/remove/{id}", name="shoppingcart_remove")
     */
    public function renove($id, SessionInterface $session)
    {
        $shoppingCart = $session->get('shoppingcart', []);

        if (!empty($shoppingCart[$id])) {
            unset($shoppingCart[$id]);
        }

        $session->set('shoppingcart', $shoppingCart);

        return $this->redirectToRoute('shoppingcart_index');
    }
}
