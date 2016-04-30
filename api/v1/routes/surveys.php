<?php
  // Surveys
$app->post('/audience_survey', 'authenticateToken', function() use ($app){
  global $db;
  $data = json_decode($app->request->getBody());
  $rows = Surveys_model::create_audience_survey($db, $data);
  echoResponse(200, $rows);
});

$app->post('/coach_survey', 'authenticateToken', function() use ($app){
  global $db;
  $data = json_decode($app->request->getBody());
  $rows = Surveys_model::create_coach_survey($db, $data);
  echoResponse(200, $rows);
});

$app->post('/volunteer_survey', 'authenticateToken', function() use ($app){
  global $db;
  $data = json_decode($app->request->getBody());
  $rows = Surveys_model::create_volunteer_survey($db, $data);
  echoResponse(200, $rows);
});

$app->post('/student_survey', 'authenticateToken', function() use ($app){
  global $db;
  $data = json_decode($app->request->getBody());
  $rows = Surveys_model::create_student_survey($db, $data);
  echoResponse(200, $rows);
});


$app->get('/surveys_count/:type', function($type) use ($app){
  global $db;
  $data = json_decode($app->request->getBody());
  $rows = Surveys_model::get_surveys_count($db, $type, 2016);
  echoResponse(200, $rows);
});

?>