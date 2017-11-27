<?php

class GroupHaveRole extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Primary
     * @Column(type="integer", length=16, nullable=false)
     */
    public $group_id;

    /**
     *
     * @var integer
     * @Primary
     * @Column(type="integer", length=16, nullable=false)
     */
    public $role_id;

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
        return 'group_have_role';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return GroupHaveRole[]|GroupHaveRole
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return GroupHaveRole
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
