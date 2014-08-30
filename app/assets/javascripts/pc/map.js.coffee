# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

initialize = ->
  opts =
    zoom: 2
    center: new google.maps.LatLng(35, 135)
    mapTypeId: google.maps.MapTypeId.ROADMAP

  map = new google.maps.Map(document.getElementById("map_canvas"), opts)

  for member in gon.members
    contentStr = "<p>" + member.name + "<br>" + member.term + "<br>" + "<img src=\"" + member.image.url + "\" width=\"80\" height=\"80\" alt=\"" + member.name + "\" />" + "</p>"
    infowindow = new google.maps.InfoWindow(
      content: contentStr
      position: new google.maps.LatLng(member.latitude, member.longitude)
    )
    infowindow.open map

  return

window.onload = ->
  initialize()
  return
