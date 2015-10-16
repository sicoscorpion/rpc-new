var app = angular.module('myApp');


app.controller('competitions_controller', ['$scope', '$location', 'Data', 'NgTableParams', '$modal', '$cookies', '$route', function($scope, $location, Data, NgTableParams, $modal, $cookies, $route) {

    $scope.check_logged_in();
    $scope.$watch('$invalid', function(validity) {})


    $scope.comp = {
        season_year: '',
        status: '',
        name: '',
        civic_number: '',
        street1: '',
        street2: '',
        city: '',
        province: '',
        postal_code: '',
        time: '',
        phone: '',
        capacity: ''
    }

    $scope.options = [
      {type: "closed"},
      {type: "open"},
      {type: "completed"}
    ];


    $scope.years = [];

    var low = 2005;
    var high = 2006;

    for (var i = 0; i < 50; i++){

        $scope.years[i] = {type: low.toString() + "-" + high.toString()};
        low++;
        high++;
    }

    // get competitions
    Data.get("competitions").then(function (result) {
        if(result.status != 'error'){
            console.log("Returned Competitions: ", result);
            $scope.competitions = result;
            data = $scope.competitions;
            $scope.compTableParams = new NgTableParams({count: 10}, { data: data, counts: [1, 25, 50, 100]});
        }
    }) 

    $scope.openProfile = function (comp) {

        console.log("Competition Profile: ", comp);
        $scope.compEdit = comp;
        $scope.modalInstance = $modal.open({
          controller: "competitions_controller",
          templateUrl: 'profile.html',
          scope: $scope,
            resolve: {
                competition: function()
                {
                    return $scope;
                }
            }
             });
    };


    $scope.updateComp = function(comp) {
        
        console.log("Updating Competition: ", comp);
        console.log("Updating Competition for user: ", $scope.getCookieData());
        var path = "competitions/" + comp.competition_id;
        Data.put(path, comp).then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Data from edit competition: ", result);
            }else{
                console.log("Error saving competition", result);
            } 
            
            $route.reload();  

        }) 

    }

    $scope.createComp = function(competition) {

        competition.season_year = competition.season_year.type;
        competition.status = competition.status.type;
        
        console.log("Creating Competition: ", competition);
        console.log("Creating Competition for user: ", $scope.getCookieData());
        $scope.modalInstance.dismiss('cancel');

        Data.post("competitions", competition).then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Data from create competition: ", result);

                
            }else{
                console.log("Error creating competition", result);
            } 
        }) 

        $route.reload();  
  }

        // MODAL WINDOW
    $scope.openCompetition = function () {
        console.log("Open Competition Modal");


        $scope.modalInstance = $modal.open({
          controller: "competitions_controller",
          templateUrl: 'newComp.html',
          scope: $scope,
          resolve: {
                competition: function()
                {
                    return $scope;
                }
            }

        });
    };


}]);
