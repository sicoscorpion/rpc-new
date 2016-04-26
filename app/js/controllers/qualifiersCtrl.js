var app = angular.module('myApp');


app.controller('qualifiers_controller', ['$scope', '$location', 'Data', 'NgTableParams', '$modal', '$cookies', '$route', function($scope, $location, Data, NgTableParams, $modal, $cookies, $route) {

    // $scope.check_logged_in();

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


    if ($scope.isAdmin()){
        Data.get("qualifiers").then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Qualifiers: ", result);
                $scope.qualifiers = result;
                data = $scope.qualifiers;
                $scope.qualTableParams = new NgTableParams({count: 10}, { data: data, counts: []});
            }
        }) 
    }else if ($scope.isQualAdmin()){
        Data.get("host/qualifiers/" + $cookies.getObject("login").user_id).then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Qualifiers for qual admin: ", result);
                $scope.qualifiers = result;
                data = $scope.qualifiers;
                $scope.qualTableParams = new NgTableParams({count: 10}, { data: data, counts: []});
            }
        }) 

    }
    // else if ($scope.isCoach()){
        Data.get("qualifiers/open").then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Qualifiers: ", result);
                $scope.openQualifiers = result;
                // data = $scope.openQual;
                // $scope.qualTableParams = new NgTableParams({count: 10}, { data: data, counts: []});
            }
        })
    // }

    $scope.getQualifiers = function () {
        if ($scope.isAdmin()){
            Data.get("qualifiers").then(function (result) {
                if(result.status != 'error'){
                    console.log("Returned Qualifiers: ", result);
                    $scope.qualifiers = result;
                    data = $scope.qualifiers;
                    $scope.qualTableParams = new NgTableParams({count: 10}, { data: data, counts: []});
                }
            }) 
        }else if ($scope.isQualAdmin()){
            Data.get("host/qualifiers/" + $cookies.getObject("login").user_id).then(function (result) {
                if(result.status != 'error'){
                    console.log("Returned Qualifiers for qual admin: ", result);
                    $scope.qualifiers = result;
                    data = $scope.qualifiers;
                    $scope.qualTableParams = new NgTableParams({count: 10}, { data: data, counts: []});
                }
            }) 

        }
    }



    $scope.updateQual = function(qual) {

        if (typeof qual.province.type != "undefined"){
            qual.province = qual.province.type;
            
        }else{
            qual.province = qual.province;

        }

        qual.status = qual.status.type;
        delete qual.user_id;
        console.log("Updating Qualifiers: ", qual);
        console.log("Updating Qualifiers for user: ", $scope.getCookieData());
        var path = "qualifiers/" + qual.qual_id;
        Data.put(path, qual).then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Data from edit qual: ", result);
                $scope.getQualifiers();
                $scope.saved();

            }else{
                console.log("Error saving qual", result);
                $scope.fail();

            } 

            $scope.modalInstance.dismiss('cancel');
            
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
        $scope.getQualAdmins(qual);

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
        console.log("Creating Qualifier: ", qual);

        if (typeof qual.province.type != "undefined"){
            qual.province = qual.province.type;
            
        }else{
            qual.province = qual.province;

        }

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



    $scope.getQualAdmins = function(qual){
        Data.get("host/admins/" + $scope.q.qual_id).then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Admins for qualifier: ", result);
                $scope.participates = result;
                data = $scope.participates;
                $scope.qualPartTableParams = new NgTableParams({count: 10}, { data: data, counts: []});
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
            user_id: admin.user_id,
            qual_id: qual.qual_id,
            competition_id: qual.competition_id,
            season_year: qual.season_year
        }

        
        console.log("Adding part: ", $scope.part);
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


    $scope.deleteAdminPart = function(qual, admin) {
        
        console.log("deleting admin part : ", admin);
        var path = "host/" + qual.qual_id + "/" + admin.user_id;
        Data.delete(path).then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Data from delete admin part: ", result);
                $scope.saved();
                $route.reload();
                $scope.modalInstance.dismiss('cancel');


            }else{
                console.log("Error deleting admin part: ", result);
                $scope.fail();

            } 
        }) 
        // $route.reload();  

    }

    $scope.downloadQualifiers = function() {
        Data.get("qualifiers").then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Qualifiers: ", result);
                var csvContent = "Qual Id,Competition Id,Season Year,Name,Status,Time,Phone,Civic Number,Street1,Street2,City,Province,Postal Code,Capacity\n";
                for (row in result) {
                    csvContent += result[row].qual_id + ',' +
                    result[row].competition_id + ',' +
                    result[row].season_year + ',' +
                    result[row].name + ',' +
                    result[row].status + ',"' +
                    result[row].time + '",' +
                    result[row].phone + ',' +
                    result[row].civic_number + ',' +
                    result[row].street1 + ',' +
                    result[row].street2 + ',' +
                    result[row].city + ',' +
                    result[row].province + ',' +
                    result[row].postal_code + ',' +
                    result[row].capacity + '\n';
                }
                
                var hiddenElement = document.createElement("a");
                hiddenElement.href = 'data:attachment/csv,' + encodeURI(csvContent);
                hiddenElement.target = '_blank';
                hiddenElement.download = 'qualifiers.csv';
                document.body.appendChild(hiddenElement);
                hiddenElement.click();
            }
        })
    }

}]);
