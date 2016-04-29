var app = angular.module('myApp');


app.controller('teams_controller', ['$scope', '$location', 'Data', 'NgTableParams', '$modal', '$cookies', '$route', '$timeout', function($scope, $location, Data, NgTableParams, $modal, $cookies, $route, $timeout) {

    $scope.check_logged_in();

    $scope.team = {
        team_id: '',
        name: '',
        organization: '',
        approved: ''
    };

    $scope.year = "All";
    $scope.download_label = "All";
    $scope.qual_id = "All";

    $scope.team_status = {
        disabled: false,
        message: 'Invaild form. Ensure team doesnt exist',
        show_alert: false,
        alert_type: 'warning round'
    };

console.log("is admin: ", $scope.isAdmin());

    if ($scope.isAdmin()){
        Data.get("teams").then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Teams for Admin: ", result);
                $scope.teams = result;
                data = $scope.teams;
                $scope.teamTableParams = new NgTableParams({count: 10}, { data: data , counts: []});
            }
        });

        Data.get("seasons").then(function (result) {
            if(result.status != 'error'){
                console.log("Returned seasons: ", result);
                result.unshift({year : "All"});
                $scope.seasons = result;
                //data = $scope.seasons;
                // $scope.teamTableParams = new NgTableParams({count: 10}, { data: data, counts: [1, 25, 50, 100]});
            }
        });
    }
    else if ($scope.isCoach()){
        Data.get("manage/teams/" + $scope.getCookieData().user_id).then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Teams for coach: ", result);
                $scope.teams = result;
                data = $scope.teams;
                $scope.teamTableParams = new NgTableParams({count: 10}, { data: data , counts: []});
            }
        });
    } else if ($scope.isQualAdmin()){
        Data.get("host/qualifiers/" + $cookies.getObject("login").user_id).then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Qualifiers for qual admin: ", result);
                result.unshift({qual_id : "All", name: "All"});
                $scope.qualifiers = result;
            }
        });
    }

    $scope.processTeams = function(result) {
        if(result.status != 'error'){
            console.log("Returned Teams for Admin: ", result);
            $scope.teams = result;
            data = $scope.teams;
            $scope.teamTableParams = new NgTableParams({count: 10},{ data: data , counts: []});
        }
    };

    $scope.getTeams = function(){
        Data.get("teams").then(function (result) {$scope.processTeams(result);});
    };

    $scope.getTeamsForQual = function(qual_id, qual){
        if (qual_id == "All") {
            Data.get("teams_from_qual_admin/" + $cookies.getObject("login").user_id).then(function (result) {
                $scope.processTeams(result);
                $scope.download_label = qual_id;
                $scope.qual_id = qual_id;
            });
        } else {
            Data.get("teams/" + qual_id).then(function (result) {
                $scope.processTeams(result);
                if (typeof qual != 'undefined'){
                    console.log("Qualifier shit: ", $scope.teams.length, qual.capacity);
                   if ($scope.teams.length === qual.capacity){
                        console.log("Qualifier full, closing qualifier", qual);
                        qual.status = "closed";
                        console.log("Qualifier full, closing qualifier", qual);
                        $scope.updateQual(qual);
                   }
                }
                pos = $scope.qualifiers.map(function(e) { return e.qual_id; }).indexOf(qual_id);
                $scope.download_label = $scope.qualifiers[pos].name;
                $scope.qual_id = qual_id;
            });
        }
    };


    // Function made by Martin main for querying teams by season      
    $scope.getTeamsForSeason = function(year){
        $scope.year = year;
        if ($scope.isAdmin()) $scope.download_label = year;
        if (year == "All") {
            $scope.getTeams();
        }
        else {
            Data.get("teams_from_season/" + year).then(function (result) {$scope.processTeams(result);});
        }
    };

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
        });

    };

    $scope.getTeamsParticipate = function(team){
        Data.get("teams/participate/" + team.team_id).then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Teams participates: ", result);
                $scope.participates = result;
                data = $scope.participates;
                $scope.teamPartTableParams = new NgTableParams({count: 10}, { data: data});
            }
        });
    };

    $scope.getTeamsCoaches = function(team){
        Data.get("manage/users/" + team.team_id).then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Teams coaches: ", result);
                $scope.coaches = result;
                data = $scope.coaches;
                $scope.teamCoachTableParams = new NgTableParams({count: 10}, { data: data});
            }
        });
    };

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
        });
    };


    $scope.setQual = function(qualifier){
        console.log("Setting Qual: ", qualifier);

        $scope.qualForTeam = qualifier;
    };

    $scope.setCoach = function(coach){
        console.log("Setting coach: ", coach);

        $scope.coachForTeam = coach;
    };

    $scope.addTeamQual = function(team, qual) {

        console.log("Team: ", team);
        console.log("Qual: ", qual);

        $scope.part = {
            team_id: team.team_id,
            qual_id: qual.qual_id,
            competition_id: qual.competition_id,
            season_year: qual.season_year
        };

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

                $scope.getTeamsForQual(qual.qual_id, qual);


            }else{
                $scope.modalInstance.dismiss('cancel');

                console.log("Error creating team", result);
                $scope.team_status.message = 'Invaild form. Ensure team doesnt exist';
                $scope.team_status.disabled = false;
                $scope.team_status.alert_type = 'alert round';
                $scope.team_status.show_alert = true;
                $scope.fail();
                
            }
        });

    };

    $scope.addTeamCoach = function(team, coach) {

        console.log("Team: ", team);
        console.log("coach: ", coach);

        $scope.part = {
            team_id: team.team_id,
            user_id: coach.user_id
        };

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
        });

    };

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
        });
        // $route.reload();  

    };

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
        });
        // $route.reload();  

    };

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

        });

    };


    function processCSV(result) {
        if(result.status != 'error'){
            console.log("Returned Teams: ", result);
            cleanup(result);

            var csvContent = "FLL ID,Team Name,Organization,Approved,Coach ID, Coach Name, Qualifier ID, Qualifier Name\n";
            var row;
            for (row in result) {
                csvContent += result[row].team_id + ',' +
                result[row].name + ',' +
                result[row].organization + ',' +
                result[row].approved + ',' +
                result[row].user_id + ',' +
                result[row].first_name + ' ' + result[row].last_name + ',' +
                result[row].qual_id + ',' +
                result[row].qual_name + '\n';
            }
            
            // Downloads content
            downloadCSV('teams.csv', csvContent);
        }
    }

    /*
     * Function download teams created by Martin Main in April 2016
     * to add download functionality to the page.
     */
    $scope.downloadTeams = function() {
        if ($scope.isAdmin()) {
            if ($scope.year == "All") {
                Data.get("teams_with_coaches").then(function (result) {processCSV(result);});
            } else {
                Data.get("teams_with_coaches_w_season/" + $scope.year).then(function (result) {processCSV(result);});
            }
        } else if ($scope.isQualAdmin()) {
            if ($scope.qual_id == "All") {
                Data.get("teams_from_qual_admin_w_coaches/" + $scope.getCookieData().user_id).then(function (result) {processCSV(result);});
            } else {
                Data.get("teams_with_coaches/" + $scope.qual_id).then(function (result) {processCSV(result);});
            }
        }
    };


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
