<?php

use Phalcon\Validation;
use Phalcon\Mvc\Model\Validator\Email as EmailValidator;

class VUsers extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Column(type="integer", length=16, nullable=true)
     */
    public $group_id;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=true)
     */
    public $group_name;

    /**
     *
     * @var string
     * @Column(type="string", length=150, nullable=true)
     */
    public $group_description;

    /**
     *
     * @var string
     * @Column(type="string", length=150, nullable=true)
     */
    public $name;

    /**
     *
     * @var string
     * @Column(type="string", length=100, nullable=true)
     */
    public $email;

    /**
     *
     * @var string
     * @Column(type="string", length=15, nullable=true)
     */
    public $username;

    /**
     *
     * @var string
     * @Column(type="string", length=150, nullable=true)
     */
    public $password;

    /**
     *
     * @var string
     * @Column(type="string", length=100, nullable=true)
     */
    public $password_verify;

    /**
     *
     * @var string
     * @Column(type="string", length=15, nullable=true)
     */
    public $theme;

    /**
     *
     * @var string
     * @Column(type="string", length=15, nullable=true)
     */
    public $phone;

    /**
     *
     * @var string
     * @Column(type="string", length=1, nullable=true)
     */
    public $gender;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $date_of_birth;

    /**
     *
     * @var string
     * @Column(type="string", length=2, nullable=true)
     */
    public $language;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $last_change_pass;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $last_used_pass;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $kicked_out;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $is_logged_in;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $last_logged_in_from;

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
     * Validations and business logic
     *
     * @return boolean
     */
    public function validation()
    {
        $validator = new Validation();

        $validator->add(
            'email',
            new EmailValidator(
                [
                    'model'   => $this,
                    'message' => 'Please enter a correct email address',
                ]
            )
        );

        return $this->validate($validator);
    }

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
        return 'v_users';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return VUsers[]|VUsers
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return VUsers
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
