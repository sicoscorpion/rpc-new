var app = angular.module('myApp');

app.controller('login_controller', ['$scope', '$location', 'Data', '$cookies', function($scope, $location, Data, $cookies) {
    
    var loginCookie = 'login';
    $scope.logged_in = Data.logged_in;
    $scope.log_out = Data.log_out;
    
    $scope.user = {
        first_name: '',
        last_name: '',
        email: '',
        password: '',
        position: '',
        DOB: '',
        role: '',
        phone: ''
    }

    $scope.login_status = {
        disabled: false,
        message: 'Please sign in',
        show_alert: false,
        alert_type: 'warning round'
    }

    $scope.register_status = {
        disabled: false,
        message: 'Please register a new account',
        show_alert: false,
        alert_type: 'warning round'
    }

    $scope.positions = [
          {type: "Head Coach"},
          {type: "Assistant Coach"},
          {type: "None"}
        ];

    $scope.yay = function () {

        console.log("**********************************");
    }
    
    // send a login request and if successful redirect to landing page
    $scope.login = function() {

        $scope.emailError = false; 
        $scope.passwordError = false;
        
        if ($scope.user.email == ""){
            $scope.emailError = true; 
        }

        if ($scope.user.password == ""){
           $scope.passwordError = true;
        }

        if (!$scope.passwordError && !$scope.emailError)
        {
            $scope.login_status.message = 'Logging in';
            $scope.login_status.disabled = true;
            $scope.login_status.show_alert = true;
            $scope.login_status.alert_type = 'info round';

            Data.post("login", $scope.user).then(function (result) {
                    if(result.status != 'error'){
                        console.log("Returned Data from Login: ", result);
                        $cookies.putObject(loginCookie, result);  
                        $location.path('/home');
                    }else{
                        $scope.login_status.message = 'Login Failed';
                        $scope.login_status.disabled = false;
                        $scope.login_status.alert_type = 'alert round';
                        $scope.login_status.show_alert = true;
                    } 
            })  
        }

    }

    $scope.setRole = function(role) {
        console.log("setting role", role);
        if (role == "Head Coach" || role == "Assistant Coach"){
            $scope.user.role = "Coach";
        }else{
            $scope.user.role = null;
        }
    }

    $scope.register = function() {

        $scope.user.position = $scope.user.position.type;

        $scope.emailError = false; 
        $scope.passwordError = false;
        
        if ($scope.user.email == ""){
            $scope.emailError = true; 
        }

        if ($scope.user.password == ""){
           $scope.passwordError = true;
        }

        if (!$scope.passwordError && !$scope.emailError)
        {
            console.log("Adding User: ", $scope.user);
            $scope.register_status.message = 'Registering';
            $scope.register_status.disabled = true;
            $scope.register_status.show_alert = true;
            $scope.register_status.alert_type = 'info round';

            Data.post("users", $scope.user).then(function (result) {
                    if(result.status != 'error'){
                        console.log("Returned Data from registered User: ", result);
                        $location.path('/login');
                    }else{
                        $scope.register_status.message = 'Registration Failed';
                        $scope.register_status.disabled = false;
                        $scope.register_status.alert_type = 'alert round';
                        $scope.register_status.show_alert = true;
                    } 
            })  
        }
    }

    $scope.getCookieData = function () {
        return $cookies.getObject(loginCookie);
    }

        // check if the user is logged in
    $scope.logged_in = function() {
        if (typeof $cookies.getObject(loginCookie) != "undefined")
            if ($cookies.getObject(loginCookie).username != "undefined") 
                return true;
        return false;
    }

    // redirect to login page if not logged in
    $scope.check_logged_in = function() {
        if (!this.logged_in())
            $location.path('/login');
    }
    
    // log the user out (remove the logged in cookie)
    $scope.log_out = function() {
        $cookies.remove(loginCookie);
    }   
}]);

app.filter('propsFilter', function() {
  return function(items, props) {
    var out = [];

    if (angular.isArray(items)) {
      items.forEach(function(item) {
        var itemMatches = false;

        var keys = Object.keys(props);
        for (var i = 0; i < keys.length; i++) {
          var prop = keys[i];
          var text = props[prop].toLowerCase();
          if (item[prop].toString().toLowerCase().indexOf(text) !== -1) {
            itemMatches = true;
            break;
          }
        }

        if (itemMatches) {
          out.push(item);
        }
      });
    } else {
      // Let the output be the input untouched
      out = items;
    }

    return out;
  }
});
