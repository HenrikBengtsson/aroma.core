var explorer = new ChromosomeExplorer();


window.onresize = function() {
  explorer.update();
}

includeDom("ChromosomeExplorer.onLoad.js");
includeDom("../ChromosomeExplorer.onLoad.js");
includeDom("../samples.js");
includeDom("ChromosomeExplorer5.onLoad.js");
includeDom("../ChromosomeExplorer5.onLoad.js");
includeDom("extras.js");

function onLoad() {
  logAdd("onLoad()...");
  explorer.onLoad();
  logAdd("onLoad()...done");
  explorer.start();
  webcutsOptions['numberLinks'] = false;
}


var nav = null;
var navArea = null;
var navAreaWidth = 0;
var navImage = null;
var navImageOffsetX = 0;
var navImageWidth = 0;

var panel = null;
var panelImage = null;
var panelImageOnLoad = function() {};
var panelImageWidth = 0;
var panelImageOffsetX = 0;
var panelLocator = null;
var panelLocatorTag = null;
var panelWidth = 0;
var panelMaxWidth = 0;
