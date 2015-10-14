<?php
  class Users_model {

  public function __construct(){
    parent::__construct();
  } 

  public function get_users($db){
    $data = $db->query("SELECT * FROM Users, HasRole WHERE Users.user_id = HasRole.user_id");
    return $data;
  }

  public function get_hash($db, $email){
    $data = $db->select("Users", "*", array('email' => $email));
    return $data["data"][0];
  }

  public function add_user($db, $data) {
    if(sizeof(Users_model::get_user_by_email($db, $data->email)) > 0) {
      return "Error adding data - Entry may already exist";
    }
    if($data->password != null) {
      $hash = Password::make($data->password, PASSWORD_BCRYPT, array("cost" => 10));
      $data->password = $hash;
    } else {
      $hash = null;
    }
    

    $new_user = $db->insert("Users", $data, array());
    return $new_user;
  }

  public function add_hasRole($db, $data, $role) {


    if ($role == 'admin') {
      $data->admin = true;
      $db->insert("Admins", array(
        'user_id' => $data->user_id,
        'shirt_size' => $data->shirt_size,
        'position' => $data->position), array());
    } elseif ($role == 'coach') {
      $data->coach = true; 
      $db->insert("Coaches", array(
        'user_id' => $data->user_id,
        'shirt_size' => $data->shirt_size,
        'position' => $data->position), array());
    }

    $added = $db->insert("HasRole", $data, array());
    return $added;
  }

  public function get_user_by_email($db, $email) {
    return $db->query("SELECT email FROM "."Users WHERE email = :email", array(':email' => $email));
  }

}
?>