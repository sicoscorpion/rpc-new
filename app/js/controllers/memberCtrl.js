var app = angular.module('myApp');


app.controller('members_controller', ['$scope', '$location', 'Data', 'NgTableParams', '$modal', '$cookies', '$route', '$timeout', function($scope, $location, Data, NgTableParams, $modal, $cookies, $route, $timeout) {

    $scope.check_logged_in();

    $scope.member_status = {
        disabled: false,
        message: 'Invaild form',
        show_alert: false,
        alert_type: 'warning round'
    }

    $scope.member = {
        team_id: '',
        first_name: '',
        last_name: '',
        email: '',
        DOB: '',
        civic_number: '',
        street1: '',
        street2: '',
        city: '',
        province: '',
        postal_code: '',
        medical_info: '',
        gender: '',
        guardian_phone: '',
        consent: '',
        shirt_size: ''
    }


    if ($scope.isAdmin){
        Data.get("teams").then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Teams for Admin: ", result);
                $scope.teams = result;
                data = $scope.seasons;
                $scope.teamTableParams = new NgTableParams({count: 10}, { data: data, counts: [1, 25, 50, 100]});
            }
        })
    }else{
        Data.get("manage/teams/" + $scope.getCookieData().user_id).then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Teams for coach: ", result);
                $scope.coaches = result;
                data = $scope.coaches;
                $scope.teamCoachTableParams = new NgTableParams({count: 10}, { data: data, counts: []});
            }
        })
    }

    $scope.addNewMember = function(member) {

        $scope.member_status.message = 'Logging in';
        $scope.member_status.disabled = true;
        $scope.member_status.show_alert = true;
        $scope.member_status.alert_type = 'info round';
        // member.team_id = team.team_id;

        if (typeof $scope.member.shirt_size.type != "undefined"){
            $scope.member.shirt_size = $scope.member.shirt_size.type;
            
        }else{
            $scope.member.shirt_size = $scope.member.shirt_size;

        }
        if (typeof $scope.member.province.type != "undefined"){
            $scope.member.province = $scope.member.province.type;
            
        }else{
            $scope.member.province = $scope.member.province;

        }
        if (typeof $scope.member.gender.type != "undefined"){
            $scope.member.gender = $scope.member.gender.type;
            
        }else{
            $scope.member.gender = $scope.member.gender;

        }
        if (typeof $scope.member.team_id.team_id != "undefined"){
            $scope.member.team_id = $scope.member.team_id.team_id;
            
        }else{
            $scope.member.team_id = $scope.member.team_id;

        }

        
        console.log("Creating Member: ", member);
        console.log("Creating Member for user: ", $scope.getCookieData());

        Data.post("member", member).then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Data from add member: ", result);
                $scope.saved();
                $scope.getTeams();


            }else{
                console.log("Error adding member", result);
                $scope.member_status.message = 'Invaild form';
                $scope.member_status.disabled = false;
                $scope.member_status.alert_type = 'alert round';
                $scope.member_status.show_alert = true;
                $scope.fail();
                
            } 

            $scope.modalInstance.dismiss('cancel');

        }) 

    }

    // MODAL WINDOW
    $scope.openMembers = function () {
        console.log("Open Team add member Modal");

        $scope.modalInstance = $modal.open({
          controller: "members_controller",
          templateUrl: 'teamAddMember.html',
          scope: $scope,
          resolve: {
                teamMember: function()
                {
                    return $scope;
                }
            }

        });
    };


}]);
