<?php

class Groups extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Primary
     * @Identity
     * @Column(type="integer", length=16, nullable=false)
     */
    public $id;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=false)
     */
    public $name;

    /**
     *
     * @var string
     * @Column(type="string", length=150, nullable=true)
     */
    public $description;

    /**
     *
     * @var double
     * @Column(type="double", length=20, nullable=false)
     */
    public $transaction_limit;

    /**
     *
     * @var double
     * @Column(type="double", length=20, nullable=false)
     */
    public $deposit_limit;

    /**
     *
     * @var double
     * @Column(type="double", length=20, nullable=false)
     */
    public $withdrawal_limit;

    /**
     *
     * @var double
     * @Column(type="double", length=20, nullable=true)
     */
    public $financing_limit;

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
     * Initialize method for model.
     */
    public function initialize()
    {
        $this->setSchema("system");
    }

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'groups';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return Groups[]|Groups
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return Groups
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
