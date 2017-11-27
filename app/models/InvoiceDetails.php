<?php

class InvoiceDetails extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var string
     * @Primary
     * @Column(type="string", length=36, nullable=false)
     */
    public $id;

    /**
     *
     * @var string
     * @Column(type="string", length=36, nullable=false)
     */
    public $invoice;

    /**
     *
     * @var string
     * @Column(type="string", length=36, nullable=false)
     */
    public $product;

    /**
     *
     * @var string
     * @Column(type="string", length=100, nullable=false)
     */
    public $product_name;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $product_description;

    /**
     *
     * @var double
     * @Column(type="double", length=20, nullable=false)
     */
    public $capital_price;

    /**
     *
     * @var double
     * @Column(type="double", length=20, nullable=false)
     */
    public $selling_price;

    /**
     *
     * @var integer
     * @Column(type="integer", length=32, nullable=false)
     */
    public $quantity;

    /**
     *
     * @var double
     * @Column(type="double", length=5, nullable=false)
     */
    public $discount;

    /**
     *
     * @var double
     * @Column(type="double", length=20, nullable=false)
     */
    public $total;

    /**
     *
     * @var double
     * @Column(type="double", length=20, nullable=false)
     */
    public $profit;

    /**
     *
     * @var string
     * @Column(type="string", length=15, nullable=false)
     */
    public $created_by;

    /**
     *
     * @var string
     * @Column(type="string", length=15, nullable=false)
     */
    public $updated_by;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $created_at;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $updated_at;

    /**
     * Initialize method for model.
     */
    public function initialize()
    {
        $this->setSchema("content");
    }

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'invoice_details';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return InvoiceDetails[]|InvoiceDetails
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return InvoiceDetails
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
