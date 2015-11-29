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

    public function get_volunteers($db, $season_year) {
      $data = $db->query("SELECT * FROM Volunteers WHERE season_year = :season_year", 
        array('season_year' => $season_year));
      return $data;
    }

    public function update_volunteer($db, $data, $id)
    {
      $where_inVolunteers = array('volunteer_id' => $id);    
      $volunteer = $db->update("Volunteers", $data, $where_inVolunteers, array());
      
      return $volunteer;
    }
    public function add_helps($db, $data)
    {
      $volunteer = $db->insert("Helps", $data, array());
      return $volunteer;
    }
    public function get_helps($db, $volunteer_id)
    {
      $data = $db->query("SELECT * FROM Helps, Qualifiers WHERE Qualifiers.qual_id = Helps.qual_id AND volunteer_id = :volunteer_id", 
        array('volunteer_id' => $volunteer_id));
      return $data;
    }

    public function delete_helps($db, $qual_id, $volunteer_id) {
      $data = $db->delete("Helps", 
        array('qual_id' => $qual_id,
          'volunteer_id' => $volunteer_id) );
      return $data;
    }

    public function get_volunteer_positions($db)
    {
      $data = $db->query("SELECT * FROM VolunteerPositions WHERE status = :status", array("status" => "open"));
      return $data;
    }
    public function add_has_position($db, $data)
    {
      $hasPosition = $db->insert("HasPosition", $data, array());
      // $capacity = $db->query("SELECT capacity FROM VolunteerPositions WHERE position_id = :position_id",
      //   array('position_id' => $data->position_id));
      // $current = $db->query("SELECT COUNT(*) FROM HasPosition WHERE position_id = :position_id",
      //   array('position_id' => $data->position_id));
      // echo $capacity["data"];
      // echo $current->count;

      return $hasPosition;
    }
    public function get_has_position($db, $volunteer_id)
    {
      $data = $db->query("SELECT * FROM HasPosition, VolunteerPositions WHERE HasPosition.position_id = VolunteerPositions.position_id AND HasPosition.volunteer_id = :volunteer_id", 
        array('volunteer_id' => $volunteer_id));
      return $data;
    }
    public function delete_has_position($db, $position_id, $volunteer_id) {
      $data = $db->delete("HasPosition", 
        array('position_id' => $position_id,
          'volunteer_id' => $volunteer_id) );
      return $data;
    }
    public function delete_volunteer($db, $id) {
      $volunteer = $db->delete("Volunteers", 
        array('volunteer_id' => $id));
      
      return  $volunteer;
    }
  }
?>