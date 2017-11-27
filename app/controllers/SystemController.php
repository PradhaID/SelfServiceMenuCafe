<?php

class SystemController extends \Phalcon\Mvc\Controller
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
    public function userAction($act=null, $id=null, $status=null)
    {
        $this->view->act = $act;
        $this->view->id = $id;
        $this->view->status = $status;
        $error = new ArrayObject();
        $this->view->menu = "user";
        $this->view->groups = Groups::find();
        if ($act == "add") {
            if ($this->request->isPost()) {
                if ($this->request->getPost("group") == "" ||
                    $this->request->getPost("username") == "" ||
                    $this->request->getPost("name") == "" ||
                    $this->request->getPost("biography") == "" ||
                    $this->request->getPost("email") == "" ||
                    $this->request->getPost("phone") == "" ||
                    $this->request->getPost("gender") == ""
                ) {
                    if ($this->request->getPost("group") == "") $error->group = true;
                    if ($this->request->getPost("username") == "") $error->username = true;
                    if ($this->request->getPost("name") == "") $error->name = true;
                    if ($this->request->getPost("biography") == "") $error->biography = true;
                    if ($this->request->getPost("email") == "") $error->email = true;
                    if ($this->request->getPost("phone") == "") $error->phone = true;
                    if ($this->request->getPost("gender") == "") $error->gender = true;
                } else {
                    $user = new Users();
                    $user->group_id = $this->request->getPost("group");
                    $user->username = $this->request->getPost("username");
                    $user->name = $this->request->getPost("name");
                    $user->biography = $this->request->getPost("biography");
                    $user->email = $this->request->getPost("email");
                    $user->phone = $this->request->getPost("phone");
                    $user->gender = $this->request->getPost("gender");
                    $user->created_by = $user->updated_by = $this->session->get("username");
                    if ($user->create()) {
                        $this->response->redirect("system/user/edit/".$user->username.'/successadd');
                    } else {
                        $error->save = $user->getMessages();
                    }
                }
            }
            $this->view->error = $error;
            $this->view->pick(['system/add-user']);
        } else if ($act == "edit") {
            $user = Users::findFirst(array("conditions"=>"username='".$id."'"));
            if (isset($user->username)) {
                if ($this->request->isPost()) {
                    if ($this->request->getPost("group") == "" ||
                        $this->request->getPost("username") == "" ||
                        $this->request->getPost("name") == "" ||
                        $this->request->getPost("biography") == "" ||
                        $this->request->getPost("email") == "" ||
                        $this->request->getPost("phone") == "" ||
                        $this->request->getPost("gender") == ""
                    ) {
                        if ($this->request->getPost("group") == "") $error->group = true;
                        if ($this->request->getPost("username") == "") $error->username = true;
                        if ($this->request->getPost("name") == "") $error->name = true;
                        if ($this->request->getPost("biography") == "") $error->biography = true;
                        if ($this->request->getPost("email") == "") $error->email = true;
                        if ($this->request->getPost("phone") == "") $error->phone = true;
                        if ($this->request->getPost("gender") == "") $error->gender = true;
                    } else {
                        $user->group_id = $this->request->getPost("group");
                        $user->name = $this->request->getPost("name");
                        $user->biography = $this->request->getPost("biography");
                        $user->email = $this->request->getPost("email");
                        $user->phone = $this->request->getPost("phone");
                        $user->gender = $this->request->getPost("gender");
                        $user->created_by = $user->updated_by = $this->session->get("username");
                        if ($user->create()) {
                            $this->response->redirect("system/user/edit/".$user->username.'/success');
                        } else {
                            $error->save = $user->getMessages();
                        }
                    }
                }
                $this->view->user = Users::find(array("conditions"=>"username!='".$id."'"));
                $this->view->user = $user;
                $this->view->pick(['system/edit-user']);
            } else {
                $this->view->pick(['error/404']);
            }
        } else if ($act=="src"){
            $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
            if ($this->request->isPost()){
                $src=strtolower($this->request->getPost('src'));
                $this->view->users=VUsers::find(array("conditions"=>"lower(username) LIKE '%".$src."%' OR lower(name) LIKE '%".$src."%' OR lower(email) LIKE '%".$src."%'"));
                $this->view->pick(['system/src-user']);
            } else {
                $this->view->pick(['error/404']);
            }
        } else if ($act=="src-result"){
            $this->view->disable();
            echo "src result: ";
            echo $this->request->getPost('src');
            echo '<a href="'.$this->url->get('system/user').'"><i class="close icon"></i></a>';
        } else {
            $currentPage = is_numeric($act) ? (int)$act : 1;
            $data = VUsers::find();
            $paginator = new Phalcon\Paginator\Adapter\Model(
                [
                    "data" => $data,
                    "limit" => 15,
                    "page" => $currentPage,
                ]
            );
            $this->view->page = $paginator->getPaginate();
        }
    }
    public function groupAction($act=null, $id=null, $status=null){
        $this->view->act=$act;
        $this->view->id=$id;
        $this->view->status=$status;
        $error=new ArrayObject();
        $this->view->menu="group";
        if ($act=="add"){
            if ($this->request->isPost()){
                if ($this->request->getPost('name')=="" || $this->request->getPost('description')==""){
                    if ($this->request->getPost('name')) $error->name=true;
                    if ($this->request->getPost('description')) $error->description=true;
                } else {
                    $group=new Groups();
                    $group->name=$this->request->getPost('name');
                    $group->description=$this->request->getPost('description');
                    if ($group->create() !== false)
                        $this->response->redirect('system/group/edit/'.$group->id.'/successadd');
                    else
                        $error->save=$group->getMessages();
                }
            }
            $this->view->error=$error;
            $this->view->pick(['system/add-group']);
        } else if ($act=="edit"){
            if ($id!=null && is_numeric($id)){
                $group=Groups::findFirst(array("conditions"=>"id=".$id));
                if (!empty($group->id)){
                    $this->view->group=$group;
                    if ($this->request->isPost()){
                        if ($this->request->getPost('name')=="" || $this->request->getPost('description')==""){
                            if ($this->request->getPost('name')) $error->name=true;
                            if ($this->request->getPost('description')) $error->description=true;
                        } else {
                            $group->name=$this->request->getPost('name');
                            $group->description=$this->request->getPost('description');
                            if ($group->save() !== false)
                                $this->response->redirect('system/group/edit/'.$group->id.'/success');
                            else
                                $error->save=$group->getMessages();
                        }
                    }
                    $this->view->error=$error;
                    $this->view->pick(['system/edit-group']);
                } else {
                    $this->view->pick(['error/404']);
                }
            }

        }  else if ($act=="role"){
            $group=Groups::findFirst(array("conditions"=>"id=".decode($id)));
            if (isset($group->id)) {
                $this->view->data = $group;
                $this->view->roles=Roles::find(array("conditions"=>"parent is null"));
                if ($this->request->isPost()) {
                    $this->view->disable();
                    if ($this->request->getPost('group') == "" || $this->request->getPost('role') == "" || $this->request->getPost('status') == "") {
                        if ($this->request->getPost('group') == "") echo "Group ID required\n";
                        if ($this->request->getPost('role') == "") echo "role ID required\n";
                        if ($this->request->getPost('status') == "") echo "status ID required\n";
                    } else {
                        if ($this->request->getPost('status') == "true") {
                            if (!haveRole(decode($this->request->getPost('group')), $this->request->getPost('role'))) {
                                $checkRole = new GroupHaveRole();
                                $checkRole->group_id = decode($this->request->getPost('group'));
                                $checkRole->role_id = $this->request->getPost('role');
                                $checkRole->save();
                            }
                        } else {
                            $checkRole = GroupHaveRole::findFirst("group_id='" . decode($this->request->getPost('group')) . "' AND role_id='" . $this->request->getPost('role') . "'");
                            if ($checkRole) {
                                if ($checkRole->delete() == false) {
                                    echo "cant delete";
                                } else {
                                    echo 'deleted';
                                }
                            }
                        }
                        echo "Group " . $this->request->getPost('group') . "\n";
                        echo "Role " . $this->request->getPost('role') . "\n";
                        echo "Status " . $this->request->getPost('status') . "\n";
                        echo "success";
                    }
                }
            }
            $this->view->pick(['system/role']);
        } else if ($act=="src"){
            $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
            if ($this->request->isPost()){
                $src=strtolower($this->request->getPost('src'));
                $this->view->groups=Groups::find(array("conditions"=>"lower(name) LIKE '%".$src."%' OR lower(description) LIKE '%".$src."%'"));
                $this->view->pick(['system/src-group']);
            } else {
                $this->view->pick(['error/404']);
            }
        } else if ($act=="src-result"){
            $this->view->disable();
            echo "src result: ";
            echo $this->request->getPost('src');
            echo '<a href="'.$this->url->get('system/group').'"><i class="close icon"></i></a>';
        } else {
            $currentPage = is_numeric($act) ? (int) $act : 1;
            $data=Groups::find();
            $paginator = new Phalcon\Paginator\Adapter\Model(
                [
                    "data"  => $data,
                    "limit" => 15,
                    "page"  => $currentPage,
                ]
            );
            $this->view->page = $paginator->getPaginate();
        }
    }
    public function settingAction($act=null, $id=null, $status=null){
        $this->view->act=$act;
        $this->view->id=$id;
        $this->view->status=$status;
        $error=new ArrayObject();
        $this->view->menu="setting";

    }
}

