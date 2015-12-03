var app = angular.module('myApp');

app.factory("Data", ['$http', '$location', '$cookies', '$route', function ($http,  $location, $cookies, $route) {

        var serviceBase = 'api/v1/';
        var loginCookie = 'login';
        var obj = {};
        
        var logged_in = function() {
            if (typeof $cookies.getObject(loginCookie) != "undefined")
                if ($cookies.getObject(loginCookie).username != "undefined") 
                    return true;
            return false;
        }
        console.log(logged_in());
        var getAuth = function () {
            var auth = {};
            if (logged_in()) {
                var auth = {
                    headers: {
                        'Authorization': $cookies.getObject('login')["api_token"]
                    }
                }

            } 
            return auth;
        }
        obj.get = function (q) {
            return $http.get(serviceBase + q, getAuth()).then(function (results) {
                console.log(getAuth())
                return results.data;
            });
        };
        obj.post = function (q, object) {
            return $http.post(serviceBase + q, object, getAuth()).then(function (results) {
                return results.data;
            });
        };
        obj.put = function (q, object) {
            return $http.put(serviceBase + q, object, getAuth()).then(function (results) {
      
                return results.data;
            });
        };
        obj.delete = function (q) {
            return $http.delete(serviceBase + q, getAuth()).then(function (results) {
                return results.data;
            });
        };

        
        obj.redirect = function(path) {
            $location.path(path);
        }

        return obj;
}]);
