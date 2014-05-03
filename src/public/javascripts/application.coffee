# Init Angular.js
dependencies = [
  'ngRoute', 'ngResource',
  'ui.bootstrap', 'ui.bootstrap.tpls',
  'ui.bootstrap.transition'
]

app = angular.module 'module', dependencies

# Configure routes
app.config ($routeProvider) ->
  $routeProvider
    .when( '/', {
      templateUrl: '/pages/home',
      controller: 'IndexCtl'
    })

    .when( '/users', {
      templateUrl: '/pages/users',
      controller: 'UsersCtl'
    })

# Configure controllers
app.controller 'MainCtl', ($scope) ->

app.controller 'IndexCtl', ->

app.controller 'UsersCtl', ($scope) ->
  $scope.title = "Users Page"
