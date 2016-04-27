var app = angular.module('myApp');


app.controller('volunteers_controller', ['$scope', '$location', 'Data', 'NgTableParams', '$modal', '$cookies', '$route', function($scope, $location, Data, NgTableParams, $modal, $cookies, $route) {

  $scope.check_logged_in();
  $scope.$watch('$invalid', function(validity) {})

  $scope.volunteer_status = {
      disabled: false,
      message: 'Invaild form',
      show_alert: false,
      alert_type: 'warning round'
  }
  $scope.season = {};

  $scope.qualifierSignup = {};
  $scope.volunteer = {
      first_name: '',
      last_name: '',
      email: '',
      civic_number: '',
      street1: '',
      street2: '',
      city: '',
      province: '',
      postal_code: '',
      dob: '',
      gender: '',
      medical_info: '',
      shirt_size: '',
      consent: '',
      season_year: '',
  }

  Data.get("seasons").then(function (result) {
      if(result.status != 'error'){
          console.log("Returned seasons: ", result);
          $scope.seasons = result;
          data = $scope.seasons;
          // $scope.teamTableParams = new NgTableParams({count: 10}, { data: data, counts: [1, 25, 50, 100]});
      }
  })


  $scope.setAffiliation = function (aff){

      $scope.volunteer.position.affiliation = aff;
  }

  $scope.getVolunteers = function (season_year){
      console.log("Selecting for", season_year);

      Data.get("volunteers/"+ season_year).then(function (result) {
          if(result.status != 'error'){
              console.log("Returned Volunteers: ", result);
              $scope.volunteers = result;
              data = $scope.volunteers;
              $scope.volunteersTableParams = new NgTableParams({count: 10}, { data: data, counts: []});
              $scope.season = season_year;
          }
      }) 
  }


  $scope.addNewVolunteer = function(volunteer) {

      $scope.volunteer_status.message = 'Logging in';
      $scope.volunteer_status.disabled = true;
      $scope.volunteer_status.show_alert = true;
      $scope.volunteer_status.alert_type = 'info round';
      volunteer.season_year = $scope.season;


      if (typeof $scope.volunteer.shirt_size.type != "undefined"){
          $scope.volunteer.shirt_size = $scope.volunteer.shirt_size.type;
          
      }else{
          $scope.volunteer.shirt_size = $scope.volunteer.shirt_size;

      }
      if (typeof $scope.volunteer.province.type != "undefined"){
          $scope.volunteer.province = $scope.volunteer.province.type;
          
      }else{
          $scope.volunteer.province = $scope.volunteer.province;

      }
      if (typeof $scope.volunteer.gender.type != "undefined"){
          $scope.volunteer.gender = $scope.volunteer.gender.type;
          
      }else{
          $scope.volunteer.gender = $scope.volunteer.gender;

      }
      if (typeof $scope.volunteer.season_year.season_year != "undefined"){
          $scope.volunteer.season_year = $scope.season;
          
      }else{
          $scope.volunteer.season_year = $scope.volunteer.season_year;

      }

      
      console.log("Creating Volunteer: ", volunteer);
      // console.log("Creating Member for member: ", $scope.getCookieData());

      Data.post("volunteer", volunteer).then(function (result) {
          if(result.status != 'error'){
              console.log("Returned Data from add volunteers: ", result);
              $scope.saved();
              // $scope.getMembers();
              $scope.modalInstance.dismiss('cancel');


          }else{
              console.log("Error adding volunteer", result);
              $scope.volunteer_status.message = 'Invaild form';
              $scope.volunteer_status.disabled = false;
              $scope.volunteer_status.alert_type = 'alert round';
              $scope.volunteer_status.show_alert = true;
              $scope.fail();
              $scope.modalInstance.dismiss('cancel');
              
          } 

          $route.reload();

      }) 
  }

  $scope.updateVolunteer = function(volunteer) {

    if (typeof volunteer.gender.type != "undefined"){
        volunteer.gender = volunteer.gender.type;
        
    }else{
        volunteer.gender = volunteer.gender;

    }
    if (typeof volunteer.shirt_size.type != "undefined"){
        volunteer.shirt_size = volunteer.shirt_size.type;
        
    }else{
        volunteer.shirt_size = volunteer.shirt_size;
    }

    console.log("Updating volunteer: ", volunteer);
    console.log("Updating volunteer for volunteer: ", $scope.getCookieData());

    $scope.addVolunteer = {
        first_name: volunteer.first_name,
        last_name: volunteer.last_name,
        email: volunteer.email,
        dob: volunteer.dob,
        civic_number: volunteer.civic_number,
        street1: volunteer.street1,
        street2: volunteer.street2,
        city: volunteer.city,
        province: volunteer.province,
        postal_code: volunteer.postal_code,
        medical_info: volunteer.medical_info,
        shirt_size: volunteer.shirt_size,
        phone: volunteer.guardian_phone,
        gender: volunteer.gender
    }

    var path = "volunteer/" + volunteer.volunteer_id;
    console.log("Edit Volunteer: ", $scope.addVolunteer);
    Data.put(path, $scope.addVolunteer).then(function (result) {
        if(result.status != 'error'){
            console.log("Returned Data from edit Volunteer: ", result);
            console.log("Editing Volunteer: ", $scope.addVolunteer);
            $scope.saved();

        }else{
            console.log("Error: ", result);

            $scope.fail();

        } 
        $scope.modalInstance.dismiss('cancel');
        
        $route.reload();
      })
  }


  $scope.getVolunteersQualifiers = function(volunteer){
    Data.get("helps/" + volunteer.volunteer_id).then(function (result) {
      if(result.status != 'error'){
          console.log("Returned volunteers participates: ", result);
          $scope.participates = result;
          data = $scope.participates;
          $scope.volunteerQualTableParams = new NgTableParams({count: 10}, { data: data, counts: [10, 20, 30]});
      }
    })
  }

  $scope.getVolunteerPositions = function(volunteer){
    Data.get("valid_volunteer_positions").then(function (result) {
          console.log("Returned volunteers participates: ", result);
      if(result.status != 'error'){
          $scope.volunteerPositions = result;
          data = $scope.volunteerPositions;
          // $scope.volunteerPositionsTableParams = new NgTableParams({count: 10}, { data: data, counts: []});
      }
    })
  }
  $scope.getVolunteerPositions();
  $scope.getHasPositions = function(volunteer){
    Data.get("volunteer_positions/" + volunteer.volunteer_id).then(function (result) {
      if(result.status != 'error'){
          console.log("Returned volunteers participates: ", result);
          $scope.cVolunteerPositions = result;
          data = $scope.cVolunteerPositions;
          $scope.volunteerPosTableParams = new NgTableParams({count: 10}, { data: data, counts: []});
      }
    })
  }

  $scope.addVolunteerToQualifier = function(volunteer, qual) {

    console.log("Volunteer: ", volunteer);
    console.log("Qual: ", qual);

    $scope.part = {
        volunteer_id: volunteer.volunteer_id,
        qual_id: qual.qual_id,
        competition_id: qual.competition_id,
        season_year: qual.season_year
    }

    $scope.volunteer_status.message = 'Logging in';
    $scope.volunteer_status.disabled = true;
    $scope.volunteer_status.show_alert = true;
    $scope.volunteer_status.alert_type = 'info round';

    
    console.log("Adding Volunteer qual: ", volunteer);
    console.log("Adding Volunteer for user: ", $scope.getCookieData());

    Data.post("helps", $scope.part).then(function (result) {
        if(result.status != 'error'){
            console.log("Returned Data from add volunteer part: ", result);
            $scope.saved();
            $route.reload();
            $scope.modalInstance.dismiss('cancel');

            $scope.getVolunteers(qual.season_year);


        }else{
            $scope.modalInstance.dismiss('cancel');

            console.log("Error creating volunteer", result);
            $scope.volunteer_status.message = 'Invaild form. Ensure volunteer doesnt exist';
            $scope.volunteer_status.disabled = false;
            $scope.volunteer_status.alert_type = 'alert round';
            $scope.volunteer_status.show_alert = true;
            $scope.fail();
            
        } 
    }) 

  }
  $scope.addVolunteerPositition = function(volunteer, position) {

    console.log("Volunteer: ", volunteer);
    console.log("position: ", position);

    $scope.part = {
        volunteer_id: volunteer.volunteer_id,
        position_id: position.position_id 
    }

    $scope.volunteer_status.message = 'Logging in';
    $scope.volunteer_status.disabled = true;
    $scope.volunteer_status.show_alert = true;
    $scope.volunteer_status.alert_type = 'info round';

    

    Data.post("volunteer_position", $scope.part).then(function (result) {
        if(result.status != 'error'){
            console.log("Returned Data from add volunteer part: ", result);
            $scope.saved();
            $route.reload();
            $scope.modalInstance.dismiss('cancel');

            $scope.getVolunteers(qual.season_year);


        }else{
            $scope.modalInstance.dismiss('cancel');

            console.log("Error creating volunteer", result);
            $scope.volunteer_status.message = 'Invaild form. Ensure volunteer doesnt exist';
            $scope.volunteer_status.disabled = false;
            $scope.volunteer_status.alert_type = 'alert round';
            $scope.volunteer_status.show_alert = true;
            $scope.fail();
            
        } 
    }) 

  }

  $scope.deleteVolunteerQual = function(record) {
        
    console.log("deleting part : ", record);
    var path = "helps/" + record.qual_id + "/" + record.volunteer_id;
    Data.delete(path).then(function (result) {
        if(result.status != 'error'){
            console.log("Returned Data from delete record part: ", result);
            $scope.saved();
            $route.reload();
            $scope.modalInstance.dismiss('cancel');


        }else{
            console.log("Error deleting record part: ", result);
            $scope.fail();

        } 
    }) 
    // $route.reload();  

  }
  $scope.deleteVolunteerPosition = function(record) {
        
    console.log("deleting part : ", record);
    var path = "volunteer_position/" + record.position_id + "/" + record.volunteer_id;
    Data.delete(path).then(function (result) {
        if(result.status != 'error'){
            console.log("Returned Data from delete record part: ", result);
            $scope.saved();
            $route.reload();
            $scope.modalInstance.dismiss('cancel');


        }else{
            console.log("Error deleting record part: ", result);
            $scope.fail();

        } 
    }) 
    // $route.reload();  

  }
  $scope.deleteVolunteer = function(record) {
        
    console.log("deleting part : ", record);
    var path = "volunteer/" + record.volunteer_id;
    Data.delete(path).then(function (result) {
        if(result.status != 'error'){
            console.log("Returned Data from delete record part: ", result);
            $scope.saved();
            $route.reload();
            $scope.modalInstance.dismiss('cancel');


        }else{
            console.log("Error deleting record part: ", result);
            $scope.fail();

        } 
    }) 
    // $route.reload();  

  }

  // MODAL WINDOW
  $scope.openVolunteers = function () {
      console.log("Open add volunteer Modal");

      $scope.modalInstance = $modal.open({
        controller: "volunteers_controller",
        templateUrl: 'volunteerAdd.html',
        scope: $scope,
        resolve: {
              volunteer: function()
              {
                  return $scope;
              }
          }

      });
  };
  $scope.openProfile = function (volunteer) {

      console.log("Volunteer Profile: ", volunteer);
      $scope.volunteerEdit = volunteer;
      $scope.modalInstance = $modal.open({
        controller: "volunteers_controller",
        templateUrl: 'volunteer_profile.html',
        scope: $scope,
          resolve: {
              volunteer: function()
              {
                  return $scope;
              }
          }
      });
  };
  $scope.openVolunteerSignup = function (volunteer) {

      console.log("Volunteer Profile: ", volunteer);
      $scope.volunteerSignupEdit = volunteer;
      $scope.getVolunteersQualifiers(volunteer);

      $scope.modalInstance = $modal.open({
        controller: "volunteers_controller",
        templateUrl: 'volunteer_signup.html',
        scope: $scope,
          resolve: {
              volunteer: function()
              {
                  return $scope;
              }
          }
      });
  };

  $scope.openVolunteerPositions = function (volunteer) {

      console.log("Volunteer Profile: ", volunteer);
      volunteer.affiliation = "";

      $scope.volunteerPositionsEdit = volunteer;
      $scope.getVolunteerPositions(volunteer);
      $scope.getHasPositions(volunteer)
      $scope.modalInstance = $modal.open({
        controller: "volunteers_controller",
        templateUrl: 'volunteer_positions.html',
        scope: $scope,
          resolve: {
              volunteer: function()
              {
                  return $scope;
              }
          }
      });
  };

    /*
     * Function download volunteers created by Martin Main in April 2016
     * to add download functionality to the page.
     */
    $scope.downloadVolunteers = function() {
        Data.get("volunteers/" + $scope.season).then(function (result) {
            if(result.status != 'error'){
                console.log("Returned Volunteers: ", result);
                var csvContent = "Volunteer Id,Email,First Name,Last Name,Phone,Civic Number,Street1,Street2,City,Province,Postal Code,Dob,Gender,Medical Info,Shirt Size,Consent,Season Year\n";
                for (row in result) {
                    csvContent += result[row].volunteer_id + ',' +
                    result[row].email + ',' +
                    result[row].first_name + ',' +
                    result[row].last_name + ',' +
                    result[row].phone + ',' +
                    result[row].civic_number + ',' +
                    result[row].street1 + ',' +
                    result[row].street2 + ',' +
                    result[row].city + ',' +
                    result[row].province + ',' +
                    result[row].postal_code + ',"' +
                    result[row].dob + '",' +
                    result[row].gender + ',' +
                    result[row].medical_info + ',' +
                    result[row].shirt_size + ',' +
                    result[row].consent + ',' +
                    result[row].season_year + '\n';
                }

                var hiddenElement = document.createElement("a");
                hiddenElement.href = 'data:attachment/csv,' + encodeURI(csvContent);
                hiddenElement.target = '_blank';
                hiddenElement.download = 'volunteers.csv';
                document.body.appendChild(hiddenElement);
                hiddenElement.click();
            }
        })
    }

}]);
