<?php
  // Seasons
$app->get('/seasons', function() use ($app){ 
  global $db;
  $data = json_decode($app->request->getBody());
  $rows = Seasons_model::get_seasons($db);
  echoResponse(200, $rows);
});
$app->get('/seasons/host/:host', function($host) use ($app){ 
  global $db;
  $data = json_decode($app->request->getBody());
  $rows = Seasons_model::get_seasons_for_host($db, $host);
  echoResponse(200, $rows);
});
$app->get('/seasons/hosts/:year', function($year) use ($app){ 
  global $db;
  $data = json_decode($app->request->getBody());
  $rows = Seasons_model::get_hosts_for_season($db, $year);
  echoResponse(200, $rows);
});


$app->post('/seasons', function() use ($app){ 
  global $db;
  $data = json_decode($app->request->getBody());
  $rows = Seasons_model::create_season($db, $data);
  echoResponse(200, $rows);
});


$app->post('/seasons/host/:host', function($host) use ($app){ 
  global $db;
  $data = json_decode($app->request->getBody());
  $rows = Seasons_model::add_season_host($db, $data, $host);
  echoResponse(200, $rows);
});

$app->put('/seasons/:year', function($year) use ($app){ 
  global $db;
  $data = json_decode($app->request->getBody());
  $rows = Seasons_model::update_season($db, $data, $year);
  if($rows["status"]=="success")
      $rows["message"] = "Season information updated successfully.";
  echoResponse(200, $rows);
});

$app->delete('/seasons/host/:season_year/:host', function($season_year, $host) use ($app){
  global $db;
  $rows = Seasons_model::delete_season_host($db, $season_year, $host);
  echoResponse(200, $rows);
});

$app->delete('/seasons/:season_year', function($season_year) use ($app){
  global $db;
  $rows = Seasons_model::delete_season($db, $season_year);
  echoResponse(200, $rows);
});

?>