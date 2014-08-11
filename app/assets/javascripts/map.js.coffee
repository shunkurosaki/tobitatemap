# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

initialize = ->
  latlng_adaniya = new google.maps.LatLng(37.792457, -122.393064)
  opts =
    zoom: 13
    center: latlng_adaniya
    mapTypeId: google.maps.MapTypeId.ROADMAP

  map = new google.maps.Map(document.getElementById("map_canvas"), opts)
  contentStr = "<p>" + "黒崎　俊" + "<br>" + "(2014/09/01~2015/08/31)" + "<br>" + "<img src=\"/assets/shunkurosaki.png\" width=\"80\" height=\"80\" alt=\"shunkurosaki\" />" + "</p>"
  infowindow = new google.maps.InfoWindow(
    content: contentStr
    position: latlng_adaniya
  )
  infowindow.open map
  return

window.onload = ->
  initialize()
  return