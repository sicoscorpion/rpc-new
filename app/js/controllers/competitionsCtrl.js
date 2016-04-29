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

    $scope.positions = [
      {type: "Super"},
      {type: "Qualifier"},
      {type: "H.Coach"},
      {type: "A.Coach"}
    ];

    $scope.comp_status = {
        disabled: false,
        message: 'Invaild form. Ensure season exists. ',
        show_alert: false,
        alert_type: 'warning round'
    }

    $scope.years = [];

    var low = 2005;
    var high = 2006;

    for (var i = 0; i < 50; i++){

        $scope.years[i] = {type: low.toString() + "-" + high.toString()};
        low++;
        high++;
    }


    $scope.getCompetitions = function (){
        // get competitions
        Data.get("competitions").then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Competitions: ", result);
                $scope.competitions = result;
                data = $scope.competitions;
                $scope.compTableParams = new NgTableParams({count: 10}, { data: data, counts: []});
            }
        }) 
    }

    $scope.deleteComp = function(comp) {
        
        console.log("deleting Competition: ", comp);
        console.log("deleting Competition for user: ", $scope.getCookieData());
        var path = "competitions/" + comp.competition_id;
        Data.delete(path).then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Data from delete comp: ", result);
                $scope.saved();
                $scope.getCompetitions();


            }else{
                console.log("Error deleting comp: ", result);
                $scope.failed();

            } 

        }) 

    }



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
        comp.status = comp.status.type;

        if (typeof comp.province.type != "undefined"){
            comp.province = comp.province.type;
            
        }else{
            comp.province = comp.province;

        }
        
        console.log("Updating Competition: ", comp);
        console.log("Updating Competition for user: ", $scope.getCookieData());
        var path = "competitions/" + comp.competition_id;
        Data.put(path, comp).then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Data from edit competition: ", result);
                $scope.saved();
                $scope.getCompetitions();


            }else{
                console.log("Error saving competition", result);
                $scope.failed();

            } 
            
            $route.reload();  

        }) 

    }

    $scope.createComp = function(competition) {
        console.log("Creating Competition: ", competition);

        if (typeof competition.province.type != "undefined"){
            competition.province = competition.province.type;
            
        }else{
            competition.province = competition.province;

        }

        competition.season_year = competition.season_year.year;
        competition.status = competition.status.type;
        
        console.log("Creating Competition: ", competition);
        console.log("Creating Competition for user: ", $scope.getCookieData());

        Data.post("competitions", competition).then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Data from create competition: ", result);
                $scope.modalInstance.dismiss('cancel');
                $scope.saved();

                $scope.getCompetitions();
                $route.reload();  


            }else{
                console.log("Error creating competition", result);
                $scope.comp_status.message = 'Invaild form. Ensure season exists.';
                $scope.comp_status.disabled = false;
                $scope.comp_status.alert_type = 'alert round';
                $scope.comp_status.show_alert = true;
                $scope.failed();

            } 
        }) 

  }

    /*
     * Function download competitions created by Martin Main in April 2016
     * to add download functionality to the page.
     */
    $scope.downloadCompetitions = function() {
        Data.get("competitions").then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Competitions: ", result);
                cleanup(result);

                var csvContent = "Competition Id,Season Year,Name,Status,Time,Phone,Civic Number,Street1,Street2,City,Province,Postal Code,Capacity\n";
                for (i in result) {
                    csvContent += result[i].competition_id + ',' +
                        result[i].season_year + ',' +
                        result[i].name + ',' +
                        result[i].status + ',' + // Time has a comma in the value
                        result[i].time + ',' +
                        result[i].phone + ',' +
                        result[i].civic_number + ',' +
                        result[i].street1 + ',' +
                        result[i].street2 + ',' +
                        result[i].city + ',' +
                        result[i].province + ',' +
                        result[i].postal_code + ',' +
                        result[i].capacity + ',' + '\n';
                }
                
                // Downloads content
                downloadCSV('competitions.csv', csvContent);
            }
        });
    };

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
    $scope.getCompetitions();

}]);
