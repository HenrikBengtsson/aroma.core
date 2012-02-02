var explorer = new ArrayExplorer();

window.onresize = function() {
  explorer.update();
}

includeDom("../ArrayExplorer.onLoad.js");
includeDom("ArrayExplorer.onChipType.js");
includeDom("ArrayExplorer.onLoad.js");
includeDom("extras.js");

function myOnLoad() {
  explorer.start();
  webcutsOptions['numberLinks'] = false;
}

function changeChipType(chipType) {
  if (explorer.setChipType(chipType))
    explorer.updateImage();
}

function changeSample(sample) {
	if (explorer.setSample(sample))
    explorer.updateImage();
}

function changeColorMap(map) {
  if (explorer.setColorMap(map))
    explorer.updateImage();
}

function changeZoom(scale) {
  if (explorer.setScale(scale))
    explorer.updateImage();
}


/****************************************************************
 HISTORY:
 2007-08-09
 o Now ArrayExplorer.onChipType.js and ArrayExplorer.onLoad.js
   in the current directory are called.
 2007-03-19
 o Now the sample tags are written to their own label.
 2007-02-06
 o Updated to <rootPath>/<dataSet>/<tags>/<chipType>/<set>/.
 2007-01-27
 o Created.
 ****************************************************************/ 
