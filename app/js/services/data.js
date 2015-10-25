var app = angular.module('myApp');

app.factory("Data", ['$http', '$location', '$cookies', '$route', function ($http, $q, $location, $cookies, $route) {

        var serviceBase = 'api/v1/';
        var loginCookie = 'login';
        var obj = {};

        obj.get = function (q, head) {
            return $http.get(serviceBase + q, head).then(function (results) {
                return results.data;
            });
        };
        obj.post = function (q, object) {
            return $http.post(serviceBase + q, object).then(function (results) {
                return results.data;
            });
        };
        obj.put = function (q, object) {
            return $http.put(serviceBase + q, object).then(function (results) {
      
                return results.data;
            });
        };
        obj.delete = function (q) {
            return $http.delete(serviceBase + q).then(function (results) {
                return results.data;
            });
        };

        
        obj.redirect = function(path) {
            $location.path(path);
        }

        return obj;
}]);
