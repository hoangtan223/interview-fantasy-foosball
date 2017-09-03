$(document).on('turbolinks:load', function() {
  var file = document.getElementById("file");
  if (file) {
    file.onchange = function(){
      if(file.files.length > 0)
      {

        document.getElementById('filename').innerHTML = file.files[0].name;

      }
  }
  };

  $('.button').on('click', function(e) {
    $(e.target).addClass('is-loading');
  })
});

