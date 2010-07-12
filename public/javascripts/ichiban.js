/* Custom functions */
var loadElement = function() {
  var target = this;
  $.get($(this).attr("data-populate-with"), function(data) {
     $(target).html(data);
  });
};

$("*[data-populate-with]").livequery(loadElement);
$("*[data-populate-with]").live("reload", loadElement);

$(".comment-form").live("comment-success", function(event) {
  $(".comment-failure", this).hide();
  $(".comment-success", this).show();
  $("input[type='text'], textarea", this).val("");
  $("#comments_list_wrapper").trigger("reload");
});

$(".comment-form").live("comment-failure", function(event) {
  $(".comment-success", this).hide();
  $(".comment-failure", this).show();
});

