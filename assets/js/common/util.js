function getElementPagePosition(element){
    //计算x坐标
    var actualLeft = element.offsetLeft;
    var current = element.offsetParent;
    while (current !== null){
      actualLeft += current.offsetLeft;
      current = current.offsetParent;
    }
    //计算y坐标
    var actualTop = element.offsetTop;
    var current = element.offsetParent;
    while (current !== null){
      actualTop += (current.offsetTop+current.clientTop);
      current = current.offsetParent;
    }
    //返回结果
    return {x: actualLeft - 5, y: actualTop - 84}
}

function htmlspecialchars_decode(string, quote_style) {
  var optTemp = 0, i = 0, noquotes = false;
  if (typeof quote_style === 'undefined') {
      quote_style = 2;
  }
  string = string.toString().replace(/&lt;/g, '<').replace(/&gt;/g, '>');
  var OPTS = {
      'ENT_NOQUOTES': 0,
      'ENT_HTML_QUOTE_SINGLE': 1,
      'ENT_HTML_QUOTE_DOUBLE': 2,
      'ENT_COMPAT': 2,
      'ENT_QUOTES': 3,
      'ENT_IGNORE': 4
  };
  if (quote_style === 0) {
      noquotes = true;
  }
  if (typeof quote_style !== 'number') { // Allow for a single string or an
      // array of string flags
      quote_style = [].concat(quote_style);
      for (i = 0; i < quote_style.length; i++) {
          // Resolve string input to bitwise e.g. 'PATHINFO_EXTENSION' becomes
          // 4
          if (OPTS[quote_style[i]] === 0) {
              noquotes = true;
          } else if (OPTS[quote_style[i]]) {
              optTemp = optTemp | OPTS[quote_style[i]];
          }
      }
      quote_style = optTemp;
  }
  if (quote_style & OPTS.ENT_HTML_QUOTE_SINGLE) {
      string = string.replace(/&#0*39;/g, "'"); // PHP doesn't currently
      // escape if more than one
      // 0, but it should
      // string = string.replace(/&apos;|&#x0*27;/g, "'"); // This would also
      // be useful here, but not a part of PHP
  }
  if (!noquotes) {
      string = string.replace(/&quot;/g, '"');
  }
  // Put this in last place to avoid escape being double-decoded
  string = string.replace(/&amp;/g, '&');
  return string;
}



export {getElementPagePosition, htmlspecialchars_decode}