<?php

class SaleController extends \Phalcon\Mvc\Controller
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
    public function invoiceAction($act=null, $id=null, $status=null){
        $this->view->act=$act;
        $this->view->id=$id;
        $this->view->status=$status;
        $error=new ArrayObject();
        $this->view->menu="invoice";
        if ($act=="detail"){
            $func=new FunctionLib();
            if ($func->isUUID($id)){
                $invoice=Invoice::findFirst(array("conditions"=>"id='".$id."'"));
                $vinvoice=VInvoice::findFirst(array("conditions"=>"id='".$id."'"));
                if (isset($invoice->id)){
                    if ($this->request->isPost()){
                        if ($this->request->getPost('amount')<$invoice->total){
                            $error->amount=true;
                        } else {
                            $invoice->customer_name=$this->request->getPost('name');
                            $invoice->address=$this->request->getPost('address');
                            $invoice->pay_amount=$this->request->getPost('amount');
                            $invoice->status=5;
                            if ($invoice->save()){
                                $this->response->redirect('sale/invoice/detail/'.$id.'/success');
                            } else {
                                $error->save=$invoice->getMessages();
                            }
                        }
                    }
                    $this->view->error=$error;
                    $this->view->invoice=$vinvoice;
                    $this->view->details=InvoiceDetails::find(array("conditions"=>"invoice='".$invoice->id."'"));
                    $this->view->pick(['sale/detail-invoice']);
                } else {
                    $this->view->pick(['error/404']);
                }
            } else {
                $this->view->pick(['error/403']);
            }
        } else if ($act=="src"){
            $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
            if ($this->request->isPost()){
                $src=strtolower($this->request->getPost('src'));
                $this->view->invoices=VInvoice::find(array("conditions"=>"cast(number as text) LIKE '%".$src."%'"));
                $this->view->pick(['sale/src-invoice']);
            } else {
                $this->view->pick(['error/404']);
            }
        } else if ($act=="src-result"){
            $this->view->disable();
            echo "src result: ";
            echo $this->request->getPost('src');
            echo '<a href="'.$this->url->get('sale/invoice').'"><i class="close icon"></i></a>';
        } else {
            $currentPage = is_numeric($act) ? (int) $act : 1;
            $data=VInvoice::find(array("order"=>"created_at desc"));
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

