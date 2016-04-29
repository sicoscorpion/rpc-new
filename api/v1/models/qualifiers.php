<?php
/*
 * File:        qualifiers.php
 * Author:      Fady Abdelmohsen
 * Date:        Fall 2015
 * Purpose:     This file holds the Qualifiers_model class which handles
 *              all database queries relating to the qualifiers in the 
 *              competition.
 */

  class Qualifiers_model {

    public function __construct(){
      parent::__construct();
    }

    public function create_qualifier($db, $data)
    {
      $qualifiers = $db->insert("Qualifiers", $data, array());
      return $qualifiers;
    }

    public function get_qualifiers($db) {
      $data = $db->query("SELECT * FROM "."Qualifiers");
      return $data;
    }

    public function get_qualifiers_for_competition($db, $competition_id) {
      $data = $db->query("SELECT * FROM "."Qualifiers WHERE competition_id = :competition_id", array(':competition_id' => $competition_id));
      return $data;
    }

    public function get_qualifiers_for_season($db, $year) {
      $data = $db->query("SELECT * FROM Qualifiers WHERE season_year = :year", array(':year' => $year));
      return $data;
    }

    public function get_open_qualifiers($db)
    {
      $data = $db->query("SELECT *FROM Qualifiers WHERE  Qualifiers.status=\"open\"");

      return $data;
    }

    public function update_qualifier($db, $data, $id)
    {
      $where_inCompetition = array('qual_id' => $id);    
      $qualifier = $db->update("Qualifiers", $data, $where_inCompetition, array());
      
      return $qualifier;
    }

    public function delete_qualifier($db, $id) {
      $qualifier = $db->delete("Qualifiers", 
        array('qual_id' => $id));
      
      return  $qualifier;
    }
  }
?>