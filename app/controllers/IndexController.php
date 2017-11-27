<?php

class IndexController extends ControllerBase
{

    public function indexAction()
    {
        $this->view->menu=Category::find(array("conditions"=>"parent is null"));
    }

}

