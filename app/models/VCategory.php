<?php

class VCategory extends \Phalcon\Mvc\Model
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
    public $parent;

    /**
     *
     * @var string
     * @Column(type="string", length=25, nullable=true)
     */
    public $parent_name;

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
        return 'v_category';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return VCategory[]|VCategory
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return VCategory
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
