<?php

class ProfileController extends \Phalcon\Mvc\Controller
{
    public function initialize()
    {
        if (!$this->session->has("username")){
            $this->response->redirect("login");
        }
        $this->view->setLayout('layout');

    }
    public function indexAction()
    {

    }
    public function passwordAction($status=null){
        $this->view->status=$status;
        $this->view->title="Change Password";
        $this->view->menu="password";
    }
}

