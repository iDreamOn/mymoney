# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on 'change ready page:load shown.bs.modal', ->
  $('.datepicker').datepicker({language: $('.datepicker').attr('language'), format: 'yyyy-mm-dd', autoclose: true, weekStart: 0, todayHighlight: true });

