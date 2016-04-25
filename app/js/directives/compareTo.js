/*
 * File:        compareTo.js
 * Author:      James Walsh
 * Date:        Fall 2015
 * Purpose:     This file adds an angular directive to compare values
 *              in validation. This function is not being used as of
 *              April 2016. -MM
 */

var app = angular.module('myApp');

var compareTo = function() {
    return {
        require: "ngModel",
        scope: {
            otherModelValue: "=compareTo"
        },
        link: function(scope, element, attributes, ngModel) {
             
            ngModel.$validators.compareTo = function(modelValue) {
                return modelValue == scope.otherModelValue;
            };
 
            scope.$watch("otherModelValue", function() {
                ngModel.$validate();
            });
        }
    };
};
 
app.module.directive("compareTo", compareTo);