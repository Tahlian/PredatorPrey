# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


ready = ->
  if $("#new_store").length > 0
    $(".new_save-btn").click (event) ->
      event.preventDefault()
      $("#store_flag").val("save")
      $("input[value='Create Store']").click()

$(document).ready ready
$(document).on "page:load", ready

ready = ->
  if $("#new_store").length > 0
    $(".update_save-btn").click (event) ->
      event.preventDefault()
      $("#store_flag").val("update")
      $("input[value='Create Store']").click()

$(document).ready ready
$(document).on "page:load", ready

