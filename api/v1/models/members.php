<?php
/*
 * File:        members.php
 * Author:      Fady Abdelmohsen
 * Date:        Fall 2015
 * Purpose:     This file holds the Members_model class which handles
 *              all database queries relating to the team members 
 *              (participants) in the robot programming competition.
 */

  class Members_model {

    public function __construct(){
      parent::__construct();
    }

    public function create_member($db, $data)
    {
      $member = $db->insert("Members", $data, array());
      return $member;
    }

    public function get_members($db, $team_id) {
      $data = $db->query("SELECT * FROM Members Where team_id = :team_id", array(':team_id' => $team_id));
      return $data;
    }

    // Function made by Martin Main for purpose of downloading members list -April 2016
    public function get_all_members($db) {
      $data = $db->query("SELECT * FROM Members LEFT JOIN Teams ON Members.team_id=Teams.team_id ORDER BY Members.team_id");
      return $data;
    }

    public function update_member($db, $data, $id)
    {
      $where_inMembers = array('member_id' => $id);    
      $member = $db->update("Members", $data, $where_inMembers, array());
      
      return $member;
    }

    public function delete_member($db, $member_id) {
      $data = $db->delete("Members", 
        array('member_id' => $member_id) );
      return $data;
    }
  }
?>