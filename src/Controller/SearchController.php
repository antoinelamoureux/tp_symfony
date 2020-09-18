<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Routing\Annotation\Route;
use App\Repository\ProductRepository;
use Symfony\Component\HttpFoundation\Request;
use Knp\Component\Pager\PaginatorInterface;
use App\Form\SearchType;

class SearchController extends AbstractController
{
    /**
     * @Route("/search", name="search")
     */
    public function index(Request $request, ProductRepository $repository, PaginatorInterface $paginator)
    {
        $searchForm = $this->createForm(SearchType::class);
        $searchForm->handleRequest($request);
        
        $data = $repository->findAll();
 
        if ($searchForm->isSubmitted() && $searchForm->isValid()) {
 
            $name = $searchForm->getData()->getName();
            $data = $repository->findByName($name);
            if ($data == null) {
                $this->addFlash('error', 'No product found for this keyword.');
           
            }
    }

     // Paginate the results of the query
     $products = $paginator->paginate(
        // Doctrine Query, not results
        $data,
        // Define the page parameter
        $request->query->getInt('page', 1),
        // Items per page
        10
    );

        return $this->render('search/index.html.twig', [
            'products' => $products,
            'searchForm' => $searchForm->createView()
        ]);
    }
}
