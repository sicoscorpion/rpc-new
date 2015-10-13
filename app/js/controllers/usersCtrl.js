var app = angular.module('myApp');


app.controller('users_controller', ['$scope', '$location', 'Data', '$cookies', function($scope, $location, Data, $cookies) {

    $scope.check_logged_in();

    // get registered users
    Data.get("users").then(function (result) {
        if(result.status != 'error'){
            console.log("Returned Users: ", result);
            $scope.users = result;
        }
    }) 


}]);
