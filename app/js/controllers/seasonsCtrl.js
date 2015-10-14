var app = angular.module('myApp');


app.controller('seasons_controller', ['$scope', '$location', 'Data', 'NgTableParams', '$modal', function($scope, $location, Data, NgTableParams, $modal) {

    $scope.check_logged_in();

    $scope.options = [
      {type: "closed"},
      {type: "open"},
      {type: "completed"}
    ];

    $scope.season = {
        year: '',
        info: '',
        status: '',
    }

    // get seasons
    Data.get("seasons").then(function (result) {
        if(result.status != 'error'){
            console.log("Returned Seasons: ", result);
            $scope.seasons = result;
            data = $scope.seasons;
            $scope.tableParams = new NgTableParams({count: 10}, { data: data, counts: [1, 25, 50, 100]});
        }
    }) 


    $scope.updateSeason = function(season) {
        
        season.email = $scope.getCookieData().email;

        console.log("Updating Season: ", season);
        console.log("Updating Season for user: ", $scope.getCookieData());

        Data.put("seasons", season).then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Data from edit season: ", result);
            }else{
                console.log("Error saving season");

            } 
        }) 
    }


    $scope.createSeason = function(season) {
        
        season.email = $scope.getCookieData().email;

        console.log("Creating Season: ", season);
        console.log("Creating Season for user: ", $scope.getCookieData());

        Data.put("seasons", season).then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Data from create season: ", result);
            }else{
                console.log("Error creating season");

            } 
        }) 
    }


        // MODAL WINDOW
    $scope.openSeason = function () {
        console.log("Open Season Modal");


        $scope.modalInstance = $modal.open({
          controller: "seasons_controller",
          templateUrl: 'newSeason.html',
          scope: $scope,
            resolve: {
                season: function()
                {
                    return $scope;
                }
            }
        });
    };


}]);
