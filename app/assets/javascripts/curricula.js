$(function() {
  $('.folder a').on('click', function() { getContentsForFolder(); });
});

function getContentsForFolder() {
  alert($('.folder a').text);
}
