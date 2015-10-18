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


?>