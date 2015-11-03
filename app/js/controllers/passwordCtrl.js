var app = angular.module('myApp');


app.controller('password_controller', ['$scope', '$location', '$routeParams', 'Data', function($scope, $location, $routeParams, Data) {

    // $scope.check_logged_in();
    $scope.user = {
        reset_key: "",
        email_address:  "",
        password_token: "",
        password: "",
        verifyNewPass:  ""
    }

    // $scope.matchError = false;
    // $scope.match = function (user, password) {
    //     $scope.matchError = (user.password != password) ? true : false;
    // }


    $scope.reset = function(user) {
        
        console.log("email: ", user);



        var tmp = {email: $scope.getCookieData().email};
        console.log(tmp);

        Data.post("forgot_password", tmp).then(function (result) {
                if(result.status != 'error'){
                    console.log("Email Sent: ", result);
                    $scope.saved();
                }else{
                    console.log("Error, Email not sent for password: ", result);

                } 
            }) 

    }

    $scope.resetLink = function(user) {
        
        $scope.user.reset_key = $routeParams.reset_key;
        $scope.user.password_token = $routeParams.password_token;
        $scope.user.email_address = $routeParams.email;

        console.log("email: ", $scope.user);
        Data.post("reset_password", $scope.user).then(function (result) {
                    if(result.status != 'error'){
                        console.log("Email Sent: ", result);
                    $scope.saved();
                        
                    }else{
                        console.log("Error, Email not sent for password: ", result);

                    } 
            }) 

    }

}]);
