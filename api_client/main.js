$(document).ready(function(){
  $("#fetch-post").on("click", function() {
    $.ajax({
      url: "http://localhost:3000/api/v1/posts?api_key=c07ccaf71b05548c4ad214e48c4a5cbb1051aac3d9392675d34d323e5f7e80ef",
      method: "GET",
      errors: function(){
        alert("Something went wrong...Please try again");
      },
      success: function(data){
        $("#posts-wrapper").html("");
        var template = $("#post_template").html();
        var posts = data.posts;
        // debugger
        for (var i = 0; i < posts.length; i++) {
          var renderedHtml = Mustache.render(template, posts[i]);
          $("#posts-wrapper").append(renderedHtml);
        }
      }
    });
  });
});
