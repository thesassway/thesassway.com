$(function() {

  // Open external links in a new window
  var hostname = window.location.hostname;
  $("a[href^=http]")
    .not("a[href*='" + hostname + "']")
    .addClass('link external')
    .attr('target', '_blank');

  $('[title!=""]').qtip({
    position: {
      my: 'top center',
      at: 'bottom center',
      adjust: { y: 4 }
    },
    style: {
      classes: 'qtip-tipsy'
    },
    show: {
      delay: 0
    },
    hide: {
      delay: 0
    }
  });

});
