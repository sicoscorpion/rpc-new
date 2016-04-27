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

    $scope.team = {};

    $scope.member_status = {
        disabled: false,
        message: 'Invaild form. Ensure member doesnt exist',
        show_alert: false,
        alert_type: 'warning round'
    }

    if ($scope.isAdmin()){
        Data.get("teams").then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Teams for Admin: ", result);
                $scope.teams = result;
                data = $scope.seasons;
                $scope.teamTableParams = new NgTableParams({count: 10}, { data: data, counts: [1, 25, 50, 100]});
            }
        })
    }else if ($scope.isCoach()){
        Data.get("manage/teams/" + $scope.getCookieData().user_id).then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Teams for coach: ", result);
                $scope.teams = result;
                data = $scope.teams;
                $scope.teamTableParams = new NgTableParams({count: 10}, { data: data, counts: []});
            }
        })
    }

    // Data.get("members/" + $scope.team.team_id.team_id).then(function (result) {
    //     if(result.status != 'error'){
    //         console.log("Returned members: ", result);
    //         $scope.members = result;
    //         data = $scope.member;
    //         $scope.teamMemberTableParams = new NgTableParams({count: 10}, { data: data, counts: []});
    //     }
    // })

    $scope.openProfile = function (member) {

        console.log("Member Profile: ", member);
        $scope.memberEdit = member;
        $scope.modalInstance = $modal.open({
          controller: "members_controller",
          templateUrl: 'profile.html',
          scope: $scope,
            resolve: {
                member: function()
                {
                    return $scope;
                }
            }
             });
    };

    $scope.getMembers = function(){
                console.log("selected team: ", $scope.team.team_id.team_id);

        Data.get("members/" + $scope.team.team_id.team_id).then(function (result) {
            if(result.status != 'error'){
                console.log("Returned members: ", result);
                $scope.members = result;
                data = $scope.members;
                $scope.teamMemberTableParams = new NgTableParams({count: 10}, { data: data, counts: []});
            }
        })
    }

    $scope.getMembersForTeam = function(team_id){
                console.log("selected team: ", $scope.team.team_id.team_id);

        Data.get("members/" + team_id).then(function (result) {
            if(result.status != 'error'){
                console.log("Returned members: ", result);
                $scope.members = result;
                data = $scope.members;
                $scope.teamMemberTableParams = new NgTableParams({count: 10}, { data: data, counts: []});
            }
        })
    }

    $scope.getTeamsForQualAdmin = function(qual_id){
        Data.get("teams/" + qual_id).then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Teams for qual admin: ", result);
                $scope.teams = result;
                data = $scope.teams;
                $scope.teamTableParams = new NgTableParams({count: 10}, { data: data, counts: [1, 25, 50, 100]});
            }
        })
    }

    $scope.updateMember = function(member) {

        if (typeof member.gender.type != "undefined"){
            member.gender = member.gender.type;
            
        }else{
            member.gender = member.gender;

        }

        if (typeof member.shirt_size.type != "undefined"){
            member.shirt_size = member.shirt_size.type;
            
        }else{
            member.shirt_size = member.shirt_size;

        }


        
        console.log("Updating Member: ", member);
        console.log("Updating Member for member: ", $scope.getCookieData());
        var path = "members/";

        $scope.addMember = {
            first_name: member.first_name,
            last_name: member.last_name,
            email: member.email,
            dob: member.dob,
            civic_number: member.civic_number,
            street1: member.street1,
            street2: member.street2,
            city: member.city,
            province: member.province,
            postal_code: member.postal_code,
            medical_info: member.medical_info,
            shirt_size: member.shirt_size,
            guardian_phone: member.guardian_phone,
            gender: member.gender
        }

        var path = "member/" + member.member_id;
        console.log("Edit Member: ", $scope.addMember);
        Data.put(path, $scope.addMember).then(function (result) {
                if(result.status != 'error'){
                    console.log("Returned Data from edit Member: ", result);
                    console.log("Editing Member: ", $scope.addMember);
                    $scope.saved();

                }else{
                    console.log("Error: ", result);

                    $scope.fail();

                } 
                $scope.modalInstance.dismiss('cancel');
                
                $route.reload();
        })
    }

    $scope.updateMemberShirt = function(member) {

        if (typeof member.shirt_size.type != "undefined"){
            member.shirt_size = member.shirt_size.type;
            
        }else{
            member.shirt_size = member.shirt_size;

        }
        
        console.log("Updating Member Shirt: ", member);
        console.log("Updating Member for member: ", $scope.getCookieData());
        var path = "members/";

        $scope.addMember = {
            first_name: member.first_name,
            last_name: member.last_name,
            email: member.email,
            dob: member.dob,
            civic_number: member.civic_number,
            street1: member.street1,
            street2: member.street2,
            city: member.city,
            province: member.province,
            postal_code: member.postal_code,
            medical_info: member.medical_info,
            shirt_size: member.shirt_size,
            guardian_phone: member.guardian_phone,
            gender: member.gender
        }

        var path = "member/" + member.member_id;
        console.log("Edit Member: ", $scope.addMember);
        Data.put(path, $scope.addMember).then(function (result) {
                if(result.status != 'error'){
                    console.log("Returned Data from edit Member Shirt: ", result);
                    console.log("Editing Member: ", $scope.addMember);
                    $scope.saved();

                }else{
                    console.log("Error: ", result);

                    $scope.fail();

                } 
                
                $route.reload();
        })
    }

    $scope.deleteMember = function(member) {
        
        console.log("deleting member: ", member);
        console.log("deleting member: ", $scope.getCookieData());
        var path = "member/" + member.member_id;
        Data.delete(path).then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Data from delete member: ", result);
                $scope.getMembers();
                $scope.saved();


            }else{
                console.log("Error deleting season: ", result);
                $scope.fail();

            } 
        }) 
        // $route.reload();  

    }


    $scope.addNewMember = function(member) {

        $scope.member_status.message = 'Logging in';
        $scope.member_status.disabled = true;
        $scope.member_status.show_alert = true;
        $scope.member_status.alert_type = 'info round';
        member.team_id = $scope.team.team_id;

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
        console.log("Creating Member for member: ", $scope.getCookieData());

        Data.post("member", member).then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Data from add member: ", result);
                $scope.saved();
                $scope.getMembers();
                $scope.modalInstance.dismiss('cancel');


            }else{
                console.log("Error adding member", result);
                $scope.member_status.message = 'Invaild form';
                $scope.member_status.disabled = false;
                $scope.member_status.alert_type = 'alert round';
                $scope.member_status.show_alert = true;
                $scope.fail();
                $scope.modalInstance.dismiss('cancel');
                
            } 

            $route.reload();

        }) 

    }

    /*
     * Function download members created by Martin Main in April 2016
     * to add download functionality to the page.
     */
    $scope.downloadMembers = function() {
        Data.get("members_all").then(function (teamMembers) {
            if(teamMembers.status != 'error'){
                console.log("Returned Members: ", teamMembers);
                var csvContent = "Member Id,FLL Team Number,Team Name,Team Organization,Email,First Name,Last Name,Civic Number,Street1,Street2,City,Province,Postal Code,Dob,Gender,Shirt Size,Guardian Name,Guardian Email,Guardian Phone,Medical Info,Consent\n";
                for (m in teamMembers) {
                    csvContent += teamMembers[m].member_id + ',' +
                    teamMembers[m].team_id + ',' +
                    teamMembers[m].name + ',' +
                    teamMembers[m].organization + ',' +
                    teamMembers[m].email + ',' +
                    teamMembers[m].first_name + ',' +
                    teamMembers[m].last_name + ',' +
                    teamMembers[m].civic_number + ',' +
                    teamMembers[m].street1 + ',' +
                    teamMembers[m].street2 + ',' +
                    teamMembers[m].city + ',' +
                    teamMembers[m].province + ',' +
                    teamMembers[m].postal_code + ',"' +
                    teamMembers[m].dob + '",' +
                    teamMembers[m].gender + ',' +
                    teamMembers[m].shirt_size + ',' +
                    teamMembers[m].guardian_name + ',' +
                    teamMembers[m].guardian_email + ',' +
                    teamMembers[m].guardian_phone + ',' +
                    teamMembers[m].medical_info + ',' +
                    teamMembers[m].consent + '\n';
                }

                var hiddenElement = document.createElement("a");
                hiddenElement.href = 'data:attachment/csv,' + encodeURI(csvContent);
                hiddenElement.target = '_blank';
                hiddenElement.download = 'members.csv';
                document.body.appendChild(hiddenElement);
                hiddenElement.click();
            }
        });
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
