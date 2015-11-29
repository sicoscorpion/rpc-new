<?php
require '.././libs/Slim/Slim.php';

require '.././libs/password.php';
require '.././libs/mail.php';

require 'models/users.php';
require 'models/seasons.php';
require 'models/competitions.php';
require 'models/qualifiers.php';
require 'models/teams.php';
require 'models/members.php';
require 'models/volunteers.php';



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

function authenticateToken() {
  global $db;
  $app = \Slim\Slim::getInstance();
  $token = $app->request->headers->get('Authorization');
  $token = str_replace('"', "", $token);
  $tokenFromDB = Users_model::get_user_by_token($db, $token);
  if (!$tokenFromDB) {
    echoResponse(403, "Invalid Token");
    exit();
  }
}


require 'routes/users.php';
require 'routes/seasons.php';
require 'routes/competitions.php';
require 'routes/qualifiers.php';
require 'routes/teams.php';
require 'routes/members.php';
require 'routes/volunteers.php';


function echoResponse($status_code, $response) {
  global $app;
  $app->status($status_code);
  $app->contentType('application/json');
  echo json_encode($response,JSON_NUMERIC_CHECK);
}

$app->run();
?>