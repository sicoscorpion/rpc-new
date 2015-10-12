<?php
  class Seasons_model {

    public function __construct(){
      parent::__construct();
    } 

    public function get_seasons($db){
      $data = $db->query("SELECT * FROM "."Seasons");
      return $data;
    }

    public function get_seasons_for_admin($db, $email){
      $data = $db->query("SELECT * FROM "."Seasons, Hosts WHERE 
        user_email = :email AND year = season_year", array(':email' => $email));
      return $data;
    }

    public function create_season($db, $year, $info, $user_email)
    {
      $db->insert("Seasons", array(
        'year' => $year,
        'info' => $info), array());

      $db->insert("Hosts", array(
        'user_email' => $user_email,
        'season_year' => $year), array());

      return true;
    }

    public function update_season($db, $year, $info)
    {

      $postArray = array(
        'year' => $year,
        'info' => $info
        );
      $where_inSeason = array('year' => $year);    
      $season_data = $db->update("Seasons", $postArray, $where_inSeason);
      
      return true;
    }
  }
?>