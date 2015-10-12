<?php
require '.././libs/Slim/Slim.php';
require '.././libs/password.php';

require 'models/users.php';
require 'models/seasons.php';

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

  if(Password::verify($data->password, $user["password"]) == true) {
    echoResponse(200, $user);
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
  
  $rows = Users_model::register_new_user($db, $data->first_name, 
    $data->last_name, $data->email, $data->password, $data->position, $data->role);

  if($rows) {
    echoResponse(200, "Added");
  } else {
    echoResponse(403, "Error adding data - Entry may already exist");
  }
});


// Seasons
$app->get('/seasons', function() use ($app){ 
  global $db;
  $data = json_decode($app->request->getBody());
  $rows = Seasons_model::get_seasons($db);
  echoResponse(200, $rows);
});

$app->post('/seasons', function() use ($app){ 
  global $db;
  $data = json_decode($app->request->getBody());
  $rows = Seasons_model::create_season($db, $data->year, $data->info, $data->email);
    if($rows) {
    echoResponse(200, "Added Season");
  } else {
    echoResponse(403, "Error adding data - Entry may already exist");
  }
});

$app->put('/seasons', function() use ($app){ 
  global $db;
  $data = json_decode($app->request->getBody());
  $rows = Seasons_model::update_season($db, $data->year, $data->info);
    if($rows) {
    echoResponse(200, "Updated Season");
  } else {
    echoResponse(403, "Error adding data - Entry may already exist");
  }
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