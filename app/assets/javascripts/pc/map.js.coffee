# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

initialize = ->
  latlng_shun = new google.maps.LatLng(gon.latitude, gon.longitude)
  latlng_adaniya = new google.maps.LatLng(31.791702, -7.092620)

  opts =
    zoom: 2
    center: latlng_shun
    mapTypeId: google.maps.MapTypeId.ROADMAP

  map = new google.maps.Map(document.getElementById("map_canvas"), opts)
  contentStr = "<p>" + "黒崎　俊" + "<br>" + "(2014/09/01~2015/08/31)" + "<br>" + "<img src=\"/assets/shunkurosaki.png\" width=\"80\" height=\"80\" alt=\"shunkurosaki\" />" + "</p>"
  contentStr2 = "<p>" + "アダニア" + "<br>" + "(2014/09/01~2015/08/31)" + "<br>" + "<img src=\"/assets/shunkurosaki.png\" width=\"80\" height=\"80\" alt=\"shunkurosaki\" />" + "</p>"
  infowindow = new google.maps.InfoWindow(
    content: contentStr
    position: latlng_shun
  )
  infowindow2 = new google.maps.InfoWindow(
    content: contentStr2
    position: latlng_adaniya
  )
  infowindow.open map
  infowindow2.open map
  return

window.onload = ->
  initialize()
  return