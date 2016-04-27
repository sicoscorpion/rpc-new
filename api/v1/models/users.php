<?php
/*
 * File:        users.php
 * Author:      Fady Abdelmohsen
 * Date:        Fall 2015
 * Purpose:     This file holds the Users_model class which handles
 *              all database queries relating to users in the system.
 */

// require '.././libs/password.php';

  class Users_model {

  public function __construct(){
    parent::__construct();
  } 

  public function get_users($db){
    $data = $db->query("SELECT * FROM Users, HasRole WHERE Users.user_id = HasRole.user_id");
    return $data;
  }

  // Function made by Martin Main for downloading lists of users -April 2016
  public function get_users_with_teams($db){
    $data = $db->query("SELECT a.user_id, a.email, a.first_name, a.last_name, a.phone, a.civic_number, a.street1, a.street2, a.city, a.province, a.postal_code, a.dob, a.gender, a.medical_info, b.admin, b.qualifier_admin, b.coach, d.team_id, d.name, d.organization, d.approved
                        FROM Users a
                        LEFT JOIN (SELECT Manages.team_id, Manages.user_id 
                                   FROM Manages
                                   GROUP BY Manages.team_id) c ON a.user_id=c.user_id
                        LEFT JOIN Teams d ON d.team_id = c.team_id
                        LEFT JOIN HasRole b ON a.user_id = b.user_id");
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
    $data->api_token = md5(uniqid($data->password, true));

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
      $data->qualifier_admin = false;      
      $data->coach = false;
      $db->update("Admins", array(
        'shirt_size' => $data->shirt_size), 
      array('user_id' => $data->user_id), array());
    } elseif ($role == 'qualifier_admin') {
      $data->admin = false;
      $data->qualifier_admin = true;
      $data->coach = false;
      $db->update("QualifierAdmins", array(
        'shirt_size' => $data->shirt_size), 
      array('user_id' => $data->user_id), array());
    } elseif ($role == 'coach') {
      $data->coach = true;
      $data->qualifier_admin = false;
      $data->admin = false;
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
        'shirt_size' => $data->shirt_size), array());
    } elseif ($role == 'qualifier_admin') {
      $data->qualifier_admin = true;
      $db->insert("QualifierAdmins", array(
        'user_id' => $data->user_id,
        'shirt_size' => $data->shirt_size), array());
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

  public function delete_user($db, $user_id, $role) {

    $user = $db->delete("HasRole", array('user_id' => $user_id));
    if($role != null) {      
      if ($role == 'admin') {
        $db->delete("Admins", array('user_id' => $user_id));
      } if ($role == 'qualifier_admin') {
        $db->delete("QualifierAdmins", array('user_id' => $user_id));
      } elseif ($role == 'coach') {
        $db->delete("Coaches", array('user_id' => $user_id));
      }
    }
    $user = $db->delete("Users", array('user_id' => $user_id));
    
    return $user;
  }

  public function create_hostQualifier($db, $data)
  {
    $host = $db->insert("HostQualifiers", $data, array());
    return $host;
  }

  public function get_hostedQualifiers($db, $user_id) {
    $data = $db->query("SELECT * FROM HostQualifiers, Qualifiers Where HostQualifiers.qual_id = Qualifiers.qual_id AND user_id = :user_id", array(':user_id' => $user_id));
    return $data;
  }

  public function get_hostsForQualifier($db, $qual_id) {
    $data = $db->query("SELECT * FROM HasRole, HostQualifiers Where HostQualifiers.qual_id = :qual_id AND HasRole.user_id = HostQualifiers.user_id", array(':qual_id' => $qual_id));
    return $data;
  }

  public function delete_qualifierHost($db, $qual_id, $user_id) {
    $data = $db->delete("HostQualifiers", 
      array('qual_id' => $qual_id,
        'user_id' => $user_id) );
    return $data;
  }

  public function create_userManage($db, $data)
  {
    $manage = $db->insert("Manages", $data, array());
    return $manage;
  }

  public function get_userManage($db, $user_id) {
    $data = $db->query("SELECT * FROM Manages, Teams Where Manages.team_id = Teams.team_id AND user_id = :user_id", array(':user_id' => $user_id));
    return $data;
  }

  public function get_teamsManage($db, $team_id) {
    $data = $db->query("SELECT * FROM Manages, HasRole Where team_id = :team_id AND Manages.user_id = HasRole.user_id", array(':team_id' => $team_id));
    return $data;
  }

  public function delete_userManage($db, $team_id, $user_id) {
    $data = $db->delete("Manages", 
      array('team_id' => $team_id,
        'user_id' => $user_id) );
    return $data;
  }

  public function get_user_by_email($db, $email) {
    return $db->query("SELECT email FROM "."Users WHERE email = :email", array(':email' => $email));
  }

  public function get_user_by_token($db, $token) {
    return $db->query("SELECT * FROM "."Users WHERE api_token = :token", array(':token' => $token));
  }

  public function forgotPasswordAction($db, $posted) {
    $count = $db->query("SELECT COUNT(*) FROM sent_emails WHERE email_address = 
      :email_address AND timestamp >= :time", array(':email_address' => $posted['hash'], ':time' => $posted['time_formatted']));
    $exists = self::get_user_by_email($db, $posted['email']);

    if (!$exists) {
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

      $result = $db->insert("responses", $toBePosted, array());
      $mail_to      = $posted['email'];  
      $mail_subject = 'Reset password';  
      $mail_body = "Hello, 
        <br><br> 
        you or somebody else requested a password reset for your account at Acadia Robotics. 
        <br><br> 
        To set a new password, please visit this link: 
        <br><br> 
        http://robots-old.acadiau.ca/registration/#/reset_password?reset_key=" . $toBePosted['reset_key'] . "&email=" . $toBePosted['email_address'] . "&password_token=" . $password_token ." 
        <br><br> 
        Do not share this link with anyone, it expires in 30 minutes.  
        <br><br> 
        If the request was not from you (or not intended for you), simply ignore this email. Your password will not be changed. 
        <br><br> 
        Do you have further questions? Please contact us at robots@acadiau.ca. 
        <br><br> 
        Best regards, 
        <br><br> 
        robots.acadiau.ca";
      $mail = new Mail;
      $mail_sent = $mail->sendMail($mail_to, "www-data@localhost", "ACCOUNT ", $mail_subject, $mail_body);

      if ($mail_sent == 1) {
        $new_stmt = $db->exec('INSERT INTO sent_emails (email_address, timestamp) VALUES (:email_address, NOW())', array(':email_address' => $posted['hash']) );
        return "Mail Sent!";
      } else {
        return "Mail not sent" . $mail->getError();
      }
    }
  }

  function resetPasswordAction($db, $reset_key, $email_address, 
    $password_token, $password, $user_password_repeat) {
    
    $response = $db->query('SELECT secret, request_timestamp FROM responses 
      WHERE reset_key = :reset_key AND email_address = :email_address 
      AND NOT used AND active', array(':reset_key' => $reset_key, ':email_address' => $email_address));
    
    $validatedPassword = self::validateUserPassword($password, $user_password_repeat);
    if (!$validatedPassword) {
      return "INVALID PASSWORD";
    }
    
    if($response){              
      $created = DateTime::createFromFormat('Y-m-d G:i:s', $response[0]->request_timestamp);
      if ( $created >= new DateTime('30 minutes ago') ) { 
        if ( Password::verify($password_token, $response[0]->secret) 
          && $password == $user_password_repeat) {
          $disable_token = $db->update("responses", array('used' => 1), array('reset_key' => $reset_key), array());

          $hash = Password::make($password, PASSWORD_BCRYPT, array("cost" => 10));
          $password_change = $db->exec('UPDATE Users SET password = :password WHERE email = :email', 
            array(':password' => $hash, ':email' => $email_address));
          return "Password Successfully Changed";
        }
      }
    } else {
      return "INVALID RESET TOKEN";
    }
  }

  function validateUserPassword($user_password_new, $user_password_repeat)
  {
      if (empty($user_password_new) OR empty($user_password_repeat)) {
          return false;
      }

      if ($user_password_new !== $user_password_repeat) {
          return false;
      }

      if (strlen($user_password_new) < 6) {
          return false;
      }

      return true;
  }
}
?>