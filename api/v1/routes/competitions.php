<?php
  // Competitions
$app->post('/competitions', 'authenticateToken', function() use ($app){ 
  global $db;
  $data = json_decode($app->request->getBody());
  $rows = Competitions_model::create_competition($db, $data);
  echoResponse(200, $rows);
});

$app->get('/competitions', function() use ($app){ 
  global $db;
  $data = json_decode($app->request->getBody());
  $rows = Competitions_model::get_competitions($db);
  echoResponse(200, $rows);
});

$app->get('/competitions/season/:year', function($year) use ($app){ 
  global $db;
  $data = json_decode($app->request->getBody());
  $rows = Competitions_model::get_competitions_for_season($db, $year);
  echoResponse(200, $rows);
});

$app->put('/competitions/:id', 'authenticateToken', function($id) use ($app){ 
  global $db;
  $data = json_decode($app->request->getBody());

  $rows = Competitions_model::update_competition($db, $data, $id);
  if($rows["status"]=="success")
      $rows["message"] = "Competition information updated successfully.";
  echoResponse(200, $rows);
});

$app->delete('/competitions/:id', 'authenticateToken', function($id) use ($app){
  global $db;
  $rows = Competitions_model::delete_competition($db, $id);
  echoResponse(200, $rows);
});


?>