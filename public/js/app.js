var startDownload = function() {
  //var canvas = document.getElementById(canvasId);
  //var imgdata = canvas.toDataURL('image/png');
  //$('#data-url').val(imgdata);
  //$('#download-form').submit();

  $(".icon-canvas").each(function( index ) {
    var canvasId = $(this).context.id;
    var canvas = document.getElementById(canvasId);
    var formElemId = canvasId.replace('canvas-', '#data-url-');
    var imgdata = canvas.toDataURL('image/png');
    $(formElemId).val(imgdata);
  });
  $('#download-form').submit();
}


var fontTop = function(height) {
  switch(height) {
    case 180:
        return 115;
    case 120:
        return 76;
    case 80:
        return 51;
    case 87:
        return 55;
    case 58:
        return 37;
    default:
        return 115;
  }
};

var fontHeight = function(height) {
  switch(height) {
    case 180:
        return "84px/1 FontAwesome";
    case 120:
        return "56px/1 FontAwesome";
    case 80:
        return "37px/1 FontAwesome";
    case 87:
        return "40px/1 FontAwesome";
    case 58:
        return "27px/1 FontAwesome";
    default:
        return 115;
  }
};

var generateIcon = function(canvasId, fgc, bgc, font) {
  var canvas = document.getElementById(canvasId);
  var ctx = canvas.getContext("2d");
  ctx.fillStyle = bgc;
  ctx.fillRect(0, 0, canvas.width, canvas.height)
  ctx.font = fontHeight(canvas.height);
  ctx.fillStyle = fgc;
  var w = (ctx.measureText(font).width) / 2;
  var W = canvas.width / 2;
  ctx.fillText(font, W-w, fontTop(canvas.height));

};
