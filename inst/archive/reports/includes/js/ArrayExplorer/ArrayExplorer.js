/****************************************************************
 * ArrayExplorer()
 *
 * Author: Henrik Bengtsson, hb@stat.berkeley.edu
 ****************************************************************/
function ArrayExplorer() {
  /************************************************************************
   * Methods for setting up chip types, samples, color maps & scales
   ************************************************************************/
  this.setChipTypes = function(chipTypes) {
    this.chipTypes = chipTypes;

    if (chipTypes.length > 1) {
      var s = 'Chip types: ';
      for (var kk=0; kk < chipTypes.length; kk++) {
        var chipType = chipTypes[kk];
        s = s + '[<span id="chipType' + chipType + '"><a href="javascript:changeChipType(\'' + chipType + '\');">' + chipType + '</a></span>]'; 
      }
      s = s + '<br>';
      updateLabel('chipTypeLabel', s);
    }
  }


  this.setSamples = function(samples) {
    this.samples = samples;
    if (samples.length > 1) {
      var s = 'Samples: ';
      for (var kk=0; kk < samples.length; kk++) {
        var sample = samples[kk];
        var name = sample;
        if (this.sampleAliases != null)
          name = this.sampleAliases[kk];
        s = s + '[<span id="sample' + sample + '"><a href="javascript:changeSample(\'' + sample + '\');">' + name + '</a></span>]<span style="font-size:1%"> </span>';
      }
      s = s + ' ';
      updateLabel('samplesLabel', s);

      var sample = this.sample;
      this.sample = null;
      this.setSample(sample);
    }
  }

  this.setSampleAliases = function(aliases) {
    this.sampleAliases = aliases;
  }


  this.setColorMaps = function(colorMaps) {
    this.colorMaps = colorMaps;

    if (colorMaps.length > 0) {
      var s = 'Color map: ';
      for (var kk=0; kk < colorMaps.length; kk++) {
        var colorMap = colorMaps[kk];
        var name = colorMap;
        if (this.colorMapAliases != null)
          name = this.colorMapAliases[kk];
        s = s + '[<span id="colorMap' + colorMap + '"><a href="javascript:changeColorMap(\'' + colorMap + '\');">' + name + '</a></span>]'; 
      }
      s = s + '<br>';
      updateLabel('colorMapLabel', s);

      var colorMap = this.colorMap;
      this.colorMap = null;
      this.setColorMap(colorMap);
    }
  }

  this.setColorMapAliases = function(aliases) {
    this.colorMapAliases = aliases;
  }


  this.setScales = function(scales) {
    function padWidthZeros(x, width) {
      var str = "" + x;
      while (width - str.length > 0)
        str = "0" + str;
      return(str);
    }
   
    this.scales = scales;
    var zWidth = Math.round(Math.log(Math.max(scales)) / Math.log(10) + 0.5);
    var s = 'Zoom: ';
    for (var kk=0; kk < scales.length; kk++) {
      var scale = scales[kk];
      s = s + '[<span id="zoom' + scale + '"><a href="javascript:changeZoom(' + scale + ');">x' + padWidthZeros(scale, zWidth) + '</a></span>]'; 
    }
    s = s + '<br>';
    updateLabel('zoomLabel', s);

    var scale = this.scale;
    this.scale = null;
    this.setScale(scale);
  }


  /************************************************************************
   * Methods for updating the display
   ************************************************************************/
  this.showIndicator = function(state) {
    var statusImage = document.getElementById('statusImage');
    if (state) {
      statusImage.style.visibility = 'visible';
    } else {
      statusImage.style.visibility = 'hidden';
    }
  }

  this.setStatus = function(state) {
    if (state == "") {
      this.showIndicator(false);
      this.image2d.image.style.filter = "alpha(opacity=100)";
      this.image2d.image.style.opacity = 1.0;
    } else if (state == "wait") {
      this.showIndicator(true);
      this.image2d.image.style.filter = "alpha(opacity=50)";
      this.image2d.image.style.opacity = 0.50;
    }
  }

  this.getImageUrl = function() {
    var imgName = this.sample + "," + this.colorMap + ".png";
    var pathname = this.chipType + '/spatial/' + imgName;
    return(pathname);
  }

  this.updateImage = function() {
    var pathname = this.getImageUrl();
    this.loadCount = 2;
    this.setStatus('wait');
    this.nav2d.setImage(pathname);
    this.image2d.setImage(pathname);

    /* Update the title of the page */
    var title = location.href;
    title = title.substring(0, title.lastIndexOf('\/'));
    title = title.substring(title.lastIndexOf('\/')+1);
    title = title + '/' + pathname;
    document.title = title;
	}

  this.decreaseLoadCount = function() {
    this.loadCount = this.loadCount - 1;
    if (this.loadCount <= 0) {
      this.loadCount = 0;
      this.setStatus("");
    }
  }

  /************************************************************************
   * Methods for changing chip type, sample, color map & scale
   ************************************************************************/
  this.setColorMap = function(map) {
    if (this.colorMap == map)
      return(false);

    clearById('colorMap' + this.colorMap);
    highlightById('colorMap' + map);
    this.colorMap = map;
    this.updateImage();
    return(true);
  }

  this.setChipType = function(chipType) {
    if (this.chipType == chipType)
      return(false);

    this.onChipType(chipType);

    clearById('chipType' + this.chipType);
    highlightById('chipType' + chipType);
    this.chipType = chipType;

    return(true);
  }

  this.setSample = function(sample) {
    if (this.sample == sample)
      return(false);

    clearById('sample' + this.sample);
    highlightById('sample' + sample);

    this.sample = sample;

    var pos = sample.indexOf(',');
    var tags = "";
    if (pos != -1) {
      tags = sample.substring(pos+1);
      sample = sample.substring(0, pos);
    }
    updateLabel('sampleLabel', sample);
    updateLabel('sampleTags', tags);

    return(true);
  }

  this.setScale = function(scale) {
    if (this.scale == scale)
      return(false);

    clearById('zoom' + this.scale);
    this.scale = scale;
    var ar = this.image2d.getAspectRatio();
    this.nav2d.setRelDimension(1/scale, 1/scale/ar);
    this.image2d.setRelDimension(scale, scale);
    this.nav2d.update();
    this.image2d.update();
    highlightById('zoom' + scale);
    return(true);
  }


  /************************************************************************
   * Main
   ************************************************************************/
  this.samples = new Array();
  this.sampleAliases = null;
  this.chipTypes = new Array();
  this.colorMaps = new Array();
  this.colorMapAliases = null;
  this.scales = new Array();

  this.loadCount = 0;
  this.scale = 0;
  this.sample = '';
  this.chipType = '';
  this.colorMap = '';

  this.setupEventHandlers = function() {
    var owner = this;

    this.nav2d.onLoad = function() {
      owner.decreaseLoadCount();
      owner.updateInfo();
    }

    this.image2d.onLoad = function() {
      owner.decreaseLoadCount();
      owner.updateInfo();
    }

    this.getRegion = function() {
      var r = this.nav2d.getRegion();
      var w = this.image2d.imageWidth;
      var h = this.image2d.imageHeight;
      var res = new Object();
      res.x0 = Math.round(w*r.x0);
      res.y0 = Math.round(w*r.y0);
      res.x1 = Math.round(w*r.x1)-1;
      res.y1 = Math.round(w*r.y1)-1;
      return res;
    }

    this.image2d.onmousedown = this.nav2d.onmousedown = function() {
      var info = document.getElementById('image2dInfoTL');
      info.style.visibility = 'visible';
      info = document.getElementById('image2dInfoBR');
      info.style.visibility = 'visible';
    }

    this.image2d.onmouseup = this.nav2d.onmouseup = function() {
      var info = document.getElementById('image2dInfoTL');
      info.style.visibility = 'hidden';
      info = document.getElementById('image2dInfoBR');
      info.style.visibility = 'hidden';
    }

    this.nav2d.onmousemove = function() {
	  	owner.image2d.setRelXY(this.x, this.y);
		  owner.image2d.update();
      owner.updateInfo();
      return(false);    
	  }

    this.image2d.onmousemove = function() {
      owner.nav2d.setRelXY(this.x, this.y);
      owner.nav2d.update();
      owner.updateInfo();
      return(false);    
	  }
  }

  this.updateInfo = function() {
    var r = this.getRegion();
    var s = '('+r.x0+','+r.y0+')';
    updateLabel('image2dInfoTL', s);
    var s = '('+r.x1+','+r.y1+')';
    updateLabel('image2dInfoBR', s);
    var infoBR = document.getElementById('image2dInfoBR');
    var lh = infoBR.offsetHeight;
    var lw = infoBR.offsetWidth;
    var xy = findXY(this.image2d.container);
		infoBR.style.left = xy.x+this.image2d.container.clientWidth-lw;
		infoBR.style.top = xy.y+this.image2d.container.clientHeight-lh;
  }

  this.update = function() {
    var y = findXY(this.image2d.image).y;
    var dh = document.body.clientHeight;
    var h = (dh - y - 16) + 'px';
    this.image2d.container.style.height = h;
    var ar = this.image2d.getAspectRatio();
    this.nav2d.setRelDimension(1/this.scale, 1/this.scale/ar);
    this.updateImage();
    this.updateInfo();
  }

  this.onLoad = function() { }

  this.start = function() {
    this.nav2d = new Scrollbar2d("nav2d");
    this.image2d = new ScrollImage2d("image2d");
    this.setupEventHandlers();

    /* Default settings */
    this.setScales(new Array('0.5', '1', '2', '4', '8', '16', '32'));
    this.setColorMaps(new Array('gray'));

    var y = findXY(this.image2d.image).y;
   	var dh = document.body.clientHeight;
    var h = (dh - y - 12) + 'px';
	  this.image2d.container.style.height = h;

    this.onLoad();
    this.setChipType(this.chipTypes[0]);

    this.setSample(this.samples[0]);
    this.setScale(this.scales[0]);
    this.setColorMap(this.colorMaps[0]);

    this.update();
  }
} /* ArrayExplorer() */

/****************************************************************
 HISTORY:
 2007-08-09
 o Now setChipType() calls onChipType() too.
 2007-03-19
 o Now the sample tags are written to their own label.
 2007-02-06
 o Updated to <rootPath>/<dataSet>/<tags>/<chipType>/<set>/.
 2007-01-27
 o Created.
 ****************************************************************/
