var app = angular.module('myApp', ['ngRoute', 'ngTable', 'ngCookies', 'mm.foundation', 'ui.select', 'ngMessages', '720kb.datepicker']);

app.config(['$routeProvider',
  function($routeProvider) {
    $routeProvider
    .when('/login', {
      title: 'Login',
      templateUrl: 'app/views/login.html',
      controller: 'login_controller'
    })
    .when('/signup', {
      title: 'Signup',
      templateUrl: 'app/views/signup.html',
      controller: 'login_controller'
    })
    .when('/seasons', {
      title: 'Seasons',
      templateUrl: 'app/views/seasons.html',
      controller: 'seasons_controller'
    })
    .when('/competitions', {
      title: 'Competitions',
      templateUrl: 'app/views/competitions.html',
      controller: 'competitions_controller'
    })
    .when('/qualifiers', {
      title: 'Qualifiers',
      templateUrl: 'app/views/qualifiers.html',
      controller: 'qualifiers_controller'
    })
    .when('/teams', {
      title: 'Teams',
      templateUrl: 'app/views/teams.html',
      controller: 'teams_controller'
    })
    .when('/home', {
      title: 'Home',
      templateUrl: 'app/views/home.html',
      controller: 'home_controller'
    })
    .when('/users', {
      title: 'Users',
      templateUrl: 'app/views/users.html',
      controller: 'users_controller'
    })
    .when('/volunteers', {
      title: 'Volunteers',
      templateUrl: 'app/views/volunteers.html',
      controller: 'volunteers_controller'
    })
    .when('/volunteers_signup', {
      title: 'Volunteers Signup',
      templateUrl: 'app/views/volunteers_signup.html',
      controller: 'volunteers_signup_controller'
    })
    .when('/profile', {
      title: 'Profile',
      templateUrl: 'app/views/profile.html',
      controller: 'profile_controller'
    })
    .when('/reset_password', {
      title: 'Password Reset',
      templateUrl: 'app/views/reset_password.html',
      controller: 'password_controller'
    })
    .when('/forgot_password', {
      title: 'Password Reset',
      templateUrl: 'app/views/forgot_password.html',
      controller: 'password_controller'
    })
    .when('/members', {
      title: 'Members',
      templateUrl: 'app/views/members.html',
      controller: 'members_controller'
    })
    .when('/contact', {
      title: 'Contact',
      templateUrl: 'app/views/contact.html',
      // controller: 'contact_controller'
    })


    .otherwise({redirectTo:'/home'});
}]);

