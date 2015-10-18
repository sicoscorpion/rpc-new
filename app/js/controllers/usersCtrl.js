var app = angular.module('myApp');


app.controller('users_controller', ['$scope', '$location', 'Data', '$cookies', function($scope, $location, Data, $cookies) {

    $scope.check_logged_in();

    if ($scope.isAdmin()){
        // get registered users
        Data.get("users").then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Users: ", result);
                $scope.users = result;
                data = $scope.users;
                $scope.userTableParams = new NgTableParams({count: 10}, { data: data, counts: [1, 25, 50, 100]});
            }
        }) 
    }else{
        $scope.users = [];
        $scope.users[0] = $scope.getCookieData();
        console.log("Returned Users: ", users);
        data = $scope.users;
        $scope.userTableParams = new NgTableParams({count: 10}, { data: data, counts: []});
    }

    console.log("Users: ", $scope.users);

}]);
