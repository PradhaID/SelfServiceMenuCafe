<?php

/**
 * Created by PhpStorm.
 * User: Aditya Y Pradhana
 * Date: 28/04/2017
 * Time: 1:27 PM
 */
class FunctionLib
{
    function cryptPass($password){
        $password_hash=password_hash($password, PASSWORD_BCRYPT, array('cost' => 10));
        return $password_hash;
    }
    function isUUID($uuid){
        if (!is_string($uuid) || (preg_match('/^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/', $uuid) !== 1)) {
            return false;
        } else return true;
    }
    function bigHeader(){
        ?>
        <img class="ui small image" src="https://cafe.warungcsi.id/img/logo.png">
        <h1 style="margin: 0;">Sultan Cafe, Music & Barbershop</h1>
        <h2 style="margin: 0;">Jln. Raya Kesambi No.142 Cirebon - Jawa Barat</h2>
        <?php
    }
    function month($lang="en", $num=null){
        $month = new ArrayObject();
        if($lang="en"){
            $month[1]="January";
            $month[2]="February";
            $month[3]="March";
            $month[4]="April";
            $month[5]="May";
            $month[6]="June";
            $month[7]="July";
            $month[8]="August";
            $month[9]="September";
            $month[10]="October";
            $month[11]="November";
            $month[12]="December";
        } else {
            $month[1]="Januari";
            $month[2]="Februari";
            $month[3]="Mareh";
            $month[4]="April";
            $month[5]="Mei";
            $month[6]="Juni";
            $month[7]="Juli";
            $month[8]="Agustus";
            $month[9]="September";
            $month[10]="Oktober";
            $month[11]="November";
            $month[12]="Desember";
        }
        if ($num==null)
            return $month;
        else return $month[$num];
    }
    
    function createFolder($main){
        $year = $main . date('Y');
        $month = $main . date('Y') . '/' . date('m');
        if (file_exists($year)) {
            if (!file_exists($month)) {
                mkdir($month, 0777);
            }
        } else {
            mkdir($year, 0777);
            mkdir($month, 0777);
        }
        return $month.'/';
    }
    function realUniqID($lenght = 13) {
        // uniqid gives 13 chars, but you could adjust it to your needs.
        if (function_exists("random_bytes")) {
            $bytes = random_bytes(ceil($lenght / 2));
        } elseif (function_exists("openssl_random_pseudo_bytes")) {
            $bytes = openssl_random_pseudo_bytes(ceil($lenght / 2));
        } else {
            throw new Exception("no cryptographically secure random function available");
        }
        return substr(bin2hex($bytes), 0, $lenght);
    }
}