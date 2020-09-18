<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Request;
use App\Form\ContactType;
use Symfony\Component\Mailer\MailerInterface;
use Symfony\Component\Mime\Email;

class ContactController extends AbstractController
{
    /**
     * @Route("/contact", name="contact")
     */
    public function index(Request $request, MailerInterface $mailer)
    {
        $contactForm = $this->createForm(ContactType::class);

        if ($request->isMethod('POST')) {
            // Refill the fields in case the form is not valid.
            $contactForm->handleRequest($request);
        }

        if($contactForm->isSubmitted() && $contactForm->isValid()){
            $contactFormData = $contactForm->getData();
            
            $message = (new Email())
                ->from($contactFormData->getEmail())
                ->to('sisilafamille007@gmail.com')
                ->subject($contactFormData->getSubject())
                ->text('Sender : '.$contactFormData->getEmail().\PHP_EOL.
                    $contactFormData->getMessage(),
                    'text/plain');
            $mailer->send($message);
            
            $this->addFlash('success', 'Your message has been sent');

            return $this->redirectToRoute('contact');
            }

        return $this->render('contact/index.html.twig', [
            'controller_name' => 'ContactController',
            'contactForm' => $contactForm->createView()
        ]);
}
}
