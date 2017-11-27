<?php

class Invoice extends \Phalcon\Mvc\Model
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
     * @var integer
     * @Identity
     * @Column(type="integer", nullable=false)
     */
    public $number;

    /**
     *
     * @var string
     * @Column(type="string", length=25, nullable=true)
     */
    public $customer_name;

    /**
     *
     * @var string
     * @Column(type="string", length=100, nullable=true)
     */
    public $address;

    /**
     *
     * @var double
     * @Column(type="double", length=5, nullable=true)
     */
    public $tax;

    /**
     *
     * @var double
     * @Column(type="double", length=5, nullable=true)
     */
    public $discount;

    /**
     *
     * @var double
     * @Column(type="double", length=20, nullable=true)
     */
    public $total;

    /**
     *
     * @var integer
     * @Column(type="integer", length=16, nullable=true)
     */
    public $pay_amount;

    /**
     *
     * @var string
     * @Column(type="string", length=2, nullable=true)
     */
    public $table_number;

    /**
     *
     * @var integer
     * @Column(type="integer", length=16, nullable=true)
     */
    public $status;

    /**
     *
     * @var string
     * @Column(type="string", length=15, nullable=true)
     */
    public $created_by;

    /**
     *
     * @var string
     * @Column(type="string", length=15, nullable=true)
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
        return 'invoice';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return Invoice[]|Invoice
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return Invoice
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
