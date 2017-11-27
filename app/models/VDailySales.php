<?php

class VDailySales extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $date;

    /**
     *
     * @var integer
     * @Column(type="integer", nullable=true)
     */
    public $sale;

    /**
     *
     * @var double
     * @Column(type="double", nullable=true)
     */
    public $total;

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
        return 'v_daily_sales';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return VDailySales[]|VDailySales
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return VDailySales
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
