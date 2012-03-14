function includeDom(url) {
    var js = document.createElement('script');
    js.setAttribute('language', 'javascript');
    js.setAttribute('type', 'text/javascript');
    js.setAttribute('src', url);
    var htmlHead = document.getElementsByTagName('head').item(0);
    htmlHead.appendChild(js);
    return false;
}

includeDom("../../includes/js/Webcuts.js");
includeDom("../../includes/js/domUtils.js");
includeDom("../../includes/js/ScrollImage2d.js");
includeDom("../../includes/js/ArrayExplorer/ArrayExplorer.js");

