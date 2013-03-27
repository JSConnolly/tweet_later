
$(document).ready(function() {
  var $waiting = $('.waiting')
  var $response = $('#response')
  $waiting.hide();

  $('form').submit(function(e){
    e.preventDefault();

    $waiting.show();
    $response.hide();

    $.ajax({
      method: $(this).attr('method'),
      url: $(this).attr('action'),
      data: $(this).serialize()
      })
      .done(function(job_id){
        check_job_status(job_id);
      })
      .fail(function(a, b, c){
        $('p#response').text("ajax call failed: " +a+" "+b+" "+c);
        // $response.show();
        $waiting.hide();
      })
  });


  var check_job_status = function(job_id){

      var handle = setInterval(function(){

        if ($response.is(":visible")) {clearInterval(handle);}

        $.ajax({
          method: 'get',
          url: "/status/"+job_id
        })
        .done(function(job_is_done){
          
          if (job_is_done === 'true'){
            $response.text('Tweet sent!');
            $response.show();
            $waiting.hide();
          } 
          else {
            $('.waiting').append('.');
          }

        })
        .fail(function(a,b,c){
          console.log("check job status ajax call failed: "+a+" "+b+" "+c);
        });

    }, 20);
  }
});
