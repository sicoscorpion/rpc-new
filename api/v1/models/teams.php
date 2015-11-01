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

    public function get_qualifierTeams($db, $qual_id) {
      $data = $db->query("SELECT * FROM Teams, Participates WHERE Teams.team_id = Participates.team_id AND Participates.qual_id = :qual_id", array(':qual_id' => $qual_id));
      return $data;
    }

    public function update_team($db, $data, $id)
    {
      $where_inTeams = array('team_id' => $id);    
      $team = $db->update("Teams", $data, $where_inTeams, array());
      
      return $team;
    }

    public function create_teamParticipation($db, $data)
    {
      $team = $db->insert("Participates", $data, array());
      return $team;
    }

    public function get_teamParticipation($db, $team_id) {
      $data = $db->query("SELECT * FROM Participates Where team_id = :team_id", array(':team_id' => $team_id));
      return $data;
    }

    public function delete_teamParticipation($db, $team_id, $qual_id, $comp_id, $season_year) {
      $data = $db->delete("Participates", 
        array('qual_id' => $qual_id,  
          'competition_id' => $comp_id,
          'team_id' => $team_id,
          'season_year' => $season_year) );
      return $data;
    }

    public function delete_team($db, $team_id) {
      $data = $db->delete("Teams", 
        array('team_id' => $team_id) );
      return $data;
    }
  }
?>