var app = angular.module('myApp');


app.controller('teams_controller', ['$scope', '$location', 'Data', 'NgTableParams', '$modal', '$cookies', '$route', '$timeout', function($scope, $location, Data, NgTableParams, $modal, $cookies, $route, $timeout) {

    $scope.check_logged_in();

    $scope.team = {
        team_id: '',
        name: '',
        organization: '',
        approved: ''
    }



    $scope.team_status = {
        disabled: false,
        message: 'Invaild form. Ensure team doesnt exist',
        show_alert: false,
        alert_type: 'warning round'
    }

console.log("is admin: ", $scope.isAdmin());

    if ($scope.isAdmin()){
        Data.get("teams").then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Teams for Admin: ", result);
                $scope.teams = result;
                data = $scope.teams;
                $scope.teamTableParams = new NgTableParams({count: 10}, { data: data, counts: []});
            }
        })
    }
    else if ($scope.isCoach()){
        Data.get("manage/teams/" + $scope.getCookieData().user_id).then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Teams for coach: ", result);
                $scope.teams = result;
                data = $scope.teams;
                $scope.teamTableParams = new NgTableParams({count: 10}, { data: data, counts: []});
            }
        })
    }

    $scope.getTeams = function(){
        Data.get("teams").then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Teams for Admin: ", result);
                $scope.teams = result;
                data = $scope.teams;
                $scope.teamTableParams = new NgTableParams({count: 10}, { data: data, counts: []});
            }
        })
    }

    $scope.getTeamsForQual = function(qual_id, qual){
        Data.get("teams/" + qual_id).then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Teams for qual admin: ", result);
                $scope.teams = result;
                data = $scope.teams;
                $scope.teamTableParams = new NgTableParams({count: 10}, { data: data, counts: []});
            
                if (typeof qual != 'undefined'){
                    console.log("Qualifier shit: ", $scope.teams.length, qual.capacity);
                   if ($scope.teams.length === qual.capacity){
                        console.log("Qualifier full, closing qualifier", qual);
                        qual.status = "closed";
                        console.log("Qualifier full, closing qualifier", qual);
                        $scope.updateQual(qual);
                   } 
                }
            }
        })
    }

    $scope.updateQual = function(qual) {

        console.log("Updating Qualifiers: ", qual);
        console.log("Updating Qualifiers for user: ", $scope.getCookieData());
        var path = "qualifiers/" + qual.qual_id;
        Data.put(path, qual).then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Data from edit qual: ", result);
                $scope.saved();

            }else{
                console.log("Error saving qual", result);
                $scope.fail();

            } 
        }) 

    }

    $scope.getTeamsParticipate = function(team){
        Data.get("teams/participate/" + team.team_id).then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Teams participates: ", result);
                $scope.participates = result;
                data = $scope.participates;
                $scope.teamPartTableParams = new NgTableParams({count: 10}, { data: data, counts: []});
            }
        })
    }

    $scope.getTeamsCoaches = function(team){
        Data.get("manage/users/" + team.team_id).then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Teams coaches: ", result);
                $scope.coaches = result;
                data = $scope.coaches;
                $scope.teamCoachTableParams = new NgTableParams({count: 10}, { data: data, counts: []});
            }
        })
    }

    $scope.createTeam = function(team) {

        $scope.team_status.message = 'Logging in';
        $scope.team_status.disabled = true;
        $scope.team_status.show_alert = true;
        $scope.team_status.alert_type = 'info round';

        
        console.log("Creating Team: ", team);
        console.log("Creating Team for user: ", $scope.getCookieData());

        Data.post("teams", team).then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Data from create team: ", result);
                $scope.saved();
                $scope.getTeams();
                $scope.modalInstance.dismiss('cancel');
                if ($scope.isCoach()){
                    $scope.addTeamCoach(team, $scope.getCookieData());
                }
                $route.reload();


            }else{
                console.log("Error creating team", result);
                $scope.team_status.message = 'Invaild form. Ensure team doesnt exist';
                $scope.team_status.disabled = false;
                $scope.team_status.alert_type = 'alert round';
                $scope.team_status.show_alert = true;
                $scope.fail();
                $scope.modalInstance.dismiss('cancel');
                
            } 
        }) 



    }


    $scope.setQual = function(qualifier){
        console.log("Setting Qual: ", qualifier);

        $scope.qualForTeam = qualifier;
    }

    $scope.setCoach = function(coach){
        console.log("Setting coach: ", coach);

        $scope.coachForTeam = coach;
    }

    $scope.addTeamQual = function(team, qual) {

        console.log("Team: ", team);
        console.log("Qual: ", qual);

        $scope.part = {
            team_id: team.team_id,
            qual_id: qual.qual_id,
            competition_id: qual.competition_id,
            season_year: qual.season_year
        }

        $scope.team_status.message = 'Logging in';
        $scope.team_status.disabled = true;
        $scope.team_status.show_alert = true;
        $scope.team_status.alert_type = 'info round';

        
        console.log("Adding Team qual: ", team);
        console.log("Adding Team for user: ", $scope.getCookieData());

        Data.post("teams/participate", $scope.part).then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Data from add team part: ", result);
                $scope.saved();
                $route.reload();
                $scope.modalInstance.dismiss('cancel');

                $scope.getTeamsForQual(qual.qual_id, qual)


            }else{
                $scope.modalInstance.dismiss('cancel');

                console.log("Error creating team", result);
                $scope.team_status.message = 'Invaild form. Ensure team doesnt exist';
                $scope.team_status.disabled = false;
                $scope.team_status.alert_type = 'alert round';
                $scope.team_status.show_alert = true;
                $scope.fail();
                
            } 
        }) 

    }

    $scope.addTeamCoach = function(team, coach) {

        console.log("Team: ", team);
        console.log("coach: ", coach);

        $scope.part = {
            team_id: team.team_id,
            user_id: coach.user_id
        }

        $scope.team_status.message = 'Logging in';
        $scope.team_status.disabled = true;
        $scope.team_status.show_alert = true;
        $scope.team_status.alert_type = 'info round';

        
        console.log("Adding Team coach: ", team);
        console.log("Adding Team for user: ", $scope.getCookieData());

        Data.post("/manage", $scope.part).then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Data from add team coach: ", result);
                $scope.saved();
                $route.reload();
                $scope.modalInstance.dismiss('cancel');

            }else{
                $scope.modalInstance.dismiss('cancel');

                console.log("Error creating team", result);
                $scope.team_status.message = 'Invaild form. Ensure team doesnt exist';
                $scope.team_status.disabled = false;
                $scope.team_status.alert_type = 'alert round';
                $scope.team_status.show_alert = true;
                $scope.fail();
                
            } 
        }) 

    }

    $scope.deleteTeamPart = function(team) {
        
        console.log("deleting part : ", team);
        var path = "teams/participate/" + team.team_id + "/" + team.qual_id + "/" + team.competition_id + "/" + team.season_year;
        Data.delete(path).then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Data from delete team part: ", result);
                $scope.saved();
                $route.reload();
                $scope.modalInstance.dismiss('cancel');


            }else{
                console.log("Error deleting team part: ", result);
                $scope.fail();

            } 
        }) 
        // $route.reload();  

    }

    $scope.deleteTeamCoach = function(team, coach) {
        
        console.log("deleting coach : ", coach);
        var path = "manage/" + team.team_id + "/" + coach.user_id;
        Data.delete(path).then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Data from delete team part: ", result);
                $scope.saved();
                $route.reload();
                $scope.modalInstance.dismiss('cancel');


            }else{
                console.log("Error deleting team part: ", result);
                $scope.fail();

            } 
        }) 
        // $route.reload();  

    }

    $scope.editTeam = function(team) {
        
        console.log("Updating Team: ", team);
        console.log("Updating Team for user: ", $scope.getCookieData());
        var path = "teams/" + team.team_id;

        delete team.user_id;
        delete team.qual_id;
        delete team.competition_id;
        delete team.season_year;
        delete team.local_id;

        Data.put(path, team).then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Data from edit team: ", result);
                $scope.saved();
                $route.reload();
                
            }else{
                console.log("Error saving team", result);
                $scope.fail();

            } 
            
            // $route.reload();  

        }) 

    }


            // MODAL WINDOW
    $scope.openTeams = function () {
        console.log("Open Team Modal");


        $scope.modalInstance = $modal.open({
          controller: "teams_controller",
          templateUrl: 'newTeam.html',
          scope: $scope,
          resolve: {
                team: function()
                {
                    return $scope;
                }
            }

        });
    };


            // MODAL WINDOW
    $scope.updateTeamQual = function (team) {
        console.log("Open TeamQual Modal");
        $scope.t = team;
        $scope.getTeamsParticipate(team);

        $scope.modalInstance = $modal.open({
          controller: "teams_controller",
          templateUrl: 'teamQuals.html',
          scope: $scope,
          resolve: {
                teamQual: function()
                {
                    return $scope;
                }
            }

        });
    };


            // MODAL WINDOW
    $scope.updateTeamCoach = function (team) {
        console.log("Open Team Coach Modal");
        $scope.t = team;
        $scope.getTeamsCoaches(team);

        $scope.modalInstance = $modal.open({
          controller: "teams_controller",
          templateUrl: 'teamCoach.html',
          scope: $scope,
          resolve: {
                teamCoach: function()
                {
                    return $scope;
                }
            }

        });
    };



}]);
