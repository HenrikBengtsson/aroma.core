window.onresize = function() {
  explorer.update();
}

includeDom("ChromosomeExplorer.onLoad.js");
includeDom("../ChromosomeExplorer.onLoad.js");
includeDom("../samples.js");
includeDom("extras.js");

function onLoad() {
  explorer.onLoad();
  explorer.start();
  webcutsOptions['numberLinks'] = false;
}

function changeChipType(idx) {
  explorer.setChipType(idx);
}

function changeChromosome(idx) {
  explorer.setChromosome(idx);
}

function changeZoom(idx) {
  explorer.setScale(idx);
}

function changeSet(idx) {
  explorer.setSet(idx);
}

function changeSample(idx) {
  explorer.setSample(idx);
}


function startChromosomeExplorer() {
  explorer.start();
}

var chromosomes = new Array('01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21','22','X');
var chipTypes = null;

var chromosomeIdx = 22;
var sampleIdx = 0;
var setIdx = 0;
var zoomIdx = 0;

var samples = new Array();
var sampleLabels = null;

var zooms = new Array(1);
var sets = new Array();

var navigatorZoom = -1;

var nav = null;
var navArea = null;
var navAreaWidth = 0;
var navAreaX = 0;
var navImage = null;
var navImageOffsetX = 0;
var navImageWidth = 0;

var panel = null;
var panelX = 0;
var panelImage = null;
var panelImageOnLoad = function() {};
var panelImageWidth = 0;
var panelImageOffsetX = 0;
var panelLocator = null;
var panelLocatorTag = null;
var panelWidth = 0;
var panelMaxWidth = 0;






var playSamples = false;
var playDelay = 2000;

function gotoNextSample(step) {
  var nextSampleIdx = sampleIdx + step;
  if (nextSampleIdx >= samples.length) {
    nextSampleIdx = 0;
  } else if (nextSampleIdx < 0) {
    nextSampleIdx = samples.length-1;
  }
  changeSample(nextSampleIdx);
  if (playSamples) {
    cmd = "gotoNextSample(" + step + ");";
    setTimeout(cmd, playDelay);
  }
}

function playAlongSamples(cmd) {
  if (cmd == "start") {
    playSamples = true;
    gotoNextSample(1);
  } else if (cmd == "stop") {
    playSamples = false;
  }
}



/* NOT USED */
var shortcuts = new Array();
var shortcutLabels = new Array();

