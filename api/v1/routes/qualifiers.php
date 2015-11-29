<?php
  // Qualifiers
$app->post('/qualifiers', 'authenticateToken', function() use ($app){ 
  global $db;
  $data = json_decode($app->request->getBody());
  $rows = Qualifiers_model::create_qualifier($db, $data);
  echoResponse(200, $rows);
});

$app->get('/qualifiers', function() use ($app){ 
  global $db;
  $data = json_decode($app->request->getBody());
  $rows = Qualifiers_model::get_qualifiers($db);
  echoResponse(200, $rows);
});

$app->get('/qualifiers/competition/:comp_id', function($comp_id) use ($app){ 
  global $db;
  $data = json_decode($app->request->getBody());
  $rows = Qualifiers_model::get_qualifiers_for_competition($db, $comp_id);
  echoResponse(200, $rows);
});

$app->get('/qualifiers/open', function() use ($app){ 
  global $db;
  $data = json_decode($app->request->getBody());
  $rows = Qualifiers_model::get_open_qualifiers($db);
  echoResponse(200, $rows);
});

$app->put('/qualifiers/:id', 'authenticateToken', function($id) use ($app){ 
  global $db;
  $data = json_decode($app->request->getBody());

  $rows = Qualifiers_model::update_qualifier($db, $data, $id);
  if($rows["status"]=="success")
      $rows["message"] = "Qualifier information updated successfully.";
  echoResponse(200, $rows);
});

$app->delete('/qualifiers/:id', 'authenticateToken', function($id) use ($app){
  global $db;
  $rows = Qualifiers_model::delete_qualifier($db, $id);
  echoResponse(200, $rows);
});

?>
