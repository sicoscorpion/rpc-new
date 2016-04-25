/*
 * File:        checkPostal.js
 * Author:      James Walsh
 * Date:        Fall 2015
 * Purpose:     This file adds an angular directive that handles basic postal
 *              code validation. As of April 2016 this function is not being
 *              used. -MM
 */

var app = angular.module('myApp');

app.directive('checkPostal', function() {
        return {
            restrict: 'A',
            require: 'ngModel',
            link: function(scope, elem, attr, ngModel) {
                ngModel.$validators.postalcode = function(val) {
                    var regexp = /^[ABCEFGHJKLMNPRSTVXY][0-9][ABCEFGHJKLMNPRSTVWXYZ] ?[0-9][ABCEFGHJKLMNPRSTVWXYZ][0-9]$/i;
                    if (val) {
                        return regexp.test(val);
                    }
                    else {
                        return true;
                    }
                };
            }
        };
    })