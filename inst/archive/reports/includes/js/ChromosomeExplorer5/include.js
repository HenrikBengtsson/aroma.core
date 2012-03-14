
function includeDom(url) {
    var js = document.createElement('script');
    js.setAttribute('language', 'javascript');
    js.setAttribute('type', 'text/javascript');
    js.setAttribute('src', url);
    var htmlHead = document.getElementsByTagName('head').item(0);
    htmlHead.appendChild(js);
    return false;
}

includeDom("../../includes/js/jquery/jquery-1.2.1.min.js");
includeDom("../../includes/js/jquery/jquery.cookie.js");
includeDom("../../includes/js/jquery/jquery.blockUI.js");
includeDom("../../includes/js/jquery/jquery.dimensions.js");
includeDom("../../includes/js/jquery/ui.dialog.js");
includeDom("../../includes/js/jquery/ui.resizable.js");
includeDom("../../includes/js/jquery/ui.mouse.js");
includeDom("../../includes/js/jquery/ui.draggable.js");
includeDom("../../includes/js/jquery/jquery.getUrlParameters.js");
includeDom("../../includes/js/prototype/prototype.js");
includeDom("../../includes/js/webtoolkit/webtoolkit.sprintf.js");
includeDom("../../includes/js/Webcuts.js");
includeDom("../../includes/js/domUtils.js");
includeDom("../../includes/js/aroma/log.js");
includeDom("../../includes/js/aroma/ImageLayer.js");
includeDom("../../includes/js/aroma/aroma.ExplorerSettings.js");
includeDom("../../includes/js/ChromosomeExplorer5/ChromosomeExplorer.js");

