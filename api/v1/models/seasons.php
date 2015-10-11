<?php
  class Seasons_model {

    public function __construct(){
      parent::__construct();
    } 

    public function get_seasons($db, $email){
      $data = $db->query("SELECT * FROM "."Seasons, Hosts WHERE 
        user_email = :email AND year = season_year", array(':email' => $email));
      return $data;
    }
  }
?>