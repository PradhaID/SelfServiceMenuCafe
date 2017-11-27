<?php

class DashboardController extends \Phalcon\Mvc\Controller
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
        $this->view->sales=VDailySales::find(array("conditions"=>"date_part('month', date)='".date('m')."' AND date_part('year', date)='".date('Y')."'"));
    }

}

