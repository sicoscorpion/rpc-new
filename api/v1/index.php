<?php
require '.././libs/Slim/Slim.php';
require '.././libs/password.php';

require 'models/users.php';
require 'models/seasons.php';
require 'models/competitions.php';

require_once 'dbHelper.php';

\Slim\Slim::registerAutoloader();
$app = new \Slim\Slim();
$app = \Slim\Slim::getInstance();
$db = new dbHelper();

/**
* Database Helper Function templates
*/
/*
select(table name, where clause as associative array)
insert(table name, data as associative array, mandatory column names as array)
update(table name, column names as associative array, where clause as associative array, required columns as array)
delete(table name, where clause as array)
*/

// Users
$app->post('/login', function() use ($app){ 
  global $db;
  $data = json_decode($app->request->getBody());
  $user = Users_model::get_hash($db, $data->email);
  $hash = Password::make($data->password, PASSWORD_BCRYPT, array("cost" => 10));


  if(Password::verify($data->password, $user[0]->password) == true) {
    echoResponse(200, $user[0]);
  } else {
    echoResponse(403, "Not a valid password");
  }
});

$app->get('/users', function() use ($app) { 
  global $db;
  $rows = Users_model::get_users($db);
  echoResponse(200, $rows);
});

$app->post('/users', function() use ($app){ 
  global $db;
  $data = json_decode($app->request->getBody());
  
  $rows = Users_model::add_user($db, $data);

  echoResponse(200, $rows);
});

$app->post('/users/:role', function($role) use ($app){ 
  global $db;
  $data = json_decode($app->request->getBody());
  
  $rows = Users_model::add_hasRole($db, $data, $role);

  echoResponse(200, $rows);
});

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

// Competitions
$app->post('/competitions', function() use ($app){ 
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

$app->put('/competitions/:id', function($id) use ($app){ 
  global $db;
  $data = json_decode($app->request->getBody());

  $rows = Competitions_model::update_competition($db, $data, $id);
  if($rows["status"]=="success")
      $rows["message"] = "Competition information updated successfully.";
  echoResponse(200, $rows);
});

$app->delete('/competitions/:id', function($id) use ($app){
  global $db;
  $rows = Competitions_model::delete_competition($db, $id);
  echoResponse(200, $rows);
});

// Products
$app->get('/products', function() { 
  global $db;
  $rows = $db->select("products","id,sku,name,description,price,mrp,stock,image,packing,status",array());
  echoResponse(200, $rows);
});

$app->post('/products', function() use ($app) { 
  $data = json_decode($app->request->getBody());
  $mandatory = array('name');
  global $db;
  $rows = $db->insert("products", $data, $mandatory);
  if($rows["status"]=="success")
      $rows["message"] = "Product added successfully.";
  echoResponse(200, $rows);
});

$app->put('/products/:id', function($id) use ($app) { 
  $data = json_decode($app->request->getBody());
  $condition = array('id'=>$id);
  $mandatory = array();
  global $db;
  $rows = $db->update("products", $data, $condition, $mandatory);
  if($rows["status"]=="success")
      $rows["message"] = "Product information updated successfully.";
  echoResponse(200, $rows);
});

$app->delete('/products/:id', function($id) { 
  global $db;
  $rows = $db->delete("products", array('id'=>$id));
  if($rows["status"]=="success")
      $rows["message"] = "Product removed successfully.";
  echoResponse(200, $rows);
});

function echoResponse($status_code, $response) {
  global $app;
  $app->status($status_code);
  $app->contentType('application/json');
  echo json_encode($response,JSON_NUMERIC_CHECK);
}

$app->run();
?>