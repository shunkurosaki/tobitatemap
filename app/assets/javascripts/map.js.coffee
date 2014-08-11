# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

initialize = ->
  latlng_adaniya = new google.maps.LatLng(37.427475, -122.169719)
  opts =
    zoom: 18
    center: latlng_adaniya
    mapTypeId: google.maps.MapTypeId.ROADMAP

  map = new google.maps.Map(document.getElementById("map_canvas"), opts)
  contentStr = "<p>" + "安谷屋　樹(2014/09/01~2015/08/31)" + "<br>" + "<img src=\"./img/adaniya.png\" width=\"80\" height=\"80\" alt=\"home\" />" + "</p>"
  infowindow = new google.maps.InfoWindow(
    content: contentStr
    position: latlng_adaniya
  )
  infowindow.open map
  return