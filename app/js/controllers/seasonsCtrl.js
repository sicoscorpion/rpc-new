var app = angular.module('myApp');


app.controller('seasons_controller', ['$scope', '$location', 'Data', 'NgTableParams', '$modal', '$cookies', '$route', function($scope, $location, Data, NgTableParams, $modal, $cookies, $route) {

    $scope.check_logged_in();

    $scope.user = $cookies.getObject("login");

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

    $scope.years = [];

    var low = 2005;
    var high = 2006;

    for (var i = 0; i < 50; i++){

        $scope.years[i] = {type: low.toString() + "-" + high.toString()};
        low++;
        high++;
    }

    console.log($scope.years);

    Data.get("seasons").then(function (result) {
        if(result.status != 'error'){
            console.log("Returned Seasons: ", result);
            $scope.seasons = result;
            data = $scope.seasons;
            $scope.tableParams = new NgTableParams({count: 10}, { data: data, counts: [1, 25, 50, 100]});
        }
    }) 

    $scope.getSeasons = function(){
            // get seasons
        Data.get("seasons").then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Seasons: ", result);
                $scope.seasons = result;
                data = $scope.seasons;
                $scope.tableParams = new NgTableParams({count: 10}, { data: data, counts: [1, 25, 50, 100]});
            }
        }) 
    }

    $scope.updateSeason = function(season) {
        
        

        console.log("Updating Season: ", season);
        console.log("Updating Season for user: ", $scope.getCookieData());
        var path = "seasons/" + season.year;
        Data.put(path, season).then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Data from edit season: ", result);
                $scope.getSeasons();
            }else{
                console.log("Error saving season");
            } 
        }) 
        $route.reload();  

    }

    $scope.deleteSeason = function(season) {
        
        

        console.log("deleting Season: ", season);
        console.log("deleting Season for user: ", $scope.getCookieData());
        var path = "seasons/" + season.year;
        Data.delete(path).then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Data from delete season: ", result);
                $scope.getSeasons();
            }else{
                console.log("Error deleting season: ", result);
            } 
        }) 
        $route.reload();  

    }


    $scope.createSeason = function(season) {

        season.year = season.year.type;
        season.status = season.status.type;
        
        console.log("Creating Season: ", season);
        console.log("Creating Season for user: ", $scope.getCookieData());
        $scope.modalInstance.dismiss('cancel');

        Data.post("seasons", season).then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Data from create season: ", result);

                Data.post("seasons/host/" + $scope.user.user_id, season).then(function (result) {
                    if(result.status != 'error'){
                        console.log("Returned Data from create season: ", result);
                    }else{
                        console.log("Error creating season");
                    } 
                })
            }else{
                console.log("Error creating season");
            } 
        }) 

        $route.reload();  
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
