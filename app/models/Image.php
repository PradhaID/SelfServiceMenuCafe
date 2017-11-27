<?php

class Image extends \Phalcon\Mvc\Model
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
    public $product;

    /**
     *
     * @var string
     * @Column(type="string", length=100, nullable=false)
     */
    public $name;

    /**
     *
     * @var string
     * @Column(type="string", length=250, nullable=false)
     */
    public $description;

    /**
     *
     * @var string
     * @Column(type="string", length=100, nullable=false)
     */
    public $original_name;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=false)
     */
    public $content_type;

    /**
     *
     * @var double
     * @Column(type="double", length=20, nullable=false)
     */
    public $size;

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
        return 'image';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return Image[]|Image
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return Image
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
