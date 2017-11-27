<?php

use Phalcon\Validation;
use Phalcon\Mvc\Model\Validator\Email as EmailValidator;

class Users extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Column(type="integer", length=16, nullable=false)
     */
    public $group_id;

    /**
     *
     * @var string
     * @Column(type="string", length=150, nullable=false)
     */
    public $name;

    /**
     *
     * @var string
     * @Column(type="string", length=100, nullable=false)
     */
    public $email;

    /**
     *
     * @var string
     * @Primary
     * @Column(type="string", length=15, nullable=false)
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
     * @Column(type="string", length=15, nullable=false)
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
     * @Column(type="string", length=2, nullable=false)
     */
    public $language;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
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
     * @Column(type="string", nullable=false)
     */
    public $kicked_out;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $is_logged_in;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $last_logged_in;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $last_logged_in_from;

    /**
     *
     * @var string
     * @Column(type="string", nullable=false)
     */
    public $status;

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
     * Validations and business logic
     *
     * @return boolean
     */
    public function validation()
    {
        /*$validator = new Validation();

        $validator->add(
            'email',
            new EmailValidator(
                [
                    'model'   => $this,
                    'message' => 'Please enter a correct email address',
                ]
            )
        );

        return $this->validate($validator);*/
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
        return 'users';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return Users[]|Users
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return Users
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
