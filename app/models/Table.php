<?php

class Table extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var string
     * @Primary
     * @Column(type="string", length=2, nullable=false)
     */
    public $id;

    /**
     *
     * @var integer
     * @Column(type="integer", length=16, nullable=false)
     */
    public $floor;

    /**
     *
     * @var string
     * @Column(type="string", length=100, nullable=true)
     */
    public $description;

    /**
     *
     * @var integer
     * @Column(type="integer", length=16, nullable=false)
     */
    public $capacity;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $smoke;

    /**
     *
     * @var double
     * @Column(type="double", length=5, nullable=true)
     */
    public $position_x;

    /**
     *
     * @var double
     * @Column(type="double", length=5, nullable=true)
     */
    public $position_y;

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
        return 'table';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return Table[]|Table
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return Table
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
