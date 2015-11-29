var app = angular.module('myApp');


app.controller('volunteers_signup_controller', ['$scope', '$location', 'Data', 'NgTableParams', '$modal', '$cookies', '$route', function($scope, $location, Data, NgTableParams, $modal, $cookies, $route) {

  // $scope.check_logged_in();
  $scope.$watch('$invalid', function(validity) {})

  $scope.volunteer_status = {
      disabled: false,
      message: 'Invaild form',
      show_alert: false,
      alert_type: 'warning round'
  }
  $scope.season = {};

  $scope.qualifierSignup = {};

  $scope.volunteer_signup = {
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
      season_year: ''
      // affiliation: '',
      // position: ''
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
          }
      }) 
  }
  $scope.volunteerSignupEdit = $scope.volunteer_signup;
  // $scope.volunteer_signup.affiliation = "";
  // $scope.volunteerPositionsEdit = $scope.volunteer_signup;

  $scope.signupNewVolunteer = function(volunteer_signup, qual, pos) {
    $scope.volunteer_status.message = 'Logging in';
    $scope.volunteer_status.disabled = true;
    $scope.volunteer_status.show_alert = true;
    $scope.volunteer_status.alert_type = 'info round';
    volunteer_signup.season_year = $scope.season.year.year;


    if (typeof $scope.volunteer_signup.shirt_size.type != "undefined"){
        $scope.volunteer_signup.shirt_size = $scope.volunteer_signup.shirt_size.type;
        
    }else{
        $scope.volunteer_signup.shirt_size = $scope.volunteer_signup.shirt_size;

    }
    if (typeof $scope.volunteer_signup.province.type != "undefined"){
        $scope.volunteer_signup.province = $scope.volunteer_signup.province.type;
        
    }else{
        $scope.volunteer_signup.province = $scope.volunteer_signup.province;

    }
    if (typeof $scope.volunteer_signup.gender.type != "undefined"){
        $scope.volunteer_signup.gender = $scope.volunteer_signup.gender.type;
        
    }else{
        $scope.volunteer_signup.gender = $scope.volunteer_signup.gender;

    }
    if (typeof $scope.volunteer_signup.season_year.season_year != "undefined"){
        $scope.volunteer_signup.season_year = $scope.season.year.year;
        
    }else{
        $scope.volunteer_signup.season_year = $scope.volunteer_signup.season_year;

    }

    
    console.log("Creating Volunteer: ", pos,volunteer_signup);
    // console.log("Creating Member for member: ", $scope.getCookieData());
    var volunteerToPost = volunteer_signup;
    delete volunteerToPost.qualifier;
    Data.post("volunteer", volunteer_signup).then(function (result) {
        if(result.status != 'error'){
            console.log("Returned Data from add volunteer_signups: ", result);
            $scope.saved();
            // $scope.getMembers();


          $scope.part = {
              volunteer_id: parseInt(result.data),
              qual_id: qual.qual_id,
              competition_id: qual.competition_id,
              season_year: qual.season_year
          }
          $scope.part2 = {
              volunteer_id: parseInt(result.data),
              position_id: pos.position_id 
          }

          Data.post("helps", $scope.part).then(function (result) {
              if(result.status != 'error'){
                  console.log("Returned Data from add volunteer part: ", result);
                  $scope.saved();
              }else{

                  console.log("Error creating volunteer", result);
                  $scope.volunteer_status.message = 'Invaild form. Ensure volunteer doesnt exist';
                  $scope.volunteer_status.disabled = false;
                  $scope.volunteer_status.alert_type = 'alert round';
                  $scope.volunteer_status.show_alert = true;
                  $scope.fail();
                  
              } 
          })

          Data.post("volunteer_position", $scope.part2).then(function (result) {
              if(result.status != 'error'){
                  console.log("Returned Data from add volunteer part2: ", result);
                  $scope.saved();
              }else{
                  console.log("Error creating volunteer", result);
                  $scope.volunteer_status.message = 'Invaild form. Ensure volunteer doesnt exist';
                  $scope.volunteer_status.disabled = false;
                  $scope.volunteer_status.alert_type = 'alert round';
                  $scope.volunteer_status.show_alert = true;
                  $scope.fail();
                  
              } 
          }) 
        }else{
            console.log("Error adding volunteer_signup", result);
            $scope.volunteer_status.message = 'Invaild form';
            $scope.volunteer_status.disabled = false;
            $scope.volunteer_status.alert_type = 'alert round';
            $scope.volunteer_status.show_alert = true;
            $scope.fail();
            
        } 
        $location.path('/home');

        $route.reload();

    }) 
  }

 


  $scope.getVolunteerPositions = function(volunteer){
    Data.get("valid_volunteer_positions").then(function (result) {
          console.log("Returned volunteers participates: ", result);
      if(result.status != 'error'){
          $scope.volunteerPositions = result;
          data = $scope.volunteerPositions;
          // $scope.volunteerQualTableParams = new NgTableParams({count: 10}, { data: data, counts: []});
      }
    })

  }
  $scope.getVolunteerPositions();

}]);
