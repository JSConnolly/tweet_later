
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
        check_job_status
        setInterval(function(){ // <--- DATA IS UNDEFINED HERE, use callbacks and/or wrap ajax calls in same funct to implement "promise" interface
        if (check_job_status(job_id)){
          $response.text('Tweet sent!');
          clearInterval();
          $response.show();
          $waiting.hide();
        } else{
          console.log("check_job_status does not return true");
        }
      }, 20);
      
    })
    .fail(function(a, b, c){
      $('p#response').text("ajax call failed: " +a+" "+b+" "+c);
      $response.show();
      $waiting.hide();
    })
  });


  var check_job_status = function(job_id){
    $.ajax({
      method: 'get',
      url: "/status/"+job_id
    })
    .done(function(job_is_done){
      console.log("2nd ajax call data: " + job_is_done)

      if (job_is_done === 'true'){
        console.log("job_is_done returning true");
       
        // $response.text('Tweet sent!');
        return true;
      } 
      else {
        console.log('returning false');
        return false;
      }
    })
    .fail(function(a,b,c){
      console.log("check job status ajax call failed: "+a+" "+b+" "+c);
    });
  }

});
