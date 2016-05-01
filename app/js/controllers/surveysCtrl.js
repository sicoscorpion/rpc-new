var app = angular.module('myApp');


app.controller('surveys_controller', ['$scope', '$location', 'Data', 'NgTableParams', '$modal', '$cookies', '$route', '$timeout',
  function($scope, $location, Data, NgTableParams, $modal, $cookies, $route, $timeout) {

  $scope.tabs =[]
  Data.get('surveys_count/AudienceSurveys').then(function(result){
    $scope.tabs.push({
      title: 'Audience Survey',
      url: 'audience.html',
      info: result[0]['COUNT(*)'],
    })
  });
  Data.get('surveys_count/CoachSurveys').then(function(result){
    $scope.audienceSurveyCount = result[0]['COUNT(*)'];
    $scope.tabs.push({
      title: 'Coach Survey',
      url: 'coach.html',
      info: result[0]['COUNT(*)'],
    })
  });
  Data.get('surveys_count/StudentSurveys').then(function(result){
    $scope.audienceSurveyCount = result[0]['COUNT(*)'];
    $scope.tabs.push({
      title: 'Student Survey',
      url: 'student.html',
      info: result[0]['COUNT(*)'],
    })
  });
   Data.get('surveys_count/VolunteerSurveys').then(function(result){
    $scope.audienceSurveyCount = result[0]['COUNT(*)'];
    $scope.tabs.push({
      title: 'Volunteer Survey',
      url: 'volunteer.html',
      info: result[0]['COUNT(*)'],
    })
  });

  $scope.currentTab = 'audience.html';

  $scope.onClickTab = function (tab) {
    $scope.currentTab = tab.url;
  }

  $scope.isActiveTab = function(tabUrl) {
    return tabUrl == $scope.currentTab;
  }

  $scope.year = (new Date()).getFullYear();

  $scope.audience_survey = {
    year: $scope.year,
    town: '',
    heard_from: '',
    viewing_exp: '',
    hearing_exp: '',
    food_exp: '',
    venue_exp: '',
    displays_exp: '',
    return_next_year: '',
    overall_enjoyment: '',
    attendence_cause: '',
    comments: ''
  }

  $scope.coach_survey = {
    year: $scope.year,
    affiliation: '',
    paricipation_years: '',
    heard_from: '',
    cost: '',
    preperation_time: '',
    webpage_exp: '',
    learning_exp: '',
    interest_in_science: '',
    schedule_exp: '',
    food_exp: '',
    return_next_year: '',
    overall_enjoyment: '',
    most_liked: '',
    comments: ''
  }

  $scope.volunteer_survey = {
    year: $scope.year,
    affiliation: '',
    training_exp: '',
    webpage_exp: '',
    schedule_exp: '',
    food_exp: '',
    email_communication: '',
    communication_exp: '',
    overall_enjoyment: '',
    most_liked: '',
    comments: ''
  }

  $scope.student_survey = {
    year: $scope.year,
    affiliation: '',
    paricipation_years: '',
    gender: '',
    heard_from: '',
    changes_to_website: '',
    programming_learning_exp: '',
    teamwork_learning_exp: '',
    schedule_exp: '',
    food_exp: '',
    programming_interest_increase: '',
    science_interest_increase: '',
    science_carrer_consideration: '',
    return_next_year: '',
    overall_enjoyment: '',
    most_liked: '',
    comments: ''
  }

  $scope.audienceChoiceFields = [
    { name: 'I was able to view what was happening', key: 'viewing_exp'},
    { name: 'I was able to hear what was happening', key: 'hearing_exp'},
    { name: 'I enjoyed the food', key: 'food_exp'},
    { name: 'I enjoyed the venue', key: 'venue_exp'},
    { name: 'I enjoyed the displays', key: 'displays_exp'},
    { name: 'I hope to return next year', key: 'return_next_year'},
    { name: 'Overall, I enjoyed myself at the competitions', key: 'overall_enjoyment'},
  ];

  $scope.coachChoiceFields = [
    { name: 'The cost of the competition was appropriate', key: 'cost'},
    { name: 'Our team had enough time to prepare for the competition', key: 'preperation_time'},
    { name: 'The webpage (http://robots.acadiau.ca) was helpful', key: 'webpage_exp'},
    { name: 'My team learned a lot about building and programming the robot', key: 'learning_exp'},
    { name: 'Team members showed an increased interest in science and engineering', key: 'interest_in_science'},
    { name: 'The schedule of events was easy to understand & follow', key: 'schedule_exp'},
    { name: 'I enjoyed the food', key: 'food_exp'},
    { name: 'I would like to participate again next year', key: 'return_next_year'},
    { name: 'Overall, I enjoyed myself at the competitions', key: 'overall_enjoyment'},
  ];

  $scope.volunteerChoiceFields = [
    { name: 'The training session was helpful', key: 'training_exp'},
    { name: 'The webpage (http://robots.acadiau.ca) was helpful', key: 'webpage_exp'},
    { name: 'I was able to understand the schedule', key: 'schedule_exp'},
    { name: 'I enjoyed the food services', key: 'food_exp'},
    { name: 'I was given the appropriate amount of information via email', key: 'email_communication'},
    { name: 'Acadia Robotics communicated important information effectively', key: 'communication_exp'},
    { name: 'Overall, I enjoyed myself at the competitions', key: 'overall_enjoyment'},
  ];

  $scope.studentChoiceFields = [
    { name: 'I learned a lot about programming & building a robot', key: 'programming_learning_exp'},
    { name: 'I learned a lot about teamwork', key: 'teamwork_learning_exp'},
    { name: 'The schedule of events told me where I needed to be', key: 'schedule_exp'},
    { name: 'I enjoyed the food', key: 'food_exp'},
    { name: 'Because I was part of this team, I now have more interest in robot design and programming', key: 'programming_interest_increase'},
    { name: 'Because of this competition, I am interested in learning more about science & robot programming', key: 'science_interest_increase'},
    { name: 'Because of this competition, I am considering a career in the field of science, programming & robots', key: 'science_carrer_consideration'},
    { name: 'I am interested in returning to the Acadia Competition next year', key: 'return_next_year'},
    { name: 'Overall, I enjoyed myself at the competitions', key: 'overall_enjoyment'},
  ];



  $scope.saveSurvey = function(surveyType) {
    $scope.addSurvey = $scope[surveyType];
    Data.post(surveyType, $scope.addSurvey).then(function(result) {
      if(result.status != 'error'){
        $scope.saved();
      } else {
        console.log("Error: ", result);

        $scope.register_status.message = 'Saving Failed';
        $scope.register_status.disabled = false;
        $scope.register_status.alert_type = 'alert round';
        $scope.register_status.show_alert = true;
      }
      $route.reload();
    })
  }

  $scope.exportButtons = ['AudienceSurveys', 'CoachSurveys', 'VolunteerSurveys', 'StudentSurveys'];

}]);
