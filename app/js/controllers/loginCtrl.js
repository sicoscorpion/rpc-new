var app = angular.module('myApp');

app.controller('login_controller', ['$scope', '$location', 'Data', '$cookies', '$route', '$timeout', function($scope, $location, Data, $cookies, $route, $timeout) {
    
    var loginCookie = 'login';
    $scope.logged_in = Data.logged_in;
    $scope.log_out = Data.log_out;
    $scope.matchError = false;
    $scope.$watch('$invalid', function(validity) {})
    
    $scope.user = {
        first_name: '',
        last_name: '',
        email: '',
        password: '',
        position: '',
        DOB: '',
        role: '',
        civic_number: '',
        street1: '',
        street2: '',
        city: '',
        province: '',
        postal_code: '',
        medical_info: '',
        phone: '',
        gender: '',
        shirt_size: ''
    }

    $scope.provinces = [{type: 'AB'}, {type: 'BC'}, {type: 'MB'}, {type: 'NB'}, {type: 'NL'}, {type: 'NT'}, {type: 'NS'}, {type: 'NU'}, {type: 'ON'}, {type: 'PE'}, {type: 'QC'}, {type: 'SK'}, {type: 'YT'}];

    $scope.shirts = [
        {type: 'Adult XS'},
        {type: 'Adult S'},
        {type: 'Adult M'},
        {type: 'Adult L'},
        {type: 'Adult XL'},
        {type: 'Adult XXL'},
        {type: 'Adult XXXL'},
        {type: 'Youth S'},
        {type: 'Youth M'},
        {type: 'Youth L'},
        {type: 'Youth XL'}
    ];


    $scope.genders = [
        {type: 'Male'},
        {type: 'Female'},
        {type: 'Other'}
    ];

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
          {type: "Main Coach"},
          {type: "Assistant Coach"}
          // {type: "None"}
        ];

    $scope.succeeded = false;
    $scope.failed = false;

    $scope.phoneNumberPattern = (function() {
        var regexp = /^\(?(\d{3})\)?[ .-]?(\d{3})[ .-]?(\d{4})$/;
        return {
            test: function(value) {
                if( $scope.requireTel === false ) {
                    return true;
                }
                return regexp.test(value);
            }
        };
    })();


    $scope.saved = function() {
        $scope.succeeded = true;
        $timeout(function(){
            $scope.succeeded = false;
        }, 3000);
    }

    $scope.fail = function() {
        $scope.failed = true;
            $timeout(function(){
                $scope.failed = false;
            }, 3000);

    }



    $scope.isAdmin = function () {
        if (typeof $cookies.getObject("login") != "undefined"){
            // console.log("User: ", $scope.getCookieData());
           return $scope.getCookieData().admin == 1;
        }
        return false;
    }

    $scope.isQualAdmin = function () {
        if (typeof $cookies.getObject("login") != "undefined"){
           return $scope.getCookieData().qualifier_admin == 1;
        }
        return false;
    }

    $scope.isCoach = function () {
        if (typeof $cookies.getObject("login") != "undefined"){
           return $scope.getCookieData().coach == 1;
        }
        return false;
    }

    $scope.match = function (user, password) {
        $scope.matchError = (user.password != password) ? true : false;
    }

    $scope.forgotPassword = function (){
        console.log("forgot password");
        $location.path('/forgot_password');

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
                        console.log("Returned Data from Login Error: ", result);

                        $scope.login_status.message = 'Login Failed';
                        $scope.login_status.disabled = false;
                        $scope.login_status.alert_type = 'alert round';
                        $scope.login_status.show_alert = true;
                    } 
                console.log("****s: ", result);

            }, function (error){
                console.log("Returned Data from Login Error: ", error);

                $scope.login_status.message = 'Invalid user name or password';
                $scope.login_status.disabled = false;
                $scope.login_status.alert_type = 'alert round';
                $scope.login_status.show_alert = true;
            })
        }

    }

    $scope.setRole = function(role) {
        console.log("setting role", role);
        
    }

    $scope.register = function() {

        $scope.user.position = $scope.user.position.type;
        $scope.user.shirt_size = $scope.user.shirt_size.type;
        $scope.user.province = $scope.user.province.type;
        $scope.user.gender = $scope.user.gender.type;

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

            $scope.register_status.message = 'Registering';
            $scope.register_status.disabled = true;
            $scope.register_status.show_alert = true;
            $scope.register_status.alert_type = 'info round';

            $scope.addUserHasRole = {
                first_name: $scope.user.first_name,
                last_name: $scope.user.last_name,
                email: $scope.user.email,
                position: $scope.user.position,
                DOB: $scope.user.DOB,
                civic_number: $scope.user.civic_number,
                street1: $scope.user.street1,
                street2: $scope.user.street2,
                city: $scope.user.city,
                province: $scope.user.province,
                postal_code: $scope.user.postal_code,
                medical_info: $scope.user.medical_info,
                phone: $scope.user.phone,
                shirt_size: $scope.user.shirt_size,
                gender: $scope.user.gender
            }

            $scope.addUser = {
                first_name: $scope.user.first_name,
                last_name: $scope.user.last_name,
                email: $scope.user.email,
                password: $scope.user.password,
                DOB: $scope.user.DOB,
                civic_number: $scope.user.civic_number,
                street1: $scope.user.street1,
                street2: $scope.user.street2,
                city: $scope.user.city,
                province: $scope.user.province,
                postal_code: $scope.user.postal_code,
                medical_info: $scope.user.medical_info,
                phone: $scope.user.phone,
                gender: $scope.user.gender

            }
            console.log("Adding User: ", $scope.addUser);

            Data.post("users", $scope.addUser).then(function (result) {
                    if(result.status != 'error'){
                        console.log("Returned Data from registered User: ", result);

                        $scope.addUserHasRole.user_id = result.data;
                        console.log("Adding User: ", $scope.addUserHasRole);

                        // if ($scope.user.position != ""){
                            Data.post("users/coach", $scope.addUserHasRole).then(function (result) {
                                    if(result.status != 'error'){
                                        console.log("Returned Data from registered User: ", result);
                                        $location.path('/login');

                                    }else{
                                        console.log("Error: ", result);

                                        $scope.register_status.message = 'Registration Failed';
                                        $scope.register_status.disabled = false;
                                        $scope.register_status.alert_type = 'alert round';
                                        $scope.register_status.show_alert = true;
                                    } 
                            }) 
                        // }


                    }else{
                         console.log("Error: ", result);

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
        // get the authorization token for the logged in user
    getAuthToken = function() {
        return 'Token token='.concat($cookies.getObject(loginCookie)['api_token']);
    }

    // redirect to login page if not logged in
    $scope.check_logged_in = function() {
        if (!this.logged_in())
            $location.path('/login');
    }
    
    // log the user out (remove the logged in cookie)
    $scope.log_out = function() {
        $cookies.remove(loginCookie);
        $location.path('/login');
        $route.reload();
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

app.filter('match', function() {
    return function(voul, pos) {
        if (typeof pos.voul == "undefined") {
            return [];
        }else{
            var out = [];
            console.log(voul, pos)
            for (var i = 0; i < pos.pos.length; i++) {
                if(pos.voul.affiliation == pos.pos[i].affiliation){
                    out.push(pos.pos[i]);
                }
            }
            return out;
        }
    }
});

app.filter('qualFilter', function() {

    return function(input, uppercase) {
        var out = [];
        for (var i = 0; i < input.length; i++) {
            if(input[i].coach == 1){
                out.push(input[i]);
            }
        }
        return out;
    }

});

app.filter('filterQualAdmin', function() {

    return function(input, uppercase) {
        var out = [];
        for (var i = 0; i < input.length; i++) {
            if(input[i].qualifier_admin == 1){
                out.push(input[i]);
            }
        }
        return out;
    }

});

app.filter('open', function() {

    return function(input, uppercase) {
        var out = [];
        for (var i = 0; i < input.length; i++) {
            if(input[i].status == "open"){
                out.push(input[i]);
            }
        }
        return out;
    }

});




