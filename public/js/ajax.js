$(document).ready(function() {
  $.ajax({
    type: 'get',
    url: route
  }).done(function(data){
    $('div.container').append(data);
    $('img#loading_bar').remove();
  });
});
