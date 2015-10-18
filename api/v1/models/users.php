<?php
// require '.././libs/password.php';

  class Users_model {

  public function __construct(){
    parent::__construct();
  } 

  public function get_users($db){
    $data = $db->query("SELECT * FROM Users, HasRole WHERE Users.user_id = HasRole.user_id");
    return $data;
  }

  public function get_hash($db, $email){
    $data = $db->query("SELECT * FROM Users INNER JOIN HasRole ON Users.email = :email AND Users.user_id = HasRole.user_id", array('email' => $email));
    return $data;
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

  public function update_user($db, $data, $id) {
    $where_inUsers = array('user_id' => $id);    
    $user = $db->update("Users", $data, $where_inUsers, array());
    $user = $db->update("HasRole", $data, $where_inUsers, array());

    return $user;
  }

  public function update_userRole($db, $data, $role) {

    if ($role == 'admin') {
      $data->admin = true;
      $db->update("Admins", array(
        'shirt_size' => $data->shirt_size,
        'position' => $data->position), 
      array('user_id' => $data->user_id), array());
    } elseif ($role == 'coach') {
      $data->coach = true; 
      $db->update("Coaches", array(
        'shirt_size' => $data->shirt_size,
        'position' => $data->position), 
      array('user_id' => $data->user_id), array());
    }

    $added = $db->update("HasRole", $data, 
      array('user_id' => $data->user_id), array());
    return $added;
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

  public function forgotPasswordAction($db, $posted) {
    $count = $db->query("SELECT COUNT(*) FROM sent_emails WHERE email_address = 
      :email_address AND timestamp >= :time", array(':email_address' => $posted['hash'], ':time' => $posted['time_formatted']));
    $exists = self::get_user_by_email($db, $posted['email']);

    if (!$exists) {
      // Session::add('feedback_negative', "USER DOES NOT EXIST");
      return "User Doesn't Exist";
    }

    if (count($count) < 10) {

      $deactivation_stmt = $db->update("responses", array('active' => 0), array('email_address' => $posted['email']), array());

      $password_token = Password::rnum(); 
      
      $toBePosted = [];
      $toBePosted['reset_key'] = Password::rnum();
      $toBePosted['secret'] = Password::make($password_token, PASSWORD_BCRYPT, array("cost" => 10));
      $toBePosted['request_timestamp'] = date('Y-m-d H:i:s');
      $toBePosted['request_ip'] = getenv('REMOTE_ADDR');
      $toBePosted['email_address'] = $posted['email'];

      // var_dump($toBePosted);
      $result = $db->insert("responses", $toBePosted, array());
      $mail_to      = $posted['email'];  
      $mail_subject = 'Reset password';  
      $mail_body = "Hello, 
        <br><br> 
        you or somebody else requested a password reset for your account at Acadia Robotics. 
        <br><br> 
        To set a new password, please visit this link: 
        <br><br> 
        http://192.168.0.2/users/password_reset?reset_key=" . $toBePosted['reset_key'] . "&email=" . $toBePosted['email_address'] . "&password_token=" . $password_token ." 
        <br><br> 
        Do not share this link with anyone, it expires in 30 minutes.  
        <br><br> 
        If the request was not from you, simply ignore this email. Your password will not be changed. 
        <br><br> 
        Do you have further questions? Please contact us at robots@acadiau.ca. 
        <br><br> 
        Best regards, 
        <br><br> 
        robots.acadiau.ca";
      $mail = new Mail;
      $mail_sent = $mail->sendMail($mail_to, "zeratoul@localhost", "ACCOUNT ", $mail_subject, $mail_body);

      if ($mail_sent == 1) {
        $new_stmt = $db->exec('INSERT INTO sent_emails (email_address, timestamp) VALUES (:email_address, NOW())', array(':email_address' => $posted['hash']) );
        return "Mail Sent!";
      } else {
        return "Mail not sent" . $mail->getError();
      }
    }
  }

  // public function resetPasswordAction($reset_key, $email_address, $password_token, $password, $user_password_repeat) {
    
  //   $response = $this->_db->select('SELECT secret, request_timestamp FROM responses 
  //     WHERE reset_key = :reset_key AND email_address = :email_address 
  //     AND NOT used AND active', array(':reset_key' => $reset_key, ':email_address' => $email_address));
    
  //   $validatedPassword = parent::validateUserPassword($password, $user_password_repeat);
  //   if (!$validatedPassword) {
  //     Session::add('feedback_negative', "INVALID PASSWORD");
  //     return false;
  //   }
    
  //   if($response){              
  //     $created = DateTime::createFromFormat('Y-m-d G:i:s', $response[0]->request_timestamp);
  //     if ( $created >= new DateTime('30 minutes ago') ) { 
  //       if ( Password::verify($password_token, $response[0]->secret) 
  //         && $password == $user_password_repeat) {
  //         $disable_token = $this->_db->update("responses", array('used' => 1), array('reset_key' => $reset_key));

  //         $hash = Password::make($password, PASSWORD_BCRYPT, array("cost" => 10));
  //         $password_change = $this->_db->exec('UPDATE Users SET password = :password WHERE email = :email', 
  //           array(':password' => $hash, ':email' => $email_address));
  //         return true;
  //       }
  //     }
  //   } else {
  //     Session::add('feedback_negative', "INVALID RESET TOKEN");
  //     return false;
  //   }
  // }
}
?>