<?php
/*
 * File:        members.php
 * Author:      Fady Abdelmohsen
 * Date:        Fall 2015
 * Purpose:     Handles all requests relating to members.
 */

// Members
$app->post('/member', 'authenticateToken', function() use ($app){ 
  global $db;
  $data = json_decode($app->request->getBody());
  $rows = Members_model::create_member($db, $data);
  echoResponse(200, $rows);
});

$app->get('/members/:team_id', function($team_id) use ($app){ 
  global $db;
  $data = json_decode($app->request->getBody());
  $rows = Members_model::get_members($db, $team_id);
  echoResponse(200, $rows);
});

$app->put('/member/:id', 'authenticateToken', function($id) use ($app){ 
  global $db;
  $data = json_decode($app->request->getBody());

  $rows = Members_model::update_member($db, $data, $id);
  if($rows["status"]=="success")
      $rows["message"] = "Member information updated successfully.";
  echoResponse(200, $rows);
});

$app->delete('/member/:id', 
  'authenticateToken', function($id) use ($app){
  global $db;
  $rows = Members_model::delete_member($db, $id);
  echoResponse(200, $rows);
});

?>