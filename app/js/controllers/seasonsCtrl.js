var app = angular.module('myApp');


app.controller('seasons_controller', ['$scope', '$location', 'Data', 'NgTableParams', '$modal', '$cookies', '$route', '$timeout', function($scope, $location, Data, NgTableParams, $modal, $cookies, $route, $timeout) {

    $scope.check_logged_in();
    $scope.$watch('$invalid', function(validity) {})
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

    $scope.season_status = {
        disabled: false,
        message: 'Invaild form. Ensure season doesnt exist',
        show_alert: false,
        alert_type: 'warning round'
    }

    Data.get("seasons").then(function (result) {
        if(result.status != 'error'){
            console.log("Returned Seasons: ", result);
            $scope.seasons = result;
            data = $scope.seasons;
            $scope.tableParams = new NgTableParams({count: 10}, { data: data, counts: []});
        }

        $scope.years = [];

        var low = 2005;
        var high = 2006;

        for (var i = 0; i < 50; i++){
            $scope.years.push({type: low.toString() + "-" + high.toString()});
            low++;
            high++;
        }
    })


    $scope.getSeasons = function(){
            // get seasons
        Data.get("seasons").then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Seasons: ", result);
                $scope.seasons = result;
                data = $scope.seasons;
                $scope.tableParams = new NgTableParams({count: 10}, { data: data, counts: []});
            }
        }) 
    }



    $scope.updateSeason = function(season) {
        season.status = season.status.type;
        
        console.log("Updating Season: ", season);
        console.log("Updating Season for user: ", $scope.getCookieData());
        var path = "seasons/" + season.year;
        Data.put(path, season).then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Data from edit season: ", result);
                $scope.saved();
                
            }else{
                console.log("Error saving season", result);
                $scope.fail();

            } 
            
            // $route.reload();  

        }) 

    }

    $scope.deleteSeason = function(season) {
        
        console.log("deleting Season: ", season);
        console.log("deleting Season for user: ", $scope.getCookieData());
        var path = "seasons/" + season.year;
        Data.delete(path).then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Data from delete season: ", result);
                $scope.getSeasons();
                $scope.saved();


            }else{
                console.log("Error deleting season: ", result);
                $scope.fail();

            } 
        }) 
        // $route.reload();  

    }


    $scope.createSeason = function(season) {

        season.year = season.year.type;
        season.status = season.status.type;

        $scope.season_status.message = 'Logging in';
        $scope.season_status.disabled = true;
        $scope.season_status.show_alert = true;
        $scope.season_status.alert_type = 'info round';

        
        console.log("Creating Season: ", season);
        console.log("Creating Season for user: ", $scope.getCookieData());

        Data.post("seasons", season).then(function (result) {
            if(result.status != 'error'){
                var path = "seasons/host/" + $scope.user.user_id;
                console.log("Returned Data from create season: ", result);
                console.log("path: ", path);

                Data.post(path, season).then(function (result) {
                    if(result.status != 'error'){
                        console.log("Returned Data from create season: ", result);
                        $route.reload(); 
                        $scope.modalInstance.dismiss('cancel');
                        $scope.saved();


                    }else{
                        console.log("Error creating season", result);
                        $scope.season_status.message = 'Invaild form. Ensure season doesnt exist';
                        $scope.season_status.disabled = false;
                        $scope.season_status.alert_type = 'alert round';
                        $scope.season_status.show_alert = true;
                        $scope.fail();

                    } 
                })
            }else{
                console.log("Error creating season", result);
                $scope.season_status.message = 'Invaild form. Ensure season doesnt exist';
                $scope.season_status.disabled = false;
                $scope.season_status.alert_type = 'alert round';
                $scope.season_status.show_alert = true;
                $scope.fail();
                
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
