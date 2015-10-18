var app = angular.module('myApp');


app.controller('topbar_controller', ['$scope', '$location', function($scope, $location) {

    // $scope.check_logged_in();

    $scope.getActive = function (path) {
      if ($location.path() === path) {
        return 'content active';
      } else {
        return 'content';
      }
    }

    $scope.getLogged_in = function (){
      return $scope.logged_in;
    }

}]);
