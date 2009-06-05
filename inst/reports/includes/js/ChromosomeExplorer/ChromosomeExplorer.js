var shortcuts = new Array();
var shortcutLabels = new Array();
var chromosomes = new Array('01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21','22','X');
var chipTypeIdx = 0;
var chipTypes = null;
var chipType = null;
var sampleIdx = 0;
var samples = new Array();
var sampleLabels = null;
var sample = null;
var zooms = new Array(1);
var zoomIdx = 0;
var navigatorZoom = -1;
var label = null;
var chromosomeIdx = 22;
var chromosome = null;
var scale = -1;
var oldScale = scale;
var loadCount = 0;
var nav = null;
var navArea = null;
var panel = null;
var panelX = 0;
var status = null;
var statusImage = null;
var navImage = null;
var panelImage = null;
var panelImageOnLoad = function() {};
var panelImageWidth = 0;
var panelImageOffsetX = 0;
var panelLocator = null;
var panelLocatorTag = null;
var panelWidth = 0;
var panelMaxWidth = 0;
var navImageOffsetX = 0;
var navImageWidth = 0;
var navAreaWidth = 0;
var navAreaX = 0;
var imageUrl = null;
var bookmarkUrl = null;
var cnrUrl = null;

function findPosX(obj) {
  var pos = 0;
  if (obj.offsetParent)  {
    while (obj.offsetParent) {
      pos += parseFloat(obj.offsetLeft);
      obj = obj.offsetParent;
    }
  }  else if (obj.x) {
    pos += obj.x;
  }
  return pos;
}

function updateGlobals() {
  panelWidth = panel.clientWidth;
  panelMaxWidth = panel.scrollWidth;
  navImageOffsetX = findPosX(navImage);
  panelImageWidth = panelImage.clientWidth;
  panelImageOffsetX = findPosX(panelImage);
  navImageWidth = navImage.clientWidth;
  navAreaWidth = navImageWidth * (panelWidth / panelMaxWidth);
}

function resetPositions() {
  navAreaX = 0;
  panel.scrollLeft = 0;
  updateGlobals();
}

function navAreaUpdate() {
  if (navAreaX < 0) {
    navAreaX = 0;
  } else if (navAreaX + navAreaWidth > navImageWidth) {
    navAreaX = navImageWidth - navAreaWidth;
  }
  navArea.style.width = navAreaWidth + "px";
  navArea.style.left = (navAreaX + navImageOffsetX) + "px";
  locatorUpdated();
}

function navAreaMove(midX) {
  navAreaX = midX - navAreaWidth/2;
  navAreaUpdate();
  panelMove(navAreaX/navImageWidth);
}

function navAreaMoveRel(relX) {
  navAreaMove(relX * navImageWidth);
}


function panelMove(relOffset) {
  panelX = relOffset*panelMaxWidth;
  if (panelX < 0)
    panelX = 0;
  panel.scrollLeft = panelX;
}

function locatorUpdated() {
  /* Update locator tag */
  var pixelsPerMb = 3; /* /1.0014; */
  var xPx = findPosX(panelLocator) - findPosX(panelImage) + parseFloat(panel.scrollLeft);
  var xMb = (xPx-50)/(scale*pixelsPerMb);
  var tag = Math.round(100*xMb)/100 + 'Mb';
  updateText(panelLocatorTag, tag);

  var url;

  /* Update shortcut link */
  if (bookmarkUrl != null) {
    var args = "'" + chipType + "', '" + sample + "', '" + chromosome + "', " + panel.scrollLeft + ", " + scale;
    url = 'javascript:jumpTo(' + args + ');';
    url = 'x:"' + args + '",';
  	/* url = 'javascript:addToFavorites("' + url + '", "sss")';	*/
    bookmarkUrl.href = url;
    updateText(bookmarkUrl, url);
  }

  /* Update CNR link */
  if (cnrUrl != null) {
    url = chipType + '/glad/' + 'regions.xls';
    cnrUrl.href = url;
    updateText(cnrUrl, url);
  }
}

function jumpTo(newChipType, newSample, newChromosome, newPanelOffset, newZoom) {
  /* Chip type */
  if (chipType != '') {
    clearById('chipType' + chipType);
    chipTypeIdx = chipTypes.indexOf(newChipType);
    chipType = chipTypes[chipTypeIdx];
    highlightById('chipType' + chipType);
  }

  /* Sample */
  clearById('sample' + sample);
  sampleIdx = samples.indexOf(newSample);
  sample = samples[sampleIdx];
  highlightById('sample' + sample);

  /* Chromosome */
  clearById('chromosome' + chromosome);
  chromosomeIdx = chromosomes.indexOf(newChromosome);
  chromosome = chromosomes[chromosomeIdx];
  highlightById('chromosome' + chromosome);

  /* Zoom */
  clearById('zoom' + scale);
  zoomIdx = -1;
  var kk = 0;
  while (zoomIdx == -1 && kk < zooms.length) {
    if (zooms[kk] == newZoom)
      zoomIdx = kk;
    kk = kk + 1;
  }
  scale = zooms[zoomIdx];
  highlightById('zoom' + scale);

  /* When image is loaded... */
  panelImageOnLoad = function() {
    panel.scrollLeft = newPanelOffset;
    panelUpdated();
  }

  updatePanel();
  updateNavigator();
}

function panelUpdated() {
  updateGlobals();
  relOffset = panel.scrollLeft / panelMaxWidth;
  navAreaX = relOffset * navImageWidth;
  navAreaUpdate();
  locatorUpdated();
}

function clearById(id) {
  var obj = document.getElementById(id);
  if (obj != null) {
/*  
    obj.style.visibility = 'hidden'; 
    obj.style.borderBottom = 'none';
*/
    obj.style.background = 'none';
  }
}

function updateText(obj, str) {
  obj.innerText = str;
  obj.innerHTML = str;
}

function highlightById(id) {
  var obj = document.getElementById(id);
  if (obj != null) {
/*  
    obj.style.visibility = 'visible'; 
    obj.style.borderBottom = '2px solid black';
*/
    obj.style.background = '#ccccff;';
  }
}

function changeChipType(idx) {
  if (chipTypeIdx != idx) {
    clearById('chipType' + chipType);
    loadCount = 2;
    setStatus('wait');
    chipTypeIdx = idx;
    chipType = chipTypes[chipTypeIdx];
    highlightById('chipType' + chipType);
    updatePanel();
    updateNavigator();
  }
}

function changeSample(idx) {
  if (sampleIdx != idx) {
    clearById('sample' + sample);
    loadCount = 2;
    setStatus('wait');
    sampleIdx = idx;
    sample = samples[sampleIdx];
    highlightById('sample' + sample);
    updatePanel();
    updateNavigator();
  }
}

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

function changeChromosome(idx) {
  if (chromosomeIdx != idx) {
    clearById('chromosome' + chromosome);
    loadCount = 2;
    setStatus('wait');
    chromosomeIdx = idx;
    chromosome = chromosomes[chromosomeIdx];
    highlightById('chromosome' + chromosome);
    updatePanel();
    updateNavigator();
  }
}

function changeZoom(idx) {
  zoomIdx = idx;
  s = zooms[idx];
  if (scale != s) {
    clearById('zoom' + scale);
    loadCount = 1;
    setStatus('wait');
    oldScale = scale;
    scale = s;
    highlightById('zoom' + scale);
    updatePanel();
    oldScale = scale;
  }
}


function updateLabel(id, text) {
  var obj = document.getElementById(id);
  DOM_setInnerText(obj, text); /* From Webcuts.js */
}

function showIndicator(state) {
  statusImage = document.getElementById('statusImage');
  if (state) {
    statusImage.style.visibility = 'visible';
  } else {
    statusImage.style.visibility = 'hidden';
  }
}

function setStatus(state) {
  navImage = document.getElementById('navigatorImage');
  panelImage = document.getElementById('panelImage');
  if (state == "") {
    showIndicator(false);
    navImage.style.filter = "alpha(opacity=50)";
    navImage.style.opacity = 0.50;
    panelImage.style.filter = "alpha(opacity=100)";
    panelImage.style.opacity = 1.0;
    updateInfo();
  } else if (state == "wait") {
    showIndicator(true);
    navImage.style.filter = "alpha(opacity=20)";
    navImage.style.opacity = 0.20;
    panelImage.style.filter = "alpha(opacity=50)";
    panelImage.style.opacity = 0.50;
  }
}

function updateInfo() {
  updateLabel('chromosomeLabel', chromosomes[chromosomeIdx]);
  var label = samples[sampleIdx];
  if (sampleLabels != null) {
    if (sampleLabels[sampleIdx] != label) {
      label = sampleLabels[sampleIdx] + ' (' + label + ')';
    }
  }
  updateLabel('sampleLabel', label);
}

function padWidthZeros(x, width) {
  var str = "" + x;
  while (width - str.length > 0)
    str = "0" + str;
  return(str);
}

function getImagePathname(chipType, sample, chromosome, zoom) {
  alert('ERROR: Javascript function getImagePathname() must be redefined in samples.js');
  return(null);
}

function getImagePathname(chipType, sample, chromosome, zoom) {
  imgName = sample + ",chr" + padWidthZeros(chromosome, 2) + ",x" + padWidthZeros(zoom, 4) + ".png";
  var pathname = chipType + '/glad/' + imgName;
  return(pathname);
}

function updatePanel() {
  var navAreaRelMidX = (navAreaX + navAreaWidth/2) / navImageWidth;
  var pathname = getImagePathname(chipType, sample, chromosomeIdx+1, scale);
  panelImage = document.getElementById('panelImage');
  panelImage.onload = function() {
    updateNavigatorWidth();
    updateGlobals();
    navAreaMoveRel(navAreaRelMidX);
    loadCount = loadCount - 1;
    if (loadCount <= 0) {
      loadCount = 0;
      setStatus("");
    }
    panelImageOnLoad();
    panelImageOnLoad = function() {};
  }
  panelImage.src = pathname;
  imageUrl.href = pathname;
  updateText(imageUrl, pathname);

  /* Update the title of the page */
  var title = location.href;
  title = title.substring(0, title.lastIndexOf('\/'));
  title = title.substring(title.lastIndexOf('\/')+1);
  title = title + '/' + pathname;
  document.title = title;
}


function updateNavigator() {
  var pathname = getImagePathname(chipType, sample, chromosomeIdx+1, navigatorZoom);
  navImage = document.getElementById("navigatorImage");
  navImage.onload = function() {
    loadCount = loadCount - 1;
    if (loadCount <= 0) {
      loadCount = 0;
      setStatus("");
    }
  }
  navImage.src = pathname;
} // updateNavigator()

function updateNavigatorWidth() {
  /* Update the width of the navigator */
  var chromosomeLength = new Array(3840, 3798, 3119, 2993, 2826, 2673, 2482, 2288, 2165, 2117, 2104, 2071, 1785, 1664, 1568, 1387, 1230, 1191, 998, 976, 733, 774, 2417);
  var relWidth = chromosomeLength[chromosomeIdx] / chromosomeLength[0];
  navImageWidth = Math.round(relWidth * nav.clientWidth);
  navAreaWidth = Math.round(relWidth * nav.clientWidth);
  navImage.style.width = "" + navImageWidth  + "px";
}

function startChromosomeExplorer() {
  function setGlobalCursor(status) {
    panel.style.cursor = status;
    panelImage.style.cursor = status;
    nav.style.cursor = status;
    navImage.style.cursor = status;
    navArea.style.cursor = status;
  }

  /*******************************************************
   * Set the current sample
   *******************************************************/
  sample = samples[sampleIdx];
  highlightById('sample' + sample);

  chipType = chipTypes[chipTypeIdx];
  highlightById('chipType' + chipType);

  if (chromosome == null)
    chromosome = chromosomes[chromosomeIdx];
  highlightById('chromosome' + chromosome);

  scale = zooms[zoomIdx];
  oldScale = scale;
  highlightById('zoom' + scale);

  if (navigatorZoom == -1) {
    navigatorZoom = scale;
  }

  imageUrl = document.getElementById('imageUrl');
  bookmarkUrl = document.getElementById('bookmarkUrl');
  cnrUrl = document.getElementById('cnrUrl');

  /*******************************************************
   * chromosomePanel
   *******************************************************/
  panel = document.getElementById('panel');
  panelLocator = document.getElementById('panelLocator');
  panelLocatorTag = document.getElementById('panelLocatorTag');

  panelOnScroll = function() {
     relOffset = panel.scrollLeft / panelMaxWidth;
    navAreaX = relOffset * navImageWidth;
    navAreaUpdate();
  }

  panel.onscroll = panelOnScroll;

  panelImage = document.getElementById('panelImage');

  var panelLocatorIsLocked = true;

  panelImage.ondblclick = function() {
    panelLocatorIsLocked = false;
    panelImage.onmousedown = null;
    var e = arguments[0] || event;
    mouseX = e.clientX;
    panelLocator.style.left = (mouseX-2) + "px";
    locatorUpdated();
  }
  panelLocator.ondblclick = panelImage.ondblclick;

  panelImage.onclick = function() {
    panelLocatorIsLocked = true;
    panelImage.onmousedown = panelImageOnMouseDown;
  }
  panelLocator.onclick = panelImage.onclick;

  panelImageOnMouseMove = function() {
    if (!panelLocatorIsLocked) {
      var e = arguments[0] || event;
      mouseX = e.clientX;
      panelLocator.style.left = (mouseX-2) + "px";
      locatorUpdated();
    }
    return false;
  }

  panelImage.onmousemove = panelImageOnMouseMove;

  panelImageOnMouseDown = function() {
    var e = arguments[0] || event;
    var x = panel.scrollLeft + e.clientX;
    setGlobalCursor("move");
    panel.onscroll = null;
    panelImage.onmousemove = null;

    document.onmousemove = function() {
      var e = arguments[0] || event;
      isMoving = true;
      panel.scrollLeft = x - e.clientX;
      panelUpdated();
      return false;
    }

    document.onmouseup = function() {
      document.onmousemove = null;
      panel.onscroll = panelOnScroll;
      panelImage.onmousemove = panelImageOnMouseMove;
//      panelLocatorIsLocked = false;
      setGlobalCursor("default");
      return false;
    }

    return false;
  }

  panelImage.onmousedown = panelImageOnMouseDown;

  /*******************************************************
   * chromosomeNavigator
   *******************************************************/
  nav = document.getElementById('navigator');
  navImage = document.getElementById('navigatorImage');

  navArea = document.getElementById('navigatorArea');
  var mouseX = 0;
  var mouseDown = false;

  /* Immitate onmousepress, which does not exists */
  navImage.onmousepress = function() {
    if (mouseDown) {
      if (mouseX < navAreaX) {
        navAreaMove(navAreaX - 0.47*navAreaWidth);
      } else if (mouseX > navAreaX + 1*navAreaWidth) {
        navAreaMove(navAreaX + 1.47*navAreaWidth);
      } else {
        navAreaMove(mouseX);
      }
      setTimeout('navImage.onmousepress();', 100);
    }
    return false;
  }

  navImage.onmousedown = function() {
    var e = arguments[0] || event;
    mouseDown = true;
    updateGlobals();
    mouseX = (e.clientX - navImageOffsetX);
    if (mouseX < navAreaX) {
      navAreaMove(navAreaX - 0.47*navAreaWidth);
      } else if (mouseX > navAreaX + 1*navAreaWidth) {
      navAreaMove(navAreaX + 1.47*navAreaWidth);
    }

    setTimeout('navImage.onmousepress();', 500);

    document.onmouseup = function() {
      navImage.onmousemove = null;
      mouseDown = false;
      return false;
    }

    navImage.onmousemove = function() {
      var e = arguments[0] || event;
      mouseX = (e.clientX - navImageOffsetX);
      return false;
    }

    return false;
  }

  navArea.onmousedown = function() {
    var e = arguments[0] || event;
    setGlobalCursor("move");
    panel.onscroll = null;
    updateGlobals();
    mouseX = (e.clientX - navImageOffsetX);
    var dx = navAreaWidth/2 + (navAreaX - mouseX);
    navAreaMove(mouseX + dx);

    document.onmousemove = function() {
      var e = arguments[0] || event;
      mouseX = (e.clientX - navImageOffsetX);
      navAreaMove(mouseX + dx);
      return false;
    }

    document.onmouseup = function() {
      document.onmousemove = null;
      panel.onscroll = panelOnScroll;
      setGlobalCursor("default");
      return false;
    }
    return false;
  }

  updateNavigator();
  updatePanel();
  setStatus('');
  webcutsOptions['numberLinks'] = false;
  setTimeout('navAreaMoveRel(0.5);', 1000);
}

function getMouseMb(x, chromosome, zoom) {
  return(-1);
}

