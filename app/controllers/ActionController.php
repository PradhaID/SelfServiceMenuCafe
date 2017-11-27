<?php

class ActionController extends \Phalcon\Mvc\Controller
{

    public function indexAction()
    {

    }
    public function subCategoryAction(){
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $id=$this->request->getPost('id');
        $this->view->categories=Category::find(array("conditions"=>"parent='".$id."'"));
        $this->view->parent=Category::findFirst(array("conditions"=>"id='".$id."'"));
        $this->view->pick(['action/sub-category-menu']);
    }

    public function productAction(){
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $id=$this->request->getPost('id');
        $this->view->products=Product::find(array("conditions"=>"category='".$id."'"));
        $this->view->category=Category::findFirst(array("conditions"=>"id='".$id."'"));
        $this->view->pick(['action/product-menu']);
    }

    public function productDetailAction(){
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $id=$this->request->getPost('id');
        $this->view->product=Product::findFirst(array("conditions"=>"id='".$id."'"));
        $this->view->pick(['action/product-detail']);
    }
    public function cartAction($act=null){
        if ($act=="add"){
            if ($this->session->has('cart') === false)
                $this->session->set('cart',array());
            if ($this->request->isPost()){
                $this->view->disable();
                $product=Product::FindFirst(array("conditions"=>"id='".$this->request->getPost('id')."'"));
                if (isset($product->id)){
                    $carts=$this->session->get('cart');
                    $discount=$this->request->getPost('discount');
                    $update=false;
                    foreach ($carts as $key => $value){
                        if ($carts[$key]['product'] == $product->id){
                            $carts[$key]['qty'] = $carts[$key]['qty']+1;
                            $carts[$key]['total'] = ($carts[$key]['price']*$carts[$key]['qty'])-($carts[$key]['price']*$carts[$key]['qty']*$discount/100);
                            $update=true;
                        }
                    }
                    if (!$update){
                        $cart=array();
                        $cart['product']=$product->id;
                        $cart['name']=$product->name;
                        $cart['description']=$product->description;
                        $cart['price']=$product->selling_price;
                        $cart['qty']=1;
                        $cart['discount']=$discount;
                        $cart['total']=($product->selling_price*$cart['qty'])-(($product->selling_price*$cart['qty'])*$discount/100);
                        array_push($carts,$cart);
                    }
                    $this->session->set('cart',$carts);
                } else {
                    echo 'failed';
                }
            }
        } else if ($act=='get'){
            $this->view->disable();
            $this->response->setContentType('application/json', 'UTF-8');
            echo json_encode($this->session->get('cart'));
        } else if ($act=="remove"){
            $this->view->disable();
            $id=$this->request->getPost('id');
            $carts=$this->session->get('cart');
            foreach ($carts as $key => $value){
                if ($carts[$key]['product'] == $id){
                    unset($carts[$key]);
                }
            }
            $this->session->set('cart',$carts);
        } else if ($act=="erase"){
            $this->view->disable();
            $this->session->set('cart',array());
            $this->session->set('table',"");
        } else if ($act=='pay') {
            $this->view->disable();
            $random = new \Phalcon\Security\Random();
            $total=0;
            foreach ($this->session->get('cart') as $cart){
                $total=$total+$cart['total'];
            }
            $this->db->begin();
            $invoice=new Invoice();
            $invoice->id=$random->uuid();
            $invoice->total=$total;
            $invoice->table_number=$this->session->get('table');
            $invoice->status=6;
            $invoice->created_by=$invoice->updated_by='abc';
            if ($invoice->create()){
                $status=true;
                foreach ($this->session->get('cart') as $cart){
                    $product=Product::findFirst(array("conditions"=>"id='".$cart['product']."'"));
                    $detail=new InvoiceDetails();
                    $detail->invoice=$invoice->id;
                    $detail->product=$cart['product'];
                    $detail->product_name=$cart['name'];
                    $detail->product_description=$cart['description'];
                    $detail->capital_price=$product->capital_price;
                    $detail->selling_price=$cart['price'];
                    $detail->quantity=$cart['qty'];
                    $detail->discount=$cart['discount'];
                    $detail->total=$cart['total'];
                    $detail->profit=$cart['price']-$product->capital_price;
                    $detail->created_by=$detail->updated_by='abc';
                    if ($detail->save()===false){
                        $status=false;
                        print_r($detail->getMessages());
                        break;
                    }
                }
                if ($status){
                    $table=Table::findFirst(array("conditions"=>"id='".$invoice->table_number."'"));
                    $table->available=false;
                    $table->save();
                    $func=new FunctionLib();
                    $func->bigHeader();
                    ?>
                    <hr>
                    Invoice No : #<?= $invoice->number; ?>
                    <table>
                        <tbody>
                        <?php foreach ($this->session->get('cart') as $cart){ ?>
                            <tr>
                                <td><?= $cart['qty']; ?>x <?= $cart['name']; ?></td>
                                <td style="text-align: right"><?= number_format($cart['total'],0); ?></td>
                            </tr>
                        <?php } ?>
                        </tbody>
                        <tfoot>
                        <tr style="border-top: 1px solid #666666">
                            <td style="font-weight: bold">Total</td>
                            <td style="font-weight: bold;text-align: right"><?= number_format($invoice->total,0); ?></td>
                        </tr>
                        </tfoot>
                    </table>
                    <?php
                    $this->session->set('cart',array());
                    $this->session->set('table',"");
                    $this->db->commit();
                } else {
                    $this->db->rollback();
                    echo 'failed';
                    print_r($invoice->getMessages());
                    return;
                }

            } else {
                $this->db->rollback();
                echo 'failed';
                return;
            }

        }

    }

    public function tableAction($act=null){
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        if ($act=="selector"){
            if ($this->request->isPost()){
                $floor=$this->request->getPost('floor')=="" ? 1 : $this->request->getPost('floor');
                $capacity=$this->request->getPost('capacity');
                $smoke=$this->request->getPost('smoke');
                if ($capacity!="" && $smoke!=""){
                    $table=Table::find(array("conditions"=>"available=true AND floor=".$floor." AND capacity>=".$capacity." AND smoke=".$smoke,"order"=>"id"));
                } else if ($capacity!="" && $smoke==""){
                    $table=Table::find(array("conditions"=>"available=true AND floor=".$floor." AND capacity>=".$capacity,"order"=>"id"));
                } else if ($capacity=="" && $smoke!=""){
                    $table=Table::find(array("conditions"=>"available=true AND floor=".$floor." AND smoke=".$smoke,"order"=>"id"));
                } else {
                    $table=Table::find(array("conditions"=>"available=true AND floor=".$floor,"order"=>"id"));
                }

                $this->view->tables=$table;
                $this->view->pick(['action/table-selector']);
            } else {
                $this->view->disable();
                echo "Please select option first";
            }
        } else if ($act=="select"){
            $this->view->disable();
            $id=$this->request->getPost('id');
            $table=Table::findFirst(array("id='".$id."'"));
            if (isset($table->id)){
                $this->session->set('table',$id);
            } else {
                echo 'failed';
            }
        } else if ($act=="menu"){
            $this->view->pick(['action/table-menu']);
        }
    }
}

