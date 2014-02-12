
        function check_status(data){
        //get the status from /status/:job_id
          $.get("/status/" + data, function(response){
            if(response==="true"){
              alert("woohoo!");
              // clearInterval(timer);
            }else{
              setTimeout(check_status(response.job_id), 1);
            }

          });
        }



$(document).ready(function() {
  $('#form').submit(function(e) {
    e.preventDefault();
    var tweet = {status: $("#status").val()};
    $('#status').prop('disabled', true);
    $(".container").append("<img id='balls' src='ajax-loader.gif'/>")
    $.ajax({
      type: "POST",
      url: "/ajax_tweet",
      data: tweet,
      success: function(response){
        $("#balls").remove();
        $('#success').html("<h1>Please wait while we process your tweet.</h1>")
        check_status(response.job_id)

      }
    });
  });
});




// I want to get the result every second and see whether it is true or false
// var timer = setTimeout(check_status, 1000)

// function check_status(){
// //get the status from /status/:job_id
//   $.get("/status/" + response, function(data){
//     alert(data);
//   });
// }

