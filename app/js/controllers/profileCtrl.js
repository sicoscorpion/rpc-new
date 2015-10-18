var app = angular.module('myApp');


app.controller('profile_controller', ['$scope', '$location', 'Data', 'NgTableParams', '$modal', '$cookies', '$route', function($scope, $location, Data, NgTableParams, $modal, $cookies, $route) {

    $scope.check_logged_in();

    $scope.users = [];
    $scope.users[0] = $scope.getCookieData();
    console.log("Returned Users: ", $scope.users);
    data = $scope.users;
    $scope.userTableParams = new NgTableParams({count: 10}, { data: data, counts: []});


    $scope.openProfile = function (user) {

        console.log("User Profile: ", user);
        $scope.userEdit = user;
        $scope.modalInstance = $modal.open({
          controller: "profile_controller",
          templateUrl: 'profile.html',
          scope: $scope,
            resolve: {
                user: function()
                {
                    return $scope;
                }
            }
             });
    };

}]);
