<?php
/*
 * File:        teams.php
 * Author:      Fady Abdelmohsen
 * Date:        Fall 2015
 * Purpose:     This file holds the Teams_model class which handles
 *              all database queries relating to the different teams at the 
 *              robot programming competition.
 */

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

    // Function created by MM April 2016
    public function get_teams_with_coaches($db) {
      $data = $db->query("SELECT b.team_id, b.name, b.organization, b.approved, c.user_id, c.first_name, c.last_name, d.qual_id, d.name as qual_name FROM Teams b 
                          LEFT JOIN Manages a ON a.team_id=b.team_id
                          LEFT JOIN Users c ON c.user_id=a.user_id
                          LEFT JOIN Participates p ON b.team_id=p.team_id
                          LEFT JOIN Qualifiers d ON p.qual_id=d.qual_id AND p.competition_id=d.competition_id AND p.season_year=d.season_year");
      return $data;
    }

    // Function created by MM April 2016
    public function get_teams_from_season($db, $year) {
      $data = $db->query("SELECT a.team_id, a.name, a.organization, a.approved, d.qual_id, d.name as qual_name FROM Teams a
                          LEFT JOIN Participates p ON a.team_id=p.team_id
                          LEFT JOIN Qualifiers d ON p.qual_id=d.qual_id AND p.competition_id=d.competition_id AND p.season_year=d.season_year
                          WHERE d.season_year = :year", array(':year' => $year));
      return $data;
    }

     // Function created by MM April 2016
    public function get_teams_from_qual_admin($db, $user_id) {
      $data = $db->query("SELECT a.*, c.qual_id, c.name as qual_name FROM Teams a
                          LEFT JOIN Participates b ON a.team_id=b.team_id
                          LEFT JOIN Qualifiers c ON b.qual_id=c.qual_id AND b.competition_id=c.competition_id AND b.season_year=c.season_year
                          LEFT JOIN HostQualifiers d ON b.qual_id=d.qual_id AND b.competition_id=d.competition_id AND b.season_year=d.season_year
                          WHERE d.user_id = :user_id 
                          GROUP BY a.name", array(':user_id' => $user_id));
      return $data;
    }

    // Function created by MM April 2016
    public function get_teams_from_qual_admin_w_coaches($db, $user_id) {
      $data = $db->query("SELECT a.*, c.qual_id, c.name as qual_name, f.user_id, f.first_name, f.last_name FROM Teams a
                          LEFT JOIN Manages e ON a.team_id=e.team_id
                          LEFT JOIN Users f ON e.user_id=f.user_id
                          LEFT JOIN Participates b ON a.team_id=b.team_id
                          LEFT JOIN Qualifiers c ON b.qual_id=c.qual_id AND b.competition_id=c.competition_id AND b.season_year=c.season_year
                          LEFT JOIN HostQualifiers d ON b.qual_id=d.qual_id AND b.competition_id=d.competition_id AND b.season_year=d.season_year
                          WHERE d.user_id = :user_id", array(':user_id' => $user_id));
      return $data;
    }

    // Function created by MM April 2016
    public function get_teams_with_coaches_w_season($db, $year) {
      $data = $db->query("SELECT b.team_id, b.name, b.organization, b.approved, c.user_id, c.first_name, c.last_name, d.qual_id, d.name as qual_name FROM Teams b 
                          LEFT JOIN Manages a ON a.team_id=b.team_id
                          LEFT JOIN Users c ON c.user_id=a.user_id
                          LEFT JOIN Participates p ON b.team_id=p.team_id
                          LEFT JOIN Qualifiers d ON p.qual_id=d.qual_id AND p.competition_id=d.competition_id AND p.season_year=d.season_year
                          WHERE d.season_year = :year", array(':year' => $year));
      return $data;
    }
    
    public function get_qualifierTeams($db, $qual_id) {
      $data = $db->query("SELECT * FROM Teams, Participates WHERE Teams.team_id = Participates.team_id AND Participates.qual_id = :qual_id", array(':qual_id' => $qual_id));
      return $data;
    }

    // Function made by Martin Main April 2016
    public function get_qualifierTeams_with_coaches($db, $qual_id) {
      $data = $db->query("SELECT a.*, b.*, d.user_id, d.first_name, d.last_name, e.name as qual_name FROM Teams a
                          LEFT JOIN Participates b ON a.team_id = b.team_id
                          LEFT JOIN Qualifiers e ON b.qual_id=e.qual_id
                          LEFT JOIN Manages c ON a.team_id=c.team_id
                          LEFT JOIN Users d ON c.user_id=d.user_id
                          WHERE b.qual_id = :qual_id", array(':qual_id' => $qual_id));
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
      $data = $db->query("SELECT *, Qualifiers.capacity AS qualifier_capacity FROM Participates, Qualifiers Where team_id = :team_id AND Qualifiers.qual_id = Participates.qual_id", array(':team_id' => $team_id));
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