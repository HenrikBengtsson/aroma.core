/* Copyright (c) 2007 Henrik Bengtsson (http://www.braju.com/)
 * Dual licensed under the MIT (http://www.opensource.org/licenses/mit-license.php) 
 * and GPL (http://www.opensource.org/licenses/gpl-license.php) licenses.
 */


jQuery.extend({
  getUrlParameters : function() {
    var params = new Array();
    var qString = window.location.search.substr(1);
    qString = qString.split("&");
    for (var kk=0; kk < qString.length; kk++) {
      var keyValue = qString[kk].split("=");
      var key = escape(unescape(keyValue[0]));
      var value = unescape(keyValue[1]);
      params[key] = value;
    }
    return params;
	}
});
