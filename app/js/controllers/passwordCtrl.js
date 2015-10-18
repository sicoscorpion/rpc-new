var app = angular.module('myApp');


app.controller('password_controller', ['$scope', '$location', '$routeParams', function($scope, $location, $routeParams) {

    $scope.check_logged_in();
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
        $scope.user.email_address = $routeParams.reset_key;
        $scope.user.password_token = $routeParams.password_token;

        // console.log("deleting Competition: ", comp);
        // console.log("deleting Competition for user: ", $scope.getCookieData());
        // var path = "competitions/" + comp.competition_id;
        // Data.delete(path).then(function (result) {
        //     if(result.status != 'error'){
        //         console.log("Returned Data from delete comp: ", result);
        //     }else{
        //         console.log("Error deleting comp: ", result);
        //     } 

        // }) 

    }

}]);
