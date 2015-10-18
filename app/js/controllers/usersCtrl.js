var app = angular.module('myApp');


app.controller('users_controller', ['$scope', '$location', 'Data', 'NgTableParams', '$modal', '$cookies', '$route', function($scope, $location, Data, NgTableParams, $modal, $cookies, $route) {

    $scope.check_logged_in();

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


    $scope.shirts = [
        {type: 'small'},
        {type: 'medium'},
        {type: 'large'}
    ];

    $scope.positions = [
          {type: "Main Coach"},
          {type: "Assistant Coach"},
          {type: "Super Admin"},
          {type: "Qualifier Admin"}
          // {type: "None"}
        ];



    $scope.updateUser = function(user) {
        
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
                }else{
                     console.log("Error: ", result);
                    $scope.register_status.message = 'Edit Failed';
                    $scope.register_status.disabled = false;
                    $scope.register_status.alert_type = 'alert round';
                    $scope.register_status.show_alert = true;
                } 
        })
    }

    $scope.updateUserRole = function(user) {
        
        console.log("Updating User Role: ", user);
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

        if (user.position == "Super Admin" || user.position == "Qualifier Admin")
        {
            var path = "users/" + "admin/" + user.user_id;

        }else{
            var path = "users/" + "coach/" + user.user_id;
            
        }
        console.log("Edit User: ", $scope.addUserHasRole);
        Data.put(path, $scope.addUserHasRole).then(function (result) {
                if(result.status != 'error'){
                    console.log("Returned Data from update user role User: ", result);
                    console.log("Editing User: ", $scope.addUserHasRole);
                }else{
                     console.log("Error: ", result);
                    $scope.register_status.message = 'Edit Failed';
                    $scope.register_status.disabled = false;
                    $scope.register_status.alert_type = 'alert round';
                    $scope.register_status.show_alert = true;
                } 
        })
    }

    $scope.deleteUser = function(user) {
        
        console.log("deleting User: ", user);
        console.log("deleting User for user: ", $scope.getCookieData());

        if (user.position == "Super Admin" || user.position == "Qualifier Admin")
        {
            var path = "users/" + "admin/" + user.user_id;

        }else{
            var path = "users/" + "coach/" + user.user_id;
            
        }

        Data.delete(path).then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Data from delete user: ", result);
            }else{
                console.log("Error deleting user: ", result);
            } 
        }) 
        $route.reload();  

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

    $scope.openRole = function (user) {

        console.log("User Role: ", user);
        $scope.userEdit = user;
        $scope.modalInstance = $modal.open({
          controller: "users_controller",
          templateUrl: 'role.html',
          scope: $scope,
            resolve: {
                user: function()
                {
                    return $scope;
                }
            }
             });
    };

    if ($scope.isAdmin()){
        // get registered users
        Data.get("users").then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Users: ", result);
                $scope.users = result;
                data = $scope.users;
                $scope.userTableParams = new NgTableParams({count: 10}, { data: data, counts: [1, 25, 50, 100]});
            }
        }) 
    }else{
        $scope.users = [];
        $scope.users[0] = $scope.getCookieData();
        console.log("Returned Users: ", users);
        data = $scope.users;
        $scope.userTableParams = new NgTableParams({count: 10}, { data: data, counts: []});
    }

    console.log("Users: ", $scope.users);

}]);
