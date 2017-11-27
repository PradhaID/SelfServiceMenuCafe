<?php

class LoginController extends \Phalcon\Mvc\Controller
{
    public function initialize()
    {
        if ($this->session->has("username")){
            $this->response->redirect("dashboard");
        }

    }

    public function indexAction()
    {
       if ($this->request->isPost()){
           $this->view->disable();
           $user = Users::findFirst(array(
               "conditions" => "username = '".$this->request->getPost("usermail")."' or email = '".$this->request->getPost("usermail")."'"
           ));
           if (isset($user->username)){
               if (password_verify($this->request->getPost("password"), $user->password)) {
                   echo "Username & Password True";
                   $this->session->set("username", $user->username);
                   $this->session->set("name", $user->name);
                   $this->response->redirect("dashboard");
               }
               else{
                   echo "Password False";
                   echo $user->password. "<br>";
                   $func = new Func();
                   echo $user->password. "<br>";
               }
           }
           else{
               echo "User not found";
               echo "<br>";
               $func = new Func();
               echo $func->cryptPass($this->request->getPost("password"));
           }
       }
    }

}

