<?php
  class Users_model {

    public function __construct(){
      parent::__construct();
    } 

    public function get_users($db){
      $data = $db->query("SELECT * FROM Users, HasRole WHERE Users.email = HasRole.user_email");
      return $data;
    }

    public function get_hash($db, $email){
      $data = $db->select("Users", "*", array('email' => $email));
      // var_dump($data["data"][0]["password"]);
      return $data["data"][0];
    }
  }
?>