<?php

class ContentController extends \Phalcon\Mvc\Controller
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

    public function categoryAction($act=null,$id=null,$status=null){
        $this->view->menu="category";
        $this->view->title="Category";
        $this->view->act=$act;
        $this->view->id=$id;
        $this->view->status=$status;
        $error= new ArrayObject();
        $this->view->categories=Category::find(array("conditions"=>"parent is null"));
        if ($act == "add"){
            if ($this->request->isPost()){
                if ($this->request->getPost("name") == "" ||
                    $this->request->getPost("description") == ""
                )
                {
                    if ($this->request->getPost("name") == "") $error->name=true;
                    if ($this->request->getPost("description") == "") $error->description=true;
                }
                else{
                    $category = new Category();
                    $category->name=$this->request->getPost("name");
                    $category->description=$this->request->getPost("description");
                    $category->parent=$this->request->getPost("parent")=="" ? NULL : $this->request->getPost("parent");
                    $category->created_by=$category->updated_by=$this->session->get("username");
                    if ($category->create()){
                        $this->response->redirect("content/category");
                    }else{
                        $error->save=$category->getMessages();
                    }
                }
            }
            $this->view->error=$error;
            $this->view->pick(['content/add-category']);
        }
        else if ($act == "edit"){
            if ($id==null){
                $this->view->disable();
                echo "Id is null";
                exit;
            }
            $category = Category::findFirst(array("conditions"=>"id='".$id."'"));
            if (isset($category->id)){
                if ($this->request->isPost()){
                    if ($this->request->getPost("name") == "" ||
                        $this->request->getPost("description") == ""
                    )
                    {
                        if ($this->request->getPost("name") == "") $error->name=true;
                        if ($this->request->getPost("description") == "") $error->description=true;
                    }
                    else {
                        $category = new Category();
                        $category->name = $this->request->getPost("name");
                        $category->description = $this->request->getPost("description");
                        $category->parent = $this->request->getPost("parent") == "" ? NULL : $this->request->getPost("parent");
                        $category->created_by = $category->updated_by = $this->session->get("username");
                        if ($category->save()){
                            $this->response->redirect("content/category");
                        }else{
                            $error->save=$category->getMessages();
                        }
                    }
                }
                $this->view->categories=Category::find(array("conditions"=>"parent is null AND id!='".$id."'"));
                $this->view->category=$category;
                $this->view->pick(['content/edit-category']);
            } else {
                $this->view->pick(['error/404']);
            }
            $this->view->act="edit category";
        } else if ($act=="src"){
            $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
            if ($this->request->isPost()){
                $src=strtolower($this->request->getPost('src'));
                $this->view->categories=VCategory::find(array("conditions"=>"lower(name) LIKE '%".$src."%' OR lower(description) LIKE '%".$src."%'" ));
                $this->view->pick(['content/src-category']);
            } else {
                $this->view->pick(['error/404']);
            }
        } else if ($act=="src-result"){
            $this->view->disable();
            echo "src result: ";
            echo $this->request->getPost('src');
            echo '<a href="'.$this->url->get('content/category').'"><i class="close icon"></i></a>';
        } else {
            $currentPage = is_numeric($act) ? (int) $act : 1;
            $data=VCategory::find();
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



    public function productAction($act=null,$id=null,$status=null){
        $this->view->menu="product";
        $this->view->title="Product";
        $this->view->act=$act;
        $this->view->id=$id;
        $this->view->status=$status;
        $error= new ArrayObject();
        $this->view->categories=Category::find(array("conditions"=>"parent is null"));
        if ($act == "add"){
            if ($this->request->isPost()){
                if ($this->request->getPost("category") == "" ||
                    $this->request->getPost("name") == "" ||
                    $this->request->getPost("description") == "" ||
                    $this->request->getPost("capital_price") == "" ||
                    $this->request->getPost("selling_price") == ""
                )
                {
                    if ($this->request->getPost("category") == "") $error->category=true;
                    if ($this->request->getPost("name") == "") $error->name=true;
                    if ($this->request->getPost("description") == "") $error->description=true;
                    if ($this->request->getPost("capital_price") == "") $error->capital_price=true;
                    if ($this->request->getPost("selling_price") == "") $error->selling_price=true;
                }
                else{
                    $product = new Product();
                    $product->name=$this->request->getPost("name");
                    $product->category=$this->request->getPost("category");
                    $product->description=$this->request->getPost("description");
                    $product->capital_price=$this->request->getPost("capital_price");
                    $product->selling_price=$this->request->getPost("selling_price");
                    $product->created_by=$product->updated_by=$this->session->get("username");
                    if ($product->create()){
                        $this->response->redirect("content/product");
                    }else{
                        $error->save=$product->getMessages();
                    }
                }
            }
            $this->view->error=$error;
            $this->view->pick(['content/add-product']);
        }
        else if ($act == "edit"){
            $func=new FunctionLib();
            if ($func->isUUID($id)){
                $product = Product::findFirst(array("conditions"=>"id='".$id."'"));
                if (isset($product->id)){
                    if ($this->request->isPost()){
                        if ($this->request->getPost("category") == "" ||
                            $this->request->getPost("name") == "" ||
                            $this->request->getPost("description") == "" ||
                            $this->request->getPost("capital_price") == "" ||
                            $this->request->getPost("selling_price") == ""
                        )
                        {
                            if ($this->request->getPost("category") == "") $error->category=true;
                            if ($this->request->getPost("name") == "") $error->name=true;
                            if ($this->request->getPost("description") == "") $error->description=true;
                            if ($this->request->getPost("capital_price") == "") $error->capital_price=true;
                            if ($this->request->getPost("selling_price") == "") $error->selling_price=true;
                        } else {
                            $product->name=$this->request->getPost("name");
                            $product->category=$this->request->getPost("category");
                            $product->description=$this->request->getPost("description");
                            $product->capital_price=$this->request->getPost("capital_price");
                            $product->selling_price=$this->request->getPost("selling_price");
                            $product->created_by=$product->updated_by=$this->session->get("username");
                            if ($product->save()){
                                $this->response->redirect("content/product");
                            }else{
                                $error->save=$product->getMessages();
                            }
                        }
                    }
                    $this->view->products=Product::find(array("conditions"=>"id!='".$id."'"));
                    $this->view->product=$product;
                    $this->view->pick(['content/edit-product']);
                } else {
                    $this->view->pick(['error/404']);
                }
                $this->view->act="edit product";
            } else {
                $this->view->pick(['error/404']);
            }

        } else if ($act=="detail"){
            $func=new FunctionLib();
            if ($func->isUUID($id)){
                $product = VProduct::findFirst(array("conditions"=>"id='".$id."'"));
                if (isset($product->id)) {
                    $this->view->product=$product;
                    $this->view->images=Image::find(array("conditions"=>"product='".$product->id."'"));
                    $this->view->pick(['content/detail-product']);
                } else {
                    $this->view->pick(['error/404']);
                }
            } else {
                $this->view->pick(['error/404']);
            }
        }  else if ($act=="upload"){
            $func=new FunctionLib();
            //cek jika id adalah valid UUID
            if ($func->isUUID($id)){
                $product = VProduct::findFirst(array("conditions"=>"id='".$id."'"));
                //cek apakah produk id ditemukan
                if (isset($product->id)){
                    //jika terjadi submit
                    if ($this->request->isPost()){
                        $this->view->disable();
                        //inisialisasi variable upload
                        $target_dir = $func->createFolder("./files/upload/");
                        $extension = pathinfo($_FILES["file"]["name"],PATHINFO_EXTENSION);
                        $base_name=pathinfo($_FILES["file"]["name"],PATHINFO_BASENAME);
                        $name=date('ymdhis').'_'.$func->realUniqID(rand(9,13)).'.'.$extension;
                        $target_file = $target_dir . $name;

                        //validasi upload gambar
                        if (file_exists($target_file) || $_FILES["file"]["size"] > 500000 || getimagesize($_FILES["file"]["tmp_name"]==false)){
                            if (file_exists($target_file)) $error->exist=true;
                            if (file_exists($_FILES["file"]["size"] > 500000)) $error->size=true;
                            if (getimagesize($_FILES["file"]["tmp_name"]==false)) $error->type=true;
                        } else {
                            if (move_uploaded_file($_FILES["file"]["tmp_name"], $target_file)) {
                                $image=new Image();
                                $image->product=$product->id;
                                $image->name=$name;
                                $image->description=$base_name;
                                $image->original_name=$base_name;
                                $image->content_type=mime_content_type($target_file);
                                $image->size=filesize($target_file);
                                $image->created_by=$image->updated_by=$this->session->get('username');
                                if ($image->create()){
                                    $this->response->redirect('content/product/detail/'.$id.'/success');
                                } else {
                                    $error->save=$image->getMessages();
                                }
                            } else {
                                $error->failed=true;
                            }
                        }
                        print_r($error);
                    }
                } else {
                    $this->view->pick(['error/404']);
                }
            } else {
                $this->view->pick(['error/403']);
            }
        } else if ($act=="delete-image"){
            $this->view->disable();
            $val=$this->request->getPost('id');
            $image = Image::findFirst(array("conditions" => "id='" . $val . "'"));
            if ($image!==false){
                $url = "./files/upload/" . date('Y', strtotime($image->created_at)) . "/" . date('m', strtotime($image->created_at)) . "/";
                
                if ($image->delete() === false){
                    echo 'we can\'t delete';
                } else {
                    echo 'success';
                    unlink($url.$image->original_name);
                }
            } else {
                echo 'file not found';
            }
        } else if ($act=="src"){
            $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
            if ($this->request->isPost()){
                $src=strtolower($this->request->getPost('src'));
                $this->view->products=VProduct::find(array("conditions"=>"lower(name) LIKE '%".$src."%' OR lower(description) LIKE '%".$src."%' OR cast(capital_price as text) LIKE '%".$src."%' OR cast(selling_price as text) LIKE '%".$src."%'"));
                $this->view->pick(['content/src-product']);
            } else {
                $this->view->pick(['error/404']);
            }
        } else if ($act=="src-result"){
            $this->view->disable();
            echo "src result: ";
            echo $this->request->getPost('src');
            echo '<a href="'.$this->url->get('content/product').'"><i class="close icon"></i></a>';
        } else {
            $currentPage = is_numeric($act) ? (int) $act : 1;
            $data=VProduct::find();
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

    public function tableAction($act=null, $id=null, $status=null){
        $this->view->act=$act;
        $this->view->id=$id;
        $this->view->status=$status;
        $error=new ArrayObject();
        $this->view->menu="table";
        if ($act=="add"){
            if ($this->request->isPost()){
                if (
                    $this->request->getPost('number')=="" ||
                    $this->request->getPost('floor')=="" ||
                    $this->request->getPost('capacity')=="" ||
                    $this->request->getPost('smoke')=="" ||
                    $this->request->getPost('description')=="" ||
                    $this->request->getPost('x')=="" ||
                    $this->request->getPost('y')==""
                ){
                    if ($this->request->getPost('number')=="") $error->number=true;
                    if ($this->request->getPost('floor')=="") $error->floor=true;
                    if ($this->request->getPost('capacity')=="") $error->capacity=true;
                    if ($this->request->getPost('smoke')=="") $error->smoke=true;
                    if ($this->request->getPost('description')=="") $error->description=true;
                    if ($this->request->getPost('x')=="") $error->x=true;
                    if ($this->request->getPost('y')=="") $error->y=true;
                } else {
                    $table=new Table();
                    $table->id=$this->request->getPost('number');
                    $table->floor=$this->request->getPost('floor');
                    $table->capacity=$this->request->getPost('capacity');
                    $table->smoke=$this->request->getPost('smoke');
                    $table->description=$this->request->getPost('description');
                    $table->position_x=$this->request->getPost('x');
                    $table->position_y=$this->request->getPost('y');
                    $table->available=$this->request->getPost('available');
                    $table->created_by=$table->updated_by=$this->session->get('username');
                    if ($table->create()){
                        $this->response->redirect('content/table/edit/'.encode($table->id).'/successadd');
                    } else {
                        $error->save=$table->getMessages();
                    }
                }
            }
            $this->view->error=$error;
            $this->view->pick(['content/add-table']);
        } else if ($act=="edit"){
            $table=Table::findFirst(array("conditions"=>"id='".decode($id)."'"));
            if (isset($table->id)){

                $this->view->table=$table;
                if ($this->request->isPost()){
                    if (
                        $this->request->getPost('number')=="" ||
                        $this->request->getPost('floor')=="" ||
                        $this->request->getPost('capacity')=="" ||
                        $this->request->getPost('smoke')=="" ||
                        $this->request->getPost('description')=="" ||
                        $this->request->getPost('x')=="" ||
                        $this->request->getPost('y')==""
                    ){
                        if ($this->request->getPost('number')=="") $error->number=true;
                        if ($this->request->getPost('floor')=="") $error->floor=true;
                        if ($this->request->getPost('capacity')=="") $error->capacity=true;
                        if ($this->request->getPost('smoke')=="") $error->smoke=true;
                        if ($this->request->getPost('description')=="") $error->description=true;
                        if ($this->request->getPost('x')=="") $error->x=true;
                        if ($this->request->getPost('y')=="") $error->y=true;
                    } else {
                        $table->id=$this->request->getPost('number');
                        $table->floor=$this->request->getPost('floor');
                        $table->capacity=$this->request->getPost('capacity');
                        $table->smoke=$this->request->getPost('smoke');
                        $table->description=$this->request->getPost('description');
                        $table->position_x=$this->request->getPost('x');
                        $table->position_y=$this->request->getPost('y');
                        $table->available=$this->request->getPost('available');
                        $table->updated_by=$this->session->get('username');
                        $table->updated_at=date('Y-m-d H:i:s');
                        if ($table->save()){
                            $this->response->redirect('content/table/edit/'.encode($table->id).'/success');
                        } else {
                            $error->save=$table->getMessages();
                        }
                    }
                }
                $this->view->error=$error;
                $this->view->pick(['content/edit-table']);
            } else {
                $this->view->pick(['error/404']);
            }
        } else if ($act=="src"){
            $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
            if ($this->request->isPost()){
                $src=strtolower($this->request->getPost('src'));
                $this->view->tables=Table::find(array("conditions"=>"cast(floor as text) LIKE '%".$src."%' OR cast(capacity as text) LIKE '%".$src."%' OR lower(id) LIKE '%".$src."%'"));
                $this->view->pick(['content/src-table']);
            } else {
                $this->view->pick(['error/404']);
            }
        } else if ($act=="src-result"){
            $this->view->disable();
            echo "src result: ";
            echo $this->request->getPost('src');
            echo '<a href="'.$this->url->get('content/table').'"><i class="close icon"></i></a>';
        } else {
            $currentPage = is_numeric($act) ? (int) $act : 1;
            $data=Table::find();
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
}

