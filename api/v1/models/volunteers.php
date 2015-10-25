<?php
  class Volunteers_model {

    public function __construct(){
      parent::__construct();
    }

    public function create_volunteer($db, $data)
    {
      $volunteer = $db->insert("Volunteers", $data, array());
      return $volunteer;
    }

    public function get_volunteers($db) {
      $data = $db->query("SELECT * FROM Volunteers");
      return $data;
    }

    public function update_team($db, $data, $id)
    {
      $where_inTeams = array('team_id' => $id);    
      $team = $db->update("Teams", $data, $where_inTeams, array());
      
      return $team;
    }

  }
?>