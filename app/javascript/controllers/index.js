// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import AddressAutocompleteController from "./address_autocomplete_controller"
application.register("address-autocomplete", AddressAutocompleteController)

import ChatroomSubscriptionController from "./chatroom_subscription_controller"
application.register("chatroom-subscription", ChatroomSubscriptionController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import MapController from "./map_controller"
application.register("map", MapController)

import RandomWheelController from "./random_wheel_controller"
application.register("random-wheel", RandomWheelController)

import WeatherController from "./weather_controller"
application.register("weather", WeatherController)
