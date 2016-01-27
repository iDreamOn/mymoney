# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on 'change ready page:load', ->
  if ($('.datepicker').attr('data-behaviour'))
    $('.datepicker').datepicker({format: 'yyyy-mm-01', autoclose: true, weekStart: 0, todayHighlight: true, startView: "months", minViewMode: "months" })
