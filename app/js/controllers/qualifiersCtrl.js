var app = angular.module('myApp');


app.controller('qualifiers_controller', ['$scope', '$location', 'Data', 'NgTableParams', '$modal', '$cookies', '$route', function($scope, $location, Data, NgTableParams, $modal, $cookies, $route) {

    $scope.check_logged_in();

    $scope.qual = {
        competition_id: '',
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

    // get qualifiers


    // if ($scope.isAdmin()){
        Data.get("qualifiers").then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Qualifiers: ", result);
                $scope.qualifiers = result;
                data = $scope.qualifiers;
                $scope.qualTableParams = new NgTableParams({count: 10}, { data: data, counts: [1, 25, 50, 100]});
            }
        }) 
    // }
    // else if ($scope.isCoach()){
        Data.get("qualifiers/open").then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Qualifiers: ", result);
                $scope.openQualifiers = result;
                // data = $scope.openQual;
                // $scope.qualTableParams = new NgTableParams({count: 10}, { data: data, counts: [1, 25, 50, 100]});
            }
        })
    // }



    $scope.updateQual = function(qual) {
        qual.status = qual.status.type;
        console.log("Updating Qualifiers: ", qual);
        console.log("Updating Qualifiers for user: ", $scope.getCookieData());
        var path = "qualifiers/" + qual.qualifier_id;
        Data.put(path, qual).then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Data from edit qual: ", result);
                $scope.saved();

            }else{
                console.log("Error saving qual", result);
                $scope.fail();

            } 
            
            $route.reload();  

        }) 

    }

    $scope.openProfile = function (qual) {

        console.log("Qualifier Profile: ", qual);
        $scope.qualEdit = qual;
        $scope.modalInstance = $modal.open({
          controller: "qualifiers_controller",
          templateUrl: 'profile.html',
          scope: $scope,
            resolve: {
                qualifier: function()
                {
                    return $scope;
                }
            }
             });
    };

    $scope.openAdmins = function (qual) {

        console.log("Qualifier Profile: ", qual);
        $scope.q = qual;
        $scope.modalInstance = $modal.open({
          controller: "qualifiers_controller",
          templateUrl: 'admin.html',
          scope: $scope,
            resolve: {
                admin: function()
                {
                    return $scope;
                }
            }
             });
    };

    $scope.createQual = function(qual) {

        qual.status = qual.status.type;
        console.log("Creating Qualifier: ", qual);
        console.log("Creating Qualifier for user: ", $scope.getCookieData());

        Data.post("qualifiers", qual).then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Data from create qual: ", result);
                $scope.modalInstance.dismiss('cancel');
                $scope.saved();

                $route.reload();  

            }else{
                console.log("Error creating qual", result);
                $scope.comp_status.message = 'Invaild form. Ensure Competition and Season exist.';
                $scope.comp_status.disabled = false;
                $scope.comp_status.alert_type = 'alert round';
                $scope.comp_status.show_alert = true;
                $scope.failed();

            } 
        }) 

  }


    $scope.setYearNComp = function (year, id){

        $scope.qual.season_year = year;
        $scope.qual.competition_id = id;
    }


    $scope.setQualAdmin = function (admin){
        $scope.adminForQual = admin;
    }

        // MODAL WINDOW
    $scope.openQual = function () {
        console.log("Open Qual Modal");


        $scope.modalInstance = $modal.open({
          controller: "qualifiers_controller",
          templateUrl: 'newQual.html',
          scope: $scope,
          resolve: {
                qualifier: function()
                {
                    return $scope;
                }
            }

        });
    };


    $scope.addQualAdmin = function(qual, admin) {

        console.log("qual: ", qual);
        console.log("admin: ", admin);

        $scope.part = {
            user_id: admin.admin_id,
            qual_id: qual.qual_id,
            competition_id: qual.competition_id,
            season_year: qual.season_year
        }

        
        console.log("Adding admin qual: ", admin);
        console.log("Adding admin for user: ", $scope.getCookieData());

        Data.post("host", $scope.part).then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Data from add team part: ", result);
                $scope.saved();
                $route.reload();
                $scope.modalInstance.dismiss('cancel');

            }else{
                $scope.modalInstance.dismiss('cancel');
                console.log("Error creating team", result);
                $scope.fail();
                
            } 
        }) 

    }


}]);
