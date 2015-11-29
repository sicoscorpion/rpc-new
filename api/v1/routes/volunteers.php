<?php
// Volunteers
$app->post('/volunteer',  function() use ($app){ 
  global $db;
  $data = json_decode($app->request->getBody());
  $rows = Volunteers_model::create_volunteer($db, $data);
  echoResponse(200, $rows);
});

$app->get('/volunteers/:season_year', function($season_year) use ($app){ 
  global $db;
  $data = json_decode($app->request->getBody());
  $rows = Volunteers_model::get_volunteers($db, $season_year);
  echoResponse(200, $rows);
});

$app->put('/volunteer/:id', function($id) use ($app){ 
  global $db;
  $data = json_decode($app->request->getBody());

  $rows = Volunteers_model::update_volunteer($db, $data, $id);
  if($rows["status"]=="success")
      $rows["message"] = "Member information updated successfully.";
  echoResponse(200, $rows);
});

$app->post('/helps',  function() use ($app){ 
  global $db;
  $data = json_decode($app->request->getBody());
  $rows = Volunteers_model::add_helps($db, $data);
  echoResponse(200, $rows);
});
$app->get('/helps/:volunteer_id', function($volunteer_id) use ($app){ 
  global $db;
  $data = json_decode($app->request->getBody());
  $rows = Volunteers_model::get_helps($db, $volunteer_id);
  echoResponse(200, $rows);
});

$app->delete('/helps/:qual_id/:volunteer_id', function($qual_id, $volunteer_id) use ($app){
  global $db;
  $rows = Volunteers_model::delete_helps($db, $qual_id, $volunteer_id);
  echoResponse(200, $rows);
});

$app->get('/valid_volunteer_positions', function() use ($app){ 
  global $db;
  $data = json_decode($app->request->getBody());
  $rows = Volunteers_model::get_volunteer_positions($db);
  echoResponse(200, $rows);
});
$app->get('/volunteer_positions/:volunteer_id', function($volunteer_id) use ($app){ 
  global $db;
  $data = json_decode($app->request->getBody());
  $rows = Volunteers_model::get_has_position($db, $volunteer_id);
  echoResponse(200, $rows);
});

$app->post('/volunteer_position',  function() use ($app){ 
  global $db;

  $data = json_decode($app->request->getBody());
  // echo $data;
  $rows = Volunteers_model::add_has_position($db, $data);
  echoResponse(200, $rows);
});

$app->delete('/volunteer_position/:position_id/:volunteer_id', function($position_id, $volunteer_id) use ($app){
  global $db;
  $rows = Volunteers_model::delete_has_position($db, $position_id, $volunteer_id);
  echoResponse(200, $rows);
});
$app->delete('/volunteer/:id', function($volunteer_id) use ($app){
  global $db;
  $rows = Volunteers_model::delete_volunteer($db, $volunteer_id);
  echoResponse(200, $rows);
});
?>