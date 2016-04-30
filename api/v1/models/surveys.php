<?php
  class Surveys_model {

    public function __construct(){
      parent::__construct();
    }

    public function create_audience_survey($db, $data)
    {
      $survey = $db->insert("AudienceSurveys", $data, array());
      return $survey;
    }

    public function create_coach_survey($db, $data)
    {
      $survey = $db->insert("CoachSurveys", $data, array());
      return $survey;
    }

    public function create_volunteer_survey($db, $data)
    {
      $survey = $db->insert("VolunteerSurveys", $data, array());
      return $survey;
    }

    public function create_student_survey($db, $data)
    {
      $survey = $db->insert("StudentSurveys", $data, array());
      return $survey;
    }


    public function get_surveys_count($db, $type, $year) {
      $query_string = 'SELECT COUNT(*) FROM ' . $type . ' WHERE year = :year';
      $data = $db->query($query_string, array(':year' => $year));
      return $data;
    }
  }
?>