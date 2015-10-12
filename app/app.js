var app = angular.module('myApp', ['ngRoute', 'ngTable', 'ngCookies', 'mm.foundation', 'ui.select']);

app.config(['$routeProvider',
  function($routeProvider) {
    $routeProvider.
    when('/login', {
      title: 'Login',
      templateUrl: 'app/views/login.html',
      controller: 'loginCtrl'
    })
    .otherwise({
      redirectTo: '/login'
    });
}]);
    