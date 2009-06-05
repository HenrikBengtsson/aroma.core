/****************************************************************
 * ChromosomeExplorer()
 *
 * Author: Henrik Bengtsson, hb@stat.berkeley.edu
 ****************************************************************/
var Selector = Class.create({
  initialize: function(name, class) {
		this.name = name;
		this.class = class;
    this.isSelected = true;
    this.hasError = false;
    this.callbacks = new Hash();
	},

	inspect: function() {
		args = new Hash();
    args['name'] = this.name;
    args['class'] = this.class;
    args['isSelected'] = this.isSelected;
    args['callbacks'] = this.callbacks.inspect();
    return "<#Selector: " + args.inspect() + ">";
	},

	getCallback: function(event) {
		return this.callbacks[event] || null;
	},

	setCallback: function(event, fcn) {
		this.callbacks[event] = fcn;
	},

	callback: function(event) {
		var fcn = this.getCallback(event);
    if (fcn == null)
      return false;
    return fcn(this);
	},

	onChange: function() {
 		this.saveToCookie();
		return this.callback('onChange');
	},

	getFullname: function() {
  	var res = this.name;
    if (this.class != null)
      res = res + "," + this.class;
    return res;
	},

	getId: function() {
		var id = this.getFullname();
    id = escape(id);
    return id;
	},


	getSelectorId: function() {
		return "selector_" + this.getId();
	},

	getSelector: function() {
		var id = this.getSelectorId();
    var obj = document.getElementById(id) || null;
    if (obj == null)
      throw("Selector.getSelector(): No such selector: ", id);
    return obj;
	},

	update: function() {
    this.isSelected = (this.isSelected == true || this.isSelected == 'true');

		var id = this.getSelectorId();
    var obj = document.getElementById(id) || null;
    if (obj == null)
      return false;

		if (this.isSelected) {
  		if (this.hasError) {
        obj.style.background = '#ffcc99;';
			} else {
        obj.style.background = '#ccccff;';
			}
		} else {
      obj.style.background = 'none';
		}
	},

	select: function() {
		var oldValue = this.isSelected;
    var value = true;
    if (oldValue != value) {
    	this.isSelected = value;
      this.onChange();
      this.update();
		}
    return this.isSelected;
	},

	unselect: function() {
		var oldValue = this.isSelected;
    var value = false;
    if (oldValue != value) {
    	this.isSelected = value;
      this.onChange();
      this.update();
		}
    return this.isSelected;
	},

	toQueryString: function() {
		return this.getFullname()+"="+this.isSelected;
	},

	toHtmlString: function() {
		alert("ERROR: toHtmlString() is not defined for this Selector class");
	},

	saveToCookie: function() {
		$jq.cookie(this.getId(), this.isSelected, {expires: 7});
	},

	deleteCookie: function() {
	  $jq.cookie(this.getId(), null);
	},

	loadFromCookie: function() {
		var value = $jq.cookie(this.getId());
    if (typeof(value) == "undefined" || value == null)
      return false;
    value = (value == true || value == 'true');
		this.isSelected = value;
	},

	loadFromUrl: function() {
    var params = $jq.getUrlParameters();
    var value = params[this.getFullname()];
    if (typeof(value) == "undefined")
      return false;
    value = (value == true || value == 'true');
  	this.isSelected = value;
	},

	load: function() {
		this.loadFromCookie();
		this.loadFromUrl();
  }
})


var ToggleSelector = Class.create(Selector, {
	toggle: function() {
  	this.isSelected = !this.isSelected;
    this.onChange();
    this.update();
    return this.isSelected;
	},

	toHtmlString: function() {
		var id = this.getSelectorId();
    var html = sprintf('[<span id="%s"><a href="javascript:explorer.toggleLayer(\'%s\');">%s</a></span>]', id, this.getFullname(), this.name);
		return html;
	},
})




var AbstractExplorer = Class.create({
  initialize: function(args) {
		this.reloadCountdown = 21;

    this.layerSelectors = new Array();

    /* All lists */
    this.hashes = new Hash();
    this.arrays = new Hash();
    this.layerArrays = new Hash();

    /* Default settings */
    this.settings = new ChromosomeExplorerSettings();

    /* Update settings from cookies and URL parameters */
    this.settings.load(); 

    /* Update by constructor arguments */
    this.settings.importArray(args);
	},

	findSelector: function(fullname) {
    var res = this.layerSelectors.detect(function(selector) {
			return (selector.getFullname() == fullname);
		})
    return res;
  },

	updateLayers: function() {
		/* Update the layers by calling the onChange() callback
       of all layer selectors. */
			/*
		this.updateLayersByArgs(new Hash({chipType:this.getChipType(), chromosome:this.getChromosome(), sample:this.getSample(), zoom:this.getZoom()}));
			*/
    this.layerSelectors.each(function(selector) {
			selector.onChange();
		})
  },

	loadSelectors: function() {
    this.layerSelectors.each(function(selector) {
			selector.load();
			selector.update();
			selector.onChange();
			selector.update();
		})
  },

  getPersistentSettings: function() {
    var args = new Hash();
    args['chipType'] = this.getChipType();
    args['sample'] = this.getSample();
    args['chromosome'] = this.getChromosome();
    args['zoom'] = this.getZoom();
    args['set'] = this.getSet();
		this.settings.args.each(function(pair) {
			isLayer = (pair.name.indexOf('Layer') != -1);
      if (isLayer) {
        /* Default is always true, i.e. to display a layer, so... */
        if (!pair.value) {
          args[pair.key] = pair.value;
        }
      }
		})
    return args;
  },


  setPersistentSettings: function(args) {
		var that = this;
		['chipType', 'sample', 'chromosome', 'zoom', 'set'].each(function(key) {
      that.settings.set(key, args[key]);
  	})
		/* Layers */
		args.grep('Layer').each(function(pair) {
			that.settings.args[pair.key] = pair.value;
 		})
  },

  /* 
   * Count down reload counter; when reaching zero, the page is reloaded.
   * This is done to workaround memory leaks.
   */
  reload: function() {
    this.settings.save();
    window.location.reload();
    return false;
	},

  countdown: function() {
    this.reloadCountdown = this.reloadCountdown - 1;
    updateLabel('countdownLabel', this.reloadCountdown);
    if (this.reloadCountdown <= 0) {
      this.reload();
      return false;
    } 
  },

  setHash: function(name, value) {
    value = new Hash(value);
    this.hashes[name] = value;
    return value;
	},

  hasHash: function(name) {
    var value = this.hashes[name];
    return (typeof(value) != "undefined" && value != null);
	},

  getHash: function(name) {
    if (!this.hasHash(name))
      return null;
    return this.hashes[name];
	},


  setArray: function(name, value) {
    value = Array.from(value);
    this.arrays[name] = value;
    return value;
	},

  hasArray: function(name) {
    var value = this.arrays[name];
    return (typeof(value) != "undefined" && value != null);
	},

  getArray: function(name) {
    if (!this.hasArray(name))
      return null;
    return this.arrays[name];
	},
}); /* class AbstractExplorer */



var ChromosomeExplorerCore = Class.create(AbstractExplorer, {
  getChipType: function() {
		var value = this.settings.get('chipType');
    if (typeof(value) == "undefined" || value == null) {
      value = this.getArray('chipTypes')[0];
    }
    return value;
	},

  setChipType: function(value) {
		this.settings.set('chipType', value);
		this.updateLayersByArgs(new Hash({chipType:this.getChipType()}));
    this.updateLayers();
	},

  getSet: function() {
		var value = this.settings.get('set');
    if (typeof(value) == "undefined" || value == null) {
      value = this.getArray('sets')[0];
    }
    return value;
	},

  setSet: function(value) {
		this.settings.set('set', value);
    this.updateLayers();
	},

  getImagePath: function() {
		var value = this.settings.get('imagePath');
    if (value == null)
      value = ".";
    return value;
	},

  setImagePath: function(path) {
		this.settings.set('imagePath', path);
	},

  getImageFilename: function() {
    var fmt = "%s,chr%02d,x%04d.png";
    var filename = sprintf(fmt, this.getSample(), this.getChromosome(), this.getZoom());
    return filename;
  },

  getImagePathname: function() {
		var path = this.getImagePath();
    return path + "/" + this.getImageFilename();
  },


  toQueryString: function() {
		var args = this.getPersistentSettings();
    return args.toQueryString();
  },

  getLinkTo: function() {
    var l = window.location;
    var url = l.protocol + '//' + l.host + l.pathname;
    return url + '?' + this.toQueryString();
  },

  getChromosome: function() {
    var value = this.settings.get('chromosome');
    if (typeof(value) == "undefined" || value == null) {
      value = this.getArray('chromosomes')[0];
    }
    return value;
  },

  setChromosome: function(value) {
    this.settings.set('chromosome', value);
		this.updateLayersByArgs(new Hash({chromosome:this.getChromosome()}));
    this.updateLayers();
  },

  getSampleLabel: function() {
    var sample = this.getSample();
    var hash = this.getHash('samples');
    var alias = hash[sample];
    if (alias != null & alias != sample) {
      return alias + ' (' + sample + ')';
    } else {
      return sample;
    }
	},

  getSample: function() {
    var value = this.settings.get('sample');
    if (typeof(value) == "undefined" || value == null) {
      value = this.getHash('samples').keys()[0];
    }
    return value;
  },

  setSample: function(value) {
    this.settings.set('sample', value);
		this.updateLayersByArgs(new Hash({sample:this.getSample()}));
    this.updateLayers();
  },

  getZoom: function() {
    var value = this.settings.get('zoom');
    if (typeof(value) == "undefined" || value == null) {
      value = this.getArray('zooms')[0];
    }
    return value;
  },

  setZoom: function(value) {
    this.settings.set('zoom', value);
		this.updateLayersByArgs(new Hash({zoom:this.getZoom()}));
    this.updateLayers();
  },

  getLocation: function() {
    var value = this.settings.get('relOffset');
    if (typeof(value) == "undefined" || value == null)
      value = 0;
    return value;
  },

  setLocation: function(value) {
		/* Ignore invalid values */
		if (typeof(value) == "undefined" || value == null || isNaN(value))
      return(false);
    if (value < 0) {
      value = 0;
    } else if (value > 1) {
      value = 1;
    }
    this.settings.set('relOffset', value);
  },

  getNavAreaX: function() {
    var value = this.settings.get('navAreaX');
    if (typeof(value) == "undefined" || value == null) {
      value = 0;
    }
    return value;
  },

  setNavAreaX: function(value) {
		/* Ignore invalid values */
		if (typeof(value) == "undefined" || value == null || isNaN(value))
      return(false);
    this.settings.set('navAreaX', value);
  },

  setChromosomes: function(chromosomes) {
 		logAdd("setChromosomes()...");
    var array = this.setArray('chromosomes', chromosomes);
    s = 'Chromosomes: ';
    array.each(function(chromosome, idx) {
			idx = idx + 1;
      var label = "";
      if (chromosome != idx)
        label = "(" + chromosome + ")";
      s += sprintf('[<span id="chromosome%d"><a href="javascript:explorer.setChromosome(%d);">%02d%s</a></span>]', idx, idx, idx, label); 
    })
    updateLabel('chromosomesLabel', s);
 		logAdd("setChromosomes()...done");
    return array;
	},

  setChipTypes: function(chipTypes) {
 		logAdd("setChipTypes()...");
    var array = this.setArray('chipTypes', chipTypes);
    if (array.size() > 0) {
      var s = 'Chip types: ';
      array.each(function(chipType) {
        s += sprintf('[<span id="chipType%s"><a href="javascript:explorer.setChipType(\'%s\');">%s</a></span>]', chipType, chipType, chipType); 
      })
      s += '<br>';
      updateLabel('chipTypeLabel', s);
    }
 		logAdd("setChipTypes()...done");
    return array;
	},

  setZooms: function(zooms) {
 		logAdd("setZooms()...");
    var array = this.setArray('zooms', zooms);
    var s = 'Zoom: ';
    array.each(function(zoom) {
      s += sprintf('[<span id="zoom%d"><a href="javascript:explorer.setZoom(%d);">x%d</a></span>]', zoom, zoom, zoom);
    })
    updateLabel('zoomLabel', s);
 		logAdd("setZooms()...done");
    return array;
	},

  setSets: function(sets) {
 		logAdd("setSets()...");
    var array = this.setArray('sets', sets);
    var s = 'Sets: ';
    array.each(function(set) {
      s += sprintf('[<span id="set%s"><a href="javascript:explorer.setSet(\'%s\');">%s</a></span>]', set, set, set);
    })
    updateLabel('setLabel', s);

 		logAdd("setSets()...done");
    return array;
	},

  setSamples: function(samples) {
 		logAdd("setSamples()...");
    var hash = this.setHash('samples', samples);
    var s = 'Samples: ';
    hash.each(function(pair) {
      var sample = pair.key;
      var alias = pair.value;
      s += sprintf('[<span id="sample%s"><a href="javascript:explorer.setSample(\'%s\');">%s</a></span>]<span style="font-size:1%"> </span>', sample, sample, alias); 
    })
    updateLabel('samplesLabel', s);
 		logAdd("setSamples()...done");
    return hash;
	},

	clear: function() {
		logAdd("clear()...");
    this.settings.clear();
		logAdd("clear()...done");
  },

	load: function() {
		logAdd("load()...");
    this.settings.load();
		logAdd("load()...done");
	},

	save: function() {
		logAdd("save()...");
    this.settings.save();
		logAdd("save()...done");
  },

  getLayerArray: function(class) {
    return this.layerArrays[class] || new Array();
	},

	setLayerArray: function(class, array) {
    this.layerArrays[class] = array;
	},

	getLayerStatuses: function(field) {
		var res = new Hash();
		this.layerArrays.each(function(pair) {
			var values = new Hash();
      pair.value.each(function(layer) {
				var key = layer.getFullname();
        values[key] = layer[field];
   	  })
      res[pair.key] = values;
    })
		return res;
	},

	getLayersQString: function(field) {
		var s = "";
		this.layerArrays.each(function(pair) {
      pair.value.each(function(layer) {
        var value = layer.getFullname() + "=" + layer[field];
        s = s + "&" + value;
   	  })
    })
		return s;
	},

	setLayers: function(names, class, label) {
		logAdd("setLayers()...");
    /* Nothing to do? */
    if (names.size() == 0)
      return(false);


    var that = this;    

    var layerArray = new Array();
    names.collect(function(name) {
			var selector = new ToggleSelector(name, class);

			var layer = new ExplorerImageLayer(name, class);
      layerArray[layerArray.size()] = layer;

      selector.layer = layer;
      selector.setCallback("onChange", function(selector) {
			  var layer = selector.layer;
  		  layer.setStatus(selector.isSelected);

        /* Let selector have error status until an image is loaded. */
        layer.setCallback('onChange', function(obj) {
					obj.setCallback('onChange', null);
          selector.hasError = true;
          selector.update();
				})

        layer.setCallback('onLoad', function(obj) {
					obj.setCallback('onLoad', null);
          selector.hasError = false;
          if (selector.isSelected) {
            var img = obj.getImage("panel");
            img.style.visibility = 'visible';
					}
					selector.update();
				})

        layer.update();
  		})
      that.layerSelectors[that.layerSelectors.size()] = selector;
  	});

		$jq("#debugWindow").html("<small>"+layerArray.inspect()+"</small>");	

    var s = label + ': ';
    var pimgs = '';
    var nimgs = '';
    var res = layerArray.each(function(obj) {
      var selector = new ToggleSelector(obj.name, obj.tags);
      s = s + '<span style="font-size:1%;"> </span>' + selector.toHtmlString();
      pimgs = pimgs + obj.getPanelImageHtml();
      nimgs = nimgs + obj.getNavigatorImageHtml();
		});

    updateLabel(class + 'Labels', s);
    updateLabel(class + 's', pimgs);
    updateLabel('navigator' + class + 's', nimgs);

    this.setLayerArray(class, layerArray);
		logAdd("setLayers()...done");
	},

	updateImages: function() {
		logAdd("updateImages()...");
     /* Update images with an ID, because they are the only one that
        are loaded dynamically. */
		$jq("img[@id]").each(function() {
			var isLoaded = this.isLoaded || false;
      if (!isLoaded) {
        this.style.visibility = 'hidden';
        return false;
      }
      
      var isSelected = false;
      var id = this.id || null;
      if (id != null) {
  			id = this.id.replace(/.*ImageLayer/,"");
        var selectorId = "layer" + id;
        var selector = document.getElementById(selectorId) || null;
		  	if (selector != null) {
          isSelected = selector.isSelected;
        } else {
          isSelected = false;
        }
        logAdd(this.id + ":" + id + ":" + selectorId + "=" + isSelected);
      }
			if (isSelected) {
        this.style.visibility = 'visible';
      } else {
        this.style.visibility = 'hidden';
			}
  	})
		logAdd("updateImages()...done");
  },

  updateLayersByArgs: function(args) {
		var that = this;
		['chrLayer', 'sampleLayer'].each(function(class) {
      var layerArray = that.getLayerArray(class);
      args.each(function(pair) {
        layerArray.each(function(layer) {
  				layer.args[pair.key] = pair.value;
  			})
    	})
		})
	},

  loadLayers: function(class, where) {
    logAdd("loadLayers()...");
    var sample = this.getSample();
    var chromosome = this.getChromosome();
    var chipType = this.getChipType();
    var zoom = this.getZoom();
    if (where == "navigator")
      zoom = 4;

		this.updateLayersByArgs(new Hash({chipType:chipType, chromosome:chromosome, sample:sample, zoom:zoom}));

    this.layerSelectors.each(function(selector) {
      if (selector.class != class)
				 return false;
      var layer = selector.layer;
      /* Let selector have error status until an image is loaded. */
      layer.setCallback('onChange', function(obj) {
   			obj.setCallback('onChange', null);
        selector.hasError = true;
        selector.update();
			})
      layer.setCallback('onLoad', function(obj) {
			  obj.setCallback('onLoad', null);
        selector.hasError = false;
        if (selector.isSelected) {
          var img = obj.getImage("panel");
          img.style.visibility = 'visible';
				}
				selector.update();
			})
		});

    var layerArray = this.getLayerArray(class);
    layerArray.each(function(layer) {
      var pathname = layer.getImagePathname();
      layer.loadImage(pathname, where);
		});
    logAdd("loadLayers()...done");
  },

  getLayerClass: function(fullname) {
    var class = null;
    ['chrLayer', 'sampleLayer'].each(function(layer) {
			if (fullname.indexOf(layer) != -1)
				class = layer;
  	});
    return class;
  },

  getLayer: function(fullname) {
 		logAdd("getLayer()...");
    var class = this.getLayerClass(fullname);
    if (class == null)
      alert("ERROR: No such layer class: " + class);
     var layerArray = this.getLayerArray(class);
    var layer = layerArray.detect(function(layer) {
 		  return (layer.getFullname() == fullname);
	  });
    if (layer == null)
      alert("ERROR: No such ImageLayer: " + fullname);
 		logAdd("getLayer()...done");
    return layer;
  }

}); /* class ChromosomeExplorerCore */




function ChromosomeExplorer() {
  /************************************************************************
   * Methods for setting up chip types, samples, zooms, and sets
   ************************************************************************/ 
  this.setChromosomes = function(chromosomes) {
    this._explorer.setChromosomes(chromosomes);
  }

  this.setChipTypes = function(chipTypes) {
    this._explorer.setChipTypes(chipTypes);
  }

  this.setZooms = function(zooms) {
    this._explorer.setZooms(zooms);
  }

  this.setSets = function(sets) {
    this._explorer.setSets(sets);
  }

  this.setSamples = function(samples) {
    this._explorer.setSamples(samples);
  }

  this.setSampleLayers = function(names) {
    this._explorer.setLayers(names, 'sampleLayer', 'Layers');
  }

  this.setChromosomeLayers = function(names) {
    this._explorer.setLayers(names, 'chrLayer', 'Annotations');
  }


  /************************************************************************
   * Methods for changing chip type, sample, set & zoom
   ************************************************************************/ 
  this.setChipType = function(chipType) {
		logAdd("setChipType("+chipType+")...");
    var oldChipType = this._explorer.getChipType();
    if (oldChipType != chipType) {
      unselectById('chipType' + oldChipType);
      this.loadCount = 2;
      this.setStatus('wait');
      this._explorer.setChipType(chipType);
      selectById('chipType' + chipType);
      this.updatePanel();
      this.updateNavigator();
      this._explorer.save();
    }
		logAdd("setChipType("+chipType+")...done");
  }

  this.setSet = function(set) {
		logAdd("setSet("+set+")...");
    var oldSet = this._explorer.getSet();
    if (oldSet != set) {
      unselectById('set' + oldSet);
      this.loadCount = 2;
      this.setStatus('wait');
      this._explorer.setSet(set);
      selectById('set' + set);
      this.updatePanel();
      this.updateNavigator();
      this._explorer.save();
    }
		logAdd("setSet("+set+")...done");
  }

  this.setChromosome = function(chromosome) {
		logAdd("setChromosome("+chromosome+")...");
    var oldChromosome = this._explorer.getChromosome();
    if (oldChromosome != chromosome) {
      unselectById('chromosome' + oldChromosome);
      this.loadCount = 2;
      this.setStatus('wait');
      this._explorer.setChromosome(chromosome);
      selectById('chromosome' + chromosome);
      this.updatePanel();
      this.updateNavigator();
      this._explorer.save();
    }
		logAdd("setChromosome("+chromosome+")...done");
  }

  this.setZoom = function(zoom) {
		logAdd("setZoom("+zoom+")...");
    var oldZoom = this._explorer.getZoom();
    if (oldZoom != zoom) {
      unselectById('zoom' + oldZoom);
      this.loadCount = 1;
			/* HIDE
      this.setStatus('wait');
			*/
      this._explorer.setZoom(zoom);
      selectById('zoom' + zoom);
      this.updatePanel();
      this._explorer.save();
    }
		logAdd("setZoom("+zoom+")...done");
  }

  this.setSample = function(sample) {
		logAdd("setSample("+sample+")...");
    var oldSample = this._explorer.getSample();
    if (oldSample != sample) {
      unselectById('sample' + oldSample);
      this.loadCount = 2;
      this.setStatus('wait');
      this._explorer.setSample(sample);
      selectById('sample' + sample);
      this.updatePanel();
      this.updateNavigator();
      this._explorer.save();
    }
		logAdd("setSample("+sample+")...done");
  }

  this.toggleLayer = function(fullname) {
    var selector = this._explorer.findSelector(fullname);
    selector.toggle();
    this.updateInfo();
  }


  /************************************************************************
   * Methods for updating the display
   ************************************************************************/ 
  this.showIndicator = function(state) {
 		logAdd("showIndicator()...");
    var statusImage = document.getElementById("statusImage");
    if (state) {
      statusImage.style.visibility = 'visible';
    } else {
      statusImage.style.visibility = 'hidden';
    }
 		logAdd("showIndicator()...done");
  }

  this.setStatus = function(state) {
		logAdd("setStatus("+state+")...");
    navImage = document.getElementById("navigatorImage");
    panelImage = document.getElementById("panelImage");

    if (state == "") {
/*      $jq.unblockUI(); */
      this.showIndicator(false);
      navImage.style.filter = "alpha(opacity=50)";
      navImage.style.opacity = 0.50;
      panelImage.style.filter = "alpha(opacity=100)";
      panelImage.style.opacity = 1.0;
      this.updateInfo();
    } else if (state == "wait") {

/*      $jq.blockUI(); */
      this.showIndicator(true);
      navImage.style.filter = "alpha(opacity=20)";
      navImage.style.opacity = 0.20;
      panelImage.style.filter = "alpha(opacity=50)";
      panelImage.style.opacity = 0.50;
    }
		logAdd("setStatus("+state+")...done");
  }

  this.updateInfo = function() {
		logAdd("updateInfo()...");
    var chromosome = this._explorer.getChromosome();
    updateLabel('chromosomeLabel', chromosome);
    var label = this._explorer.getSampleLabel();
    updateLabel('sampleLabel', label);

    var url = this._explorer.getLinkTo();
    label = sprintf('<a href="%s">ThisURL</a>', url);
    updateLabel('linkToLabel', label);

		this._explorer.updateImages();
		logAdd("updateInfo()...done");
  }

  

  /************************************************************************
   * Misc
   ************************************************************************/ 
  this.getImagePathname = function() {
    logAdd("getImagePathname()...");
    var chipType = this._explorer.getChipType();
    var set = this._explorer.getSet();
    var imgName = this._explorer.getImageFilename();
    var pathname = (chipType + '/' + set + '/' + imgName);
    logAdd("getImagePathname()...done");
    return pathname;
  }

  this.update = function() {
		logAdd("update()...");
    this.updateGlobals();
    this.updatePanel();
    this.updateNavigator();
    this.updateNavigatorWidth();
		logAdd("update()...done");
  }

  this.updateGlobals = function() {
		logAdd("updateGlobals()...");
    panelWidth = panel.clientWidth;
    panelMaxWidth = panel.scrollWidth;
    navImageOffsetX = findXY(navImage).x;
    panelImageWidth = panelImage.clientWidth;
    panelImageOffsetX = findXY(panelImage).x;
    navImageWidth = navImage.clientWidth;
    navAreaWidth = navImageWidth * (panelWidth / panelMaxWidth);
		logAdd("updateGlobals()...done");
  }

  this.locatorUpdated = function() {
		logAdd("locatorUpdated()...");

    /* Update locator tag */
    var pixelsPerMb = 3; /* /1.0014; */
    var xPx = findXY(panelLocator).x - findXY(panelImage).x + parseFloat(panel.scrollLeft);
    var zoom = this._explorer.getZoom();
    var xMb = (xPx-50)/(zoom*pixelsPerMb);
    var tag = Math.round(100*xMb)/100 + 'Mb';
    updateText(panelLocatorTag, tag);
  
    var url;

    var sample = this._explorer.getSample();
    var chromosome = this._explorer.getChromosome();
    var chipType = this._explorer.getChipType();
    var zoom = this._explorer.getZoom();
    var set = this._explorer.getSet();

    /* Update CNR link */
    if (this.cnrUrl != null) {
      url = chipType + '/' + set + '/' + 'regions.xls';
      this.cnrUrl.href = url;
      updateText(this.cnrUrl, url);
    }

		logAdd("locatorUpdated()...done");
  }


  this.setGlobalCursor = function(status) {
    panel.style.cursor = status;
    panelImage.style.cursor = status;
    nav.style.cursor = status;
    navImage.style.cursor = status;
    navArea.style.cursor = status;
  }

  this.reset = function() {
    this._explorer.clear();
    this._explorer.save();
    reload();
  }
  
  this.reload = function() {
    this._explorer.reload();
  }
  

  /************************************************************************
   * Main
   ************************************************************************/ 
  this._explorer = new ChromosomeExplorerCore();

  this.loadCount = 0;
  this.imageUrl = null;
  this.cnrUrl = null;

  this.setupEventHandlers = function() {
		logAdd("setupEventHandlers()...");

    var owner = this;

    /*******************************************************
     * chromosomePanel
     *******************************************************/
    panel = document.getElementById("panel");
    panelLocator = document.getElementById('panelLocator');
    panelLocatorTag = document.getElementById('panelLocatorTag');
  
    panelOnScroll = function() {
   		logAdd("panelOnScroll()...");
      relOffset = panel.scrollLeft / panelMaxWidth;
      owner._explorer.setLocation(relOffset);
      var navAreaX = relOffset * navImageWidth;
      owner._explorer.setNavAreaX(navAreaX);
      owner.navAreaUpdate();
   		logAdd("panelOnScroll()...done");
    }
  
    panel.onscroll = panelOnScroll;
  
    panelImage = document.getElementById('panelImage');
    panelImageLayers = document.getElementById('panelImageLayers');
  
    var panelLocatorIsLocked = true;
  
    panelImageLayers.ondblclick = function() {
      logAdd("panelImageLayers.ondblclick()...");
      panelLocatorIsLocked = false;
      panelImageLayers.onmousedown = null;
      var e = arguments[0] || event;
      mouseX = e.clientX;
      panelLocator.style.left = (mouseX-2) + "px";
      owner.locatorUpdated();
      logAdd("panelImageLayers.ondblclick()...done");
    }
    panelLocator.ondblclick = panelImageLayers.ondblclick;
  
    panelImageLayers.onclick = function() {
      logAdd("panelImageLayers.onclick()...");
      panelLocatorIsLocked = true;
      panelImageLayers.onmousedown = panelImageLayersOnMouseDown;
      logAdd("panelImageLayers.onclick()...done");
    }
    panelLocator.onclick = panelImageLayers.onclick;
  
    panelImageLayersOnMouseMove = function() {
      logAdd("panelImageLayersOnMouseMove()...");
      if (!panelLocatorIsLocked) {
        var e = arguments[0] || event;
        mouseX = e.clientX;
        panelLocator.style.left = (mouseX-2) + "px";
        owner.locatorUpdated();
      }
      logAdd("panelImageLayersOnMouseMove()...done");
      return false;
    }

    panelImageLayers.onmousemove = panelImageLayersOnMouseMove;
  
    panelImageLayersOnMouseDown = function() {
      logAdd("panelImageLayersOnMouseDown()...");
      var e = arguments[0] || event;
      var x = panel.scrollLeft + e.clientX;
      owner.setGlobalCursor("move");
      panel.onscroll = null;
      panelImageLayers.onmousemove = null;
  
      document.onmousemove = function() {
        var e = arguments[0] || event;
        isMoving = true;
        panel.scrollLeft = x - e.clientX;
        owner.panelUpdated();
        return false;
      }
  
      document.onmouseup = function() {
        document.onmouseup = null;
        document.onmousemove = null;
        panel.onscroll = panelOnScroll;
        panelImageLayers.onmousemove = panelImageLayersOnMouseMove;
  //      panelLocatorIsLocked = false;
        owner.setGlobalCursor("default");
        return false;
      }
  
      logAdd("panelImageLayersOnMouseDown()...done");
      return false;
    }
  
    panelImageLayers.onmousedown = panelImageLayersOnMouseDown;

    /*******************************************************
     * chromosomeNavigator
     *******************************************************/
    nav = document.getElementById('navigator');
    navImage = document.getElementById('navigatorImage');
    navImageLayers = document.getElementById("navigatorImageLayers");
    navArea = document.getElementById('navigatorArea');

    /* Mouse state: (mouseDown, mouseX) */
    var mouseX = 0;
    var mouseDown = false;
  
    /* Immitate onmousepress, which does not exists */
    navImageLayers.onmousepress = function() {
      logAdd("navImageLayers.onmousepress()...");
      if (mouseDown) {
        var navAreaX = owner._explorer.getNavAreaX();
        if (mouseX < navAreaX) {
          owner.navAreaMove(navAreaX - 0.47*navAreaWidth);
        } else if (mouseX > navAreaX + 1*navAreaWidth) {
          owner.navAreaMove(navAreaX + 1.47*navAreaWidth);
        } else {
          owner.navAreaMove(mouseX);
        }
        setTimeout('navImageLayers.onmousepress();', 100);
      }
      logAdd("navImageLayers.onmousepress()...done");
      return false;
    }
  
    navImageLayers.onmousedown = function() {
      logAdd("navImageLayers.onmousedown()...");
      var e = arguments[0] || event;
      mouseDown = true;
      owner.updateGlobals();
      mouseX = (e.clientX - navImageOffsetX);
      var navAreaX = owner._explorer.getNavAreaX();
      if (mouseX < navAreaX) {
        owner.navAreaMove(navAreaX - 0.47*navAreaWidth);
        } else if (mouseX > navAreaX + 1*navAreaWidth) {
        owner.navAreaMove(navAreaX + 1.47*navAreaWidth);
      }
  
      setTimeout('navImageLayers.onmousepress();', 500);
  
      document.onmouseup = function() {
        document.onmouseup = null;
        navImageLayers.onmousemove = null;
        mouseDown = false;
        /* Save current location */
        owner._explorer.save();
        return false;
      }
  
      navImageLayers.onmousemove = function() {
        var e = arguments[0] || event;
        mouseX = (e.clientX - navImageOffsetX);
        return false;
      }
  
      logAdd("navImageLayers.onmousedown()...done");
      return false;
    }
  
    navArea.onmousedown = function() {
      var e = arguments[0] || event;
      owner.setGlobalCursor("move");
      panel.onscroll = null;
      owner.updateGlobals();
      mouseX = (e.clientX - navImageOffsetX);
      var navAreaX = owner._explorer.getNavAreaX();
      var dx = navAreaWidth/2 + (navAreaX - mouseX);
      owner.navAreaMove(mouseX + dx);
  
      document.onmousemove = function() {
        var e = arguments[0] || event;
        mouseX = (e.clientX - navImageOffsetX);
        owner.navAreaMove(mouseX + dx);
        return false;
      }
  
      document.onmouseup = function() {
        document.onmousemove = null;
        panel.onscroll = panelOnScroll;
        owner.setGlobalCursor("default");
        return false;
      }
      return false;
    }
		logAdd("setupEventHandlers()...done");
  }

  this.start = function() {
		logAdd("start()...");

    /* Default settings */
    this._explorer.setNavAreaX(0);
    this._explorer.setLocation(0);

    /* Update settings by URL parameters */
    this._explorer.load();

    /*******************************************************
     * Set the current sample
     *******************************************************/
    var sample = this._explorer.getSample();
    selectById('sample' + sample);
  
    var chipType = this._explorer.getChipType();
    selectById('chipType' + chipType);
  
    var set = this._explorer.getSet();
    selectById('set' + set);

    var chromosome = this._explorer.getChromosome();
    selectById('chromosome' + chromosome);

    var zoom = this._explorer.getZoom();
    selectById('zoom' + zoom);
  
    this.imageUrl = document.getElementById('imageUrl') || null;
    this.cnrUrl = document.getElementById('cnrUrl') || null;

    this._explorer.loadSelectors();

    this.setupEventHandlers();
  
    this.updateNavigator();
    this.navAreaUpdate();
    this.updatePanel();
    this.setStatus('');
    webcutsOptions['numberLinks'] = false;
    setTimeout('explorer.navAreaUpdate();', 1000);

		logAdd("start()...done");
  }

  this.getNavAreaWidth = function() {
    var value = navAreaWidth;
    if (typeof(value) == "undefined") {
      this.updateNavigatorWidth();
      value = navAreaWidth;
      if (typeof(value) == "undefined")
        value = null;
    }
    return value;
  }

  this.navAreaUpdate = function() {
 		logAdd("navAreaUpdate()...");

		/*
    this._explorer.settings.show();
    */
    navAreaWidth = this.getNavAreaWidth();
    if (typeof(navAreaWidth) == "undefined" || typeof(navImageWidth) == "undefined")
      return(false);

    var navAreaX = this._explorer.getNavAreaX();
    if (navAreaX < 0) {
      navAreaX = 0;
    } else if (navAreaX + navAreaWidth > navImageWidth) {
      navAreaX = navImageWidth - navAreaWidth;
    }
    this._explorer.setNavAreaX(navAreaX);
		/*
    this._explorer.settings.show();
		*/

    navArea.style.width = navAreaWidth + "px";
    navArea.style.left = (navAreaX + navImageOffsetX) + "px";
		/*
    this.locatorUpdated();
		*/

 		logAdd("navAreaUpdate()...done");
  }

  this.navAreaMove = function(midX) {
 		logAdd("navAreaMove()...");
    navAreaWidth = this.getNavAreaWidth();
    var navAreaX = midX - navAreaWidth/2;
    this._explorer.setNavAreaX(navAreaX);
    this.navAreaUpdate();
    this.panelMove(navAreaX/navImageWidth);
 		logAdd("navAreaMove()...done");
  }

  this.navAreaMoveRel = function(relX) {
    logAdd("navAreaMoveRel()...");
    if (!isNaN(relX) && typeof(relX) != "undefined")
      this.navAreaMove(relX * navImageWidth);
    logAdd("navAreaMoveRel()...done");
  }

  this.panelMove = function(relOffset) {
 		logAdd("panelMove()...");
    this._explorer.setLocation(relOffset);
    var panelX = relOffset*panelMaxWidth;
    if (panelX < 0)
      panelX = 0;
    panel.scrollLeft = panelX;
    relOffset = panel.scrollLeft / panelMaxWidth;
    this._explorer.setLocation(relOffset);
 		logAdd("panelMove()...done");
  }

  this.panelUpdated = function() {
 		logAdd("panelUpdated()...");
    this.updateGlobals();
    relOffset = panel.scrollLeft / panelMaxWidth;
    this._explorer.setLocation(relOffset);
    var navAreaX = relOffset * navImageWidth;
    this._explorer.setNavAreaX(navAreaX);
    this.navAreaUpdate();
    this.locatorUpdated();
 		logAdd("panelUpdated()...done");
  }

  this.updatePanel = function() {
		logAdd("updatePanel()...");
    var navAreaX = this._explorer.getNavAreaX();
    navAreaWidth = this.getNavAreaWidth();
    var navAreaRelMidX = (navAreaX + navAreaWidth/2) / navImageWidth;

    /* Update layers */
    var that = this;
    ['chrLayer', 'sampleLayer'].each(function(class) {
      that._explorer.loadLayers(class, 'panel');
    });

    var pathname = null;
    var set = this._explorer.getSet();
    if (set == "-LAYERS-") {
      pathname = "../../includes/images/pixelWhite.png";
    } else {
      pathname = this.getImagePathname();
    }

    var panelImage = document.getElementById('panelImage');

    /* First blank it */
    panelImage.onload = function() {};

    var owner = this;
    panelImage.onload = function() {
      logAdd("panelImage.onload()...");
      this.isLoaded = true;
      owner.updateNavigatorWidth();
      owner.updateGlobals();
      owner.navAreaMoveRel(navAreaRelMidX);
      owner.loadCount = owner.loadCount - 1;
      if (owner.loadCount <= 0) {
        owner.loadCount = 0;
        owner.setStatus("");
      }
      panelImageOnLoad();
      panelImageOnLoad = function() {};
      owner.navAreaUpdate();
      owner._explorer.countdown();
      owner = null;
      logAdd("panelImage.onload()...done");
    }

    panelImage.isLoaded = false;
    panelImage.src = pathname;

    this.imageUrl.href = pathname;
    updateText(this.imageUrl, pathname);

    /* Update the title of the page */
    var title = location.href;
    title = title.substring(0, title.lastIndexOf('\/'));
    title = title.substring(title.lastIndexOf('\/')+1);
    title = title + '/' + pathname;
    document.title = title;
		logAdd("updatePanel()...done");
  }

  this.updateNavigator = function() {
		logAdd("updateNavigator()...");
    var owner = this;

    /* Update layers */
		logAdd("Update layers...");
    this._explorer.loadLayers('chrLayer', 'navigator');
    this._explorer.loadLayers('sampleLayer', 'navigator');
		logAdd("Update layers...done");

    var pathname = null;
    var set = this._explorer.getSet();
    if (set == "-LAYERS-") {
      pathname = "../../includes/images/pixelWhite.png";
    } else {
      pathname = this.getImagePathname();
    }

    navImage = document.getElementById("navigatorImage");

    navImage.onload = function() {
      logAdd("navImage.onload()...");
      this.isLoaded = true;
      owner.loadCount = owner.loadCount - 1;
      if (owner.loadCount <= 0) {
        owner.loadCount = 0;
        owner.setStatus("");
      }
      owner.navAreaUpdate();
      logAdd("navImage.onload()...done");
    }

    navImage.isLoaded = false;
    navImage.src = pathname;
		logAdd("updateNavigator()...done");
  } // updateNavigator()


  this.getChromosomeLengths = function() {
    var lens = this.lens || null;
    if (lens == null) {
      lens = new Array(3840, 3798, 3119, 2993, 2826, 2673, 2482, 2288, 2165, 2117, 2104, 2071, 1785, 1664, 1568, 1387, 1230, 1191, 998, 976, 733, 774, 2417);
    }
		return lens;
  }

  this.updateNavigatorWidth = function() {
 		logAdd("updateNavigatorWidth()...");
    var chromosome = this._explorer.getChromosome();
    var lens = this.getChromosomeLengths();
    var relWidth = lens[chromosome] / lens.max();
    navImageWidth = Math.round(relWidth * nav.clientWidth);
    navAreaWidth = navImageWidth;
    var width = navImageWidth  + "px";
    navImage.style.width = width;
    var that = this;
    ['chrLayer', 'sampleLayer'].each(function(class) {
 		  var layerArray = that._explorer.getLayerArray(class);
      layerArray.each(function(layer) {
	  		var img = layer.getImage("navigator");
        img.style.width = width;
  		});
		});
 		logAdd("updateNavigatorWidth()...done");
  }
  
  this.onLoad = function() { }
} /* ChromosomeExplorer */


/****************************************************************
 HISTORY:
 2007-10-14
 o Starting to make use of 'jQuery' and 'prototype'.
 2007-10-10
 o Added support for image layer.
 2007-09-04
 o Added support for (model) "sets", e.g. 'glad', 'cbs'.
 2007-03-06
 o BUG FIX: Missing update() method.
 2007-02-20
 o Updated to <rootPath>/<dataSet>/<tags>/<chipType>/<set>/.
 o Created from old ChromosomeExplorer.js making it more of the
   style of class ArrayExplorer.
 ****************************************************************/
