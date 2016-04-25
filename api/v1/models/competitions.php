<?php
/*
 * File:        competitions.php
 * Author:      Fady Abdelmohsen
 * Date:        Fall 2015
 * Purpose:     This file holds the Competitions_model class which handles
 *              all database queries relating to the yearly robotics 
 *              competitions.
 */

  class Competitions_model {

    public function __construct(){
      parent::__construct();
    }

    public function create_competition($db, $data)
    {
      $competition = $db->insert("Competitions", $data, array());
      return $competition;
    }

    public function get_competitions($db) {
      $data = $db->query("SELECT * FROM "."Competitions");
      return $data;
    }

    public function get_competitions_for_season($db, $year) {
      $data = $db->query("SELECT * FROM "."Competitions WHERE season_year = :year", array(':year' => $year));
      
      return $data;
    }

    public function update_competition($db, $data, $id)
    {
      $where_inCompetition = array('competition_id' => $id);    
      $competition = $db->update("Competitions", $data, $where_inCompetition, array());
      
      return $competition;
    }

    public function delete_competition($db, $id) {
      $competition = $db->delete("Competitions", 
        array('competition_id' => $id));
      
      return  $competition;
    }
  }
?>