/*
 * File:        confirmation_needed.js
 * Author:      James Walsh
 * Date:        Fall 2015
 * Purpose:     This file is not being used as of April 2016. -MM
 * 
 */

var app = angular.module('myApp');

app.directive('confirmationNeeded', function () {
  return {
    priority: 1,
    terminal: true,
    link: function (scope, element, attr) {
      var msg = attr.confirmationNeeded || "Are you sure?";
      var clickAction = attr.ngClick;
      element.bind('click',function () {
        if ( window.confirm(msg) ) {
          scope.$eval(clickAction)
        }
      });
    }
  };
});
app.directive('confirmationSent', function () {
  return {
    priority: 1,
    terminal: true,
    link: function (scope, element, attr) {
      var msg = attr.confirmationSent || "Reset Password Email Sent .. Please Check your email inbox";
      var clickAction = attr.ngClick;
      element.bind('click',function () {
        if ( window.confirm(msg) ) {
          scope.$eval(clickAction)
        }
      });
    }
  };
});