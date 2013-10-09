$(document).ready(function() {
  $(".glyphicon").tooltip();
});

Core = {
  href: function(sUrl) {
    window.location.href = sUrl;
    return false;
  },
  search: function(sUrl) {
    window.location.href = sUrl;
    return false;
  }
}
