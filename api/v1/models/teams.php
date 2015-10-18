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

    public function update_team($db, $data, $id)
    {
      $where_inCompetition = array('team_id' => $id);    
      $team = $db->update("Teams", $data, $where_inCompetition, array());
      
      return $team;
    }

    public function create_teamParticipation($db, $data)
    {
      $team = $db->insert("Participates", $data, array());
      return $team;
    }
  }
?>