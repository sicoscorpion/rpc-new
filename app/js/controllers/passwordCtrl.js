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

    $scope.matchError = false;
    $scope.match = function (user, password) {
        $scope.matchError = (user.password != password) ? true : false;
    }


    $scope.reset = function(user) {
        
        console.log("reset params: ", $routeParams);

        $scope.user.reset_key = $routeParams.reset_key;
        $scope.user.email_address = $routeParams.email;
        $scope.user.password_token = $routeParams.password_token;

        var tmp = {email: $scope.user.email};
        Data.post("forgot_password", tmp).then(function (result) {
                    if(result.status != 'error'){
                        console.log("Email Sent: ", result);

                    }else{
                        console.log("Error, Email not sent for password: ", result);

                    } 
            }) 

    }

}]);
