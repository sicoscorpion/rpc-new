<?php
// Teams
$app->post('/teams', function() use ($app){ 
  global $db;
  $data = json_decode($app->request->getBody());
  $rows = Teams_model::create_team($db, $data);
  echoResponse(200, $rows);
});

$app->get('/teams', function() use ($app){ 
  global $db;
  $data = json_decode($app->request->getBody());
  $rows = Teams_model::get_teams($db);
  echoResponse(200, $rows);
});

$app->put('/teams/:id', function($id) use ($app){ 
  global $db;
  $data = json_decode($app->request->getBody());

  $rows = Teams_model::update_team($db, $data, $id);
  if($rows["status"]=="success")
      $rows["message"] = "Team information updated successfully.";
  echoResponse(200, $rows);
});

$app->post('/teams/participate', function() use ($app){ 
  global $db;
  $data = json_decode($app->request->getBody());
  $rows = Teams_model::create_teamParticipation($db, $data);
  echoResponse(200, $rows);
});

$app->get('/teams/participate/:team_id', function($team_id) use ($app){ 
  global $db;
  $data = json_decode($app->request->getBody());
  $rows = Teams_model::get_teamParticipation($db, $team_id);
  echoResponse(200, $rows);
});

$app->delete('/teams/:team_id', 
  function($team_id) use ($app){
  global $db;
  $rows = Teams_model::delete_team($db, $team_id);
  echoResponse(200, $rows);
});

$app->delete('/teams/participate/:team_id/:qual_id/:comp_id/:season_year', 
  function($team_id, $qual_id, $comp_id, $season_year) use ($app){
  global $db;
  $rows = Teams_model::delete_teamParticipation($db, $team_id, $qual_id, $comp_id, $season_year);
  echoResponse(200, $rows);
});

?>