<?php


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

// 'authenticateToken',

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
  // echo $data;
  $rows = Users_model::add_hasRole($db, $data, $role);

  echoResponse(200, $rows);
});

$app->put('/users/:id', function($id) use ($app){ 
  global $db;
  $data = json_decode($app->request->getBody());

  $rows = Users_model::update_user($db, $data, $id);
  if($rows["status"]=="success")
      $rows["message"] = "User information updated successfully.";
  echoResponse(200, $rows);
});

$app->put('/users/:role/:id', function($role, $id) use ($app){ 
  global $db;
  $data = json_decode($app->request->getBody());
  $data->user_id = $id;
  $rows = Users_model::update_userRole($db, $data, $role);
  if($rows["status"]=="success")
      $rows["message"] = "User information updated successfully.";
  echoResponse(200, $rows);
});

$app->delete('/users/:role/:id', function($role, $id) use ($app){ 
  global $db;
  $rows = Users_model::delete_user($db, $id, $role);
  if($rows["status"]=="success")
      $rows["message"] = "User information updated successfully.";
  echoResponse(200, $rows);
});

$app->post('/host', function() use ($app){ 
  global $db;
  $data = json_decode($app->request->getBody());
  $rows = Users_model::create_hostQualifier($db, $data);
  echoResponse(200, $rows);
});

$app->get('/host/qualifiers/:user_id', function($user_id) use ($app){ 
  global $db;
  $data = json_decode($app->request->getBody());
  $rows = Users_model::get_hostedQualifiers($db, $user_id);
  echoResponse(200, $rows);
});

$app->get('/host/admins/:qual_id', function($qual_id) use ($app){ 
  global $db;
  $data = json_decode($app->request->getBody());
  $rows = Users_model::get_hostsForQualifier($db, $qual_id);
  echoResponse(200, $rows);
});

$app->delete('/host/:qual_id/:user_id', 
  function($qual_id, $user_id) use ($app){
  global $db;
  $rows = Users_model::delete_qualifierHost($db, $qual_id, $user_id);
  echoResponse(200, $rows);
});

$app->post('/manage', function() use ($app){ 
  global $db;
  $data = json_decode($app->request->getBody());
  $rows = Users_model::create_userManage($db, $data);
  echoResponse(200, $rows);
});

$app->get('/manage/teams/:user_id', function($user_id) use ($app){ 
  global $db;
  $data = json_decode($app->request->getBody());
  $rows = Users_model::get_userManage($db, $user_id);
  echoResponse(200, $rows);
});

$app->get('/manage/users/:team_id', function($team_id) use ($app){ 
  global $db;
  $data = json_decode($app->request->getBody());
  $rows = Users_model::get_teamsManage($db, $team_id);
  echoResponse(200, $rows);
});

$app->delete('/manage/:team_id/:user_id', 
  function($team_id, $user_id) use ($app){
  global $db;
  $rows = Users_model::delete_userManage($db, $team_id, $user_id);
  echoResponse(200, $rows);
});



$app->post('/forgot_password', function() use ($app){ 
  global $db;
  $data = json_decode($app->request->getBody());

  $user_email = $data->email;

  if(filter_var($user_email, FILTER_VALIDATE_EMAIL)) {
    $posted = [];
    $posted['hash'] = hash('sha256', $user_email);
    $posted['email'] = $user_email;
    $time = new DateTime('24 hours ago');   
    $posted['time_formatted'] = $time->format('Y-m-d H:i:s');
    
    $processed = Users_model::forgotPasswordAction($db, $posted);

  } 
  echoResponse(200, $processed);
});


$app->post('/reset_password', function() use ($app){ 
  global $db;
  $data = json_decode($app->request->getBody());

  $result = Users_model::resetPasswordAction($db,
    $data->reset_key, 
    $data->email_address, 
    $data->password_token,
    $data->password,
    $data->verifyNewPass);
  
  echoResponse(200, $result);
});
?>