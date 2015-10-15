<?php
  class Seasons_model {

    public function __construct(){
      parent::__construct();
    } 

    public function get_seasons($db){
      $data = $db->query("SELECT * FROM "."Seasons");
      return $data;
    }

    public function get_seasons_for_host($db, $host){
      $data = $db->query("SELECT * FROM "."Seasons, Hosts WHERE 
        user_id = :host AND year = season_year", array(':host' => $host));
      return $data;
    }

    public function create_season($db, $data) {
      $added_season = $db->insert("Seasons", $data, array());
      return  $added_season;
    }

    public function add_season_host($db, $data, $host) {

      $added_host = $db->insert("Hosts", array(
        'user_id' => $host,
        'season_year' => $data->year), array());
      return  $added_host;
    }


    public function update_season($db, $data, $year) {

      $where_inSeason = array('year' => $year);    
      $season_data = $db->update("Seasons", $data, $where_inSeason, array());

      return $season_data;
    }
    public function delete_season_host($db, $season_year, $host) {

      $hosts = $db->delete("Hosts", 
        array(
          "season_year" => $season_year,
          "user_id" => $host
        ));
      
      return  $hosts;
    }

    

    public function delete_season($db, $season_year) {

      $season = $db->delete("Seasons", 
        array("year" => $season_year));
      $hosts = $db->delete("Hosts", 
        array("year" => $season_year));
      return array("sesason" => $season, "hosts" => $hosts);
    }
  }
?>