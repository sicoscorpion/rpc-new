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
    return $data["data"][0];
  }


  public function register_new_user($db, $firstName, $lastName, $email, 
    $password, $position, $role) {
    
    if(sizeof(Users_model::get_user_by_email($db, $email)) > 0) {
      return false;
    }

    // $has_role = loadModel('has_role_model');
    
    if($password != null) {
      $hash = Password::make($password, PASSWORD_BCRYPT, array("cost" => 10));
    } else {
      $hash = null;
    }
    

    $new_user = $db->insert("Users", array(
      'email' => $email,
      'password' => $hash,
      'first_name' => $firstName,
      'last_name' => $lastName), array());


    $add_user_role = Users_model::add_role($db, $email, $hash, 
      $firstName, $lastName, "x-large", $position, $role);

    if ($role == null)
      return true;
    elseif ($role == "admin") {
      $admin_registration = Users_model::register_new_admin($db, $email, "x-large", 
        $position);

      if (!$admin_registration) {
        return false;
      }
    } else {
      $coach_registration = Users_model::register_new_coach($db, $email, "x-large", 
        $position);

      if (!$coach_registration) {
        return false;
      }
    }
    return true;
  }

  public function get_user_by_email($db, $email) {
    return $db->query("SELECT email FROM "."Users WHERE email = :email", array(':email' => $email));
  }

  public function add_role($db, $email, $password, $first_name, $last_name, $shirt_size, $position, $role) {
    $array = array(
      'user_email' => $email,
      'password' => $password,
      'first_name' => $first_name,
      'last_name' => $last_name,
      'shirt_size' => $shirt_size);


    if ($role == 'admin') {
      $array['admin'] = true;
      $array['position'] = $position;
    } elseif ($role == 'coach') {
      $array['coach'] = true; 
      $array['position'] = $position;
    }

    $db->insert("HasRole", $array, array());
    return true;
  }
  public function register_new_admin($db, $email, $shirt_size, $position)
  {
    $db->insert("Admins", array(
      'user_email' => $email,
      'shirt_size' => $shirt_size,
      'position' => $position), array());
    
    return true;
  }
  public function register_new_coach($db, $email, $shirt_size, $position) {
    $db->insert("Coaches", array(
      'user_email' => $email,
      'shirt_size' => $shirt_size,
      'position' => $position), array());
    return true;
  }
}
?>