$(document).ready(function() {

  // Create, show and hide the grid
  $('body').append('<div id="grid"></div>');
  $('body').append('<a href="#" id="toggle-grid"><span class="hide">Hide Grid</span><span class="show">Show Grid</span></a>');
  $('a#toggle-grid').toggle(function() {
    $('#grid').slideDown('fast');
    $('#toggle-grid .hide').show();
    $('#toggle-grid .show').hide();
  }, function() {
    $('#grid').slideUp('slow');
    $('#toggle-grid .hide').hide();
    $('#toggle-grid .show').show();
  });
  
  // Open external links in a new window
  hostname = window.location.hostname
  $("a[href^=http]")
    .not("a[href*='" + hostname + "']")
    .addClass('link external')
    .attr('target', '_blank');

});
