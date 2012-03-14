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
includeDom("../../includes/js/ScrollImage1d.js");
includeDom("../../includes/js/ChromosomeExplorer3.2/ChromosomeExplorer.js");
