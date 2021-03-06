var app = angular.module('myApp');


app.controller('profile_controller', ['$scope', '$location', 'Data', 'NgTableParams', '$modal', '$cookies', '$route', function($scope, $location, Data, NgTableParams, $modal, $cookies, $route) {

    $scope.check_logged_in();

    $scope.users = [];
    $scope.users[0] = $scope.getCookieData();
    console.log("Returned Users: ", $scope.users);
    data = $scope.users;
    $scope.userTableParams = new NgTableParams({count: 10}, { data: data, counts: []});


    $scope.user = {
        first_name: '',
        last_name: '',
        email: '',
        password: '',
        position: '',
        DOB: '',
        role: '',
        civic_number: '',
        street1: '',
        street2: '',
        city: '',
        province: '',
        postal_code: '',
        medical_info: '',
        gender: '',
        phone: '',
        consent: '',
        position: '',
        admin: '',
        coach: '',
        shirt_size: ''
    }

    $scope.openProfile = function (user) {

        console.log("User Profile: ", user);
        $scope.userEdit = user;
        $scope.modalInstance = $modal.open({
          controller: "users_controller",
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

    $scope.updateUserProfile = function(user) {
        
            if (typeof user.gender.type != "undefined"){
                user.gender = user.gender.type;
                
            }else{
                user.gender = user.gender;

            }

        console.log("Updating User: ", user);
        console.log("Updating User for user: ", $scope.getCookieData());
        var path = "users/";

        $scope.addUserHasRole = {
            first_name: user.first_name,
            last_name: user.last_name,
            email: user.email,
            dob: user.dob,
            civic_number: user.civic_number,
            street1: user.street1,
            street2: user.street2,
            city: user.city,
            province: user.province.type,
            postal_code: user.postal_code,
            medical_info: user.medical_info,
            phone: user.phone,
            gender: user.gender
        }

        var path = "users/" + user.user_id;
        console.log("Edit User: ", $scope.addUserHasRole);
        Data.put(path, $scope.addUserHasRole).then(function (result) {
                if(result.status != 'error'){
                    console.log("Returned Data from registered User: ", result);
                    console.log("Editing User: ", $scope.addUserHasRole);
                    $scope.saved();
                    console.log("before", $cookies.getObject('login'));
                    var x = $cookies.getObject('login');
                    $.extend(x, $scope.addUserHasRole);
                    console.log("after", x);
                    $cookies.putObject('login', x);  


                }else{
                     console.log("Error: ", result);
                    $scope.register_status.message = 'Edit Failed';
                    $scope.register_status.disabled = false;
                    $scope.register_status.alert_type = 'alert round';
                    $scope.register_status.show_alert = true;
                    $scope.fail();

                } 
    
                $scope.modalInstance.dismiss('cancel');

        })
    }


    $scope.updateShirt = function(user) {
        
        console.log("Updating User Shirt: ", user);
        console.log("Updating User for user: ", $scope.getCookieData());
        var path = "users/";

        
        if (typeof user.shirt_size.type != "undefined"){
            var shirt = user.shirt_size.type;
            
        }else{
            var shirt = user.shirt_size;

        }
        if (typeof user.position.type != "undefined"){
            var position = user.position.type;
            
        }else{
            var position = user.position;

        }

        $scope.addUserHasRole = {
            shirt_size: shirt,
            position: position
        }

        $scope.tmp = {};
        if (user.position == "Super Admin")
        {
            var path = "users/" + "admin/" + user.user_id;
            $scope.tmp =  $scope.addUserHasRole;
            // delete tmp.position;

        }else if (user.position == "Qualifier Admin"){
            var path = "users/" + "qualifier_admin/" + user.user_id;
            $scope.tmp =  $scope.addUserHasRole;
            // delete tmp.position;
        }
        else{
            var path = "users/" + "coach/" + user.user_id;
            $scope.tmp =  $scope.addUserHasRole;
        }
        console.log("Edit User: ", $scope.tmp);
        Data.put(path, $scope.tmp).then(function (result) {
                if(result.status != 'error'){
                    console.log("Returned Data from update user role User: ", result);
                    console.log("Editing User: ", $scope.tmp);
                    $scope.saved();
                    var tmp = $scope.getCookieData();
                    tmp.shirt_size = $scope.addUserHasRole.shirt_size;
                    $cookies.putObject("login", tmp);  


                }else{
                     console.log("Error: ", result);
                    $scope.register_status.message = 'Edit Failed';
                    $scope.register_status.disabled = false;
                    $scope.register_status.alert_type = 'alert round';
                    $scope.register_status.show_alert = true;
                    $scope.failed();
                }
        });
    }


}]);
