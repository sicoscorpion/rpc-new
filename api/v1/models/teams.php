<?php
  class Teams_model {

    public function __construct(){
      parent::__construct();
    }

    public function create_team($db, $data)
    {
      $team = $db->insert("Teams", $data, array());
      return $team;
    }

    public function get_teams($db) {
      $data = $db->query("SELECT * FROM "."Teams");
      return $data;
    }

    public function get_qualifiers_for_competition($db, $competition_id) {
      $data = $db->query("SELECT * FROM "."Qualifiers WHERE competition_id = :competition_id", array(':competition_id' => $competition_id));
      
      return $data;
    }

    public function update_team($db, $data, $id)
    {
      $where_inCompetition = array('team_id' => $id);    
      $team = $db->update("Teams", $data, $where_inCompetition, array());
      
      return $team;
    }

    public function delete_qualifier($db, $id) {
      $qualifier = $db->delete("Qualifiers", 
        array('qual_id' => $id));
      
      return  $qualifier;
    }
  }
?>