<?php
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