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
        if (logged_in()) {
            var auth = {
                headers: {
                    'Authorization': $cookies.getObject('login')["api_token"]
                }
            }
        }
        obj.get = function (q, auth) {
            console.log(auth)
            return $http.get(serviceBase + q, auth).then(function (results) {
                return results.data;
            });
        };
        obj.post = function (q, object, auth) {
            return $http.post(serviceBase + q, object, auth).then(function (results) {
                return results.data;
            });
        };
        obj.put = function (q, object, auth) {
            return $http.put(serviceBase + q, object, auth).then(function (results) {
      
                return results.data;
            });
        };
        obj.delete = function (q, auth) {
            return $http.delete(serviceBase + q, auth).then(function (results) {
                return results.data;
            });
        };

        
        obj.redirect = function(path) {
            $location.path(path);
        }

        return obj;
}]);
