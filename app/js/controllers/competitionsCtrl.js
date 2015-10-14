var app = angular.module('myApp');


app.controller('competitions_controller', ['$scope', '$location', function($scope, $location) {

    $scope.check_logged_in();

    // get competitions
    // Data.get("competitions").then(function (result) {
    //     if(result.status != 'error'){
    //         console.log("Returned Seasons: ", result);
    //         $scope.seasons = result;
    //         data = $scope.seasons;
    //         $scope.tableParams = new NgTableParams({count: 10}, { data: data, counts: [1, 25, 50, 100]});
    //     }
    // }) 

}]);
