var $jq = jQuery.noConflict();

var ExplorerSettings = Class.create({
  initialize: function(args) {
    /* Default values */
    this.args = new Hash({
      sample: null,
      chromosome: null, 
      zoom: null
    });

    /* Update by constructor arguments */
    this.importArray(args);
  },

  clear: function() {
		this.set('chipType', null);
		this.set('sample', null);
		this.set('chromosome', null);
		this.set('zoom', null);
  },

  getArray: function() {
    return this.args;
  },

  get: function(key) {
    if (typeof(key) == "undefined")
      throw "Invalid key: " + key;
    var value = this.args[key];
    return value;
  },

  set: function(key, value) {
    if (typeof(key) == "undefined")
      throw "Invalid key: " + key;
    if (typeof(value) == "undefined")
      return false;
    this.args[key] = value;
  },

  /* Update arguments by another Array */
  importArray: function(args) {
		var that = this;
    args = new Hash(args);
    args.each(function(pair) {
			that.set(pair.key, pair.value);
		})
  },

  /* Update arguments by cookies */
  importCookies: function() {
    var that = this;
    this.args.each(function(pair) {
      var value = $jq.cookie(pair.key);
      if (value != null) {
        that.set(pair.key, value);
      }
    });
  },

  /* Update arguments by URL parameters */
  importUrlParameters: function() {
    /* Update arguments by URL parameters */
    var that = this;

    var urlParams = $jq.getUrlParameters();
    this.args.each(function(pair) {
      var value = urlParams[pair.key];
      that.set(pair.key, value);
    });
  },

  load: function() {
    this.importCookies();
    this.importUrlParameters();
  },

  show: function() {
    var args = this.args.collect(function(pair) {
      return pair.key + "=" + pair.value + "<br>";
    });
    var s = '<small><strong>Arguments:</strong><br>' + args + '</small>';
    $jq("#debugSettings").html(s);
  },

  /* Store arguments as cookies */
  save: function() {
    this.show();
    this.args.each(function(pair) {
      $jq.cookie(pair.key, pair.value, {expires: 7});
    });
  },

  toQueryString: function() {
    return this.args.toQueryString();
  }
});


var ChromosomeExplorerSettings = Class.create(ExplorerSettings, {
  getImageFilename: function() {
    var fmt = "%s,chr%02d,x%04d.png";
    var a = this.args;
    var filename = sprintf(fmt, a['sample'], a['chromosome'], a['zoom']);
    return filename;
  },

  getImagePathname: function() {
		var path = this.get('imagePath');
    if (path == null)
      path = "imgs";
    return path + "/" + this.getImageFilename();
  },

  getLinkTo: function() {
    var l = window.location;
    var url = l.protocol + '//' + l.host + l.pathname;
    return url + '?' + this.toQueryString();
  }
});

