$(function(){
  $("#users").on("click","button", function(){
    alert($(this).attr("value"));
    $("#user").val($(this).attr("value"));
    $("#users").html("");
  });    
  $("#user").keyup(function() {
    if ($("#user").val().length>3)
      $.get("/edit_curricula/search_results", $("#user").serialize());
    if ($("#user").val().length<=3)
      $("#users").html("");
    return false;
  });
});