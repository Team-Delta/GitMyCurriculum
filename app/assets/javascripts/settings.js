$(function(){
  $("#users").on("click","a", function(){
    $("#user").val($(this).attr("value"));
    $("#users").html("");
  });
  $("#user").keyup(function() {
    if ($("#user").val().length > 3) {
      $.get("/curricula/settings/search", $("#user").serialize());
    }
    if ($("#user").val().length <= 3) {
      $("#users").html("");
    }
    return false;
  });
});