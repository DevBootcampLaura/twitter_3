$(document).ready(function() {
  $('#form').submit(function(e) {
    e.preventDefault();
    // var tweet = {tweet_text: $("#tweet_text").val()};
    // $('#tweet_text').prop('disabled', true);
    // $(".container").append("<img id='balls' src='ajax-loader.gif'/>")
    $.ajax({
      type: "POST",
      url: "/ajax_tweet",
      // data: tweet,
      success: function(response){
        console.log(response.job_id);
        // site = "/status/" + response;
        window.location.href = "/status/" + response.job_id;

        // $("#balls").remove();
        // $("#success").html("<h1>"+response+"</h1>").fadeIn(500);
        // $("#success").delay(2000).fadeOut(500);
        // $('#tweet_text').prop('disabled', false);
        // $('#tweet_text').val("");
      }
    });
  });
});
