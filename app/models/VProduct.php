<?php

class VProduct extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var string
     * @Column(type="string", length=36, nullable=true)
     */
    public $id;

    /**
     *
     * @var string
     * @Column(type="string", length=36, nullable=true)
     */
    public $category;

    /**
     *
     * @var string
     * @Column(type="string", length=25, nullable=true)
     */
    public $category_name;

    /**
     *
     * @var string
     * @Column(type="string", length=100, nullable=true)
     */
    public $category_description;

    /**
     *
     * @var string
     * @Column(type="string", length=25, nullable=true)
     */
    public $name;

    /**
     *
     * @var string
     * @Column(type="string", length=100, nullable=true)
     */
    public $description;

    /**
     *
     * @var double
     * @Column(type="double", length=20, nullable=true)
     */
    public $capital_price;

    /**
     *
     * @var double
     * @Column(type="double", length=20, nullable=true)
     */
    public $selling_price;

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
     * @Column(type="string", nullable=true)
     */
    public $created_at;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
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
        return 'v_product';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return VProduct[]|VProduct
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return VProduct
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
