function createEditor(config) {
	var editor = null;
	
	var hideSplash = function() {
		// Fades-out the splash screen
		var splash = document.getElementById('splash');
		
		if (splash != null)
		{
			try
			{
				mxEvent.release(splash);
				mxEffects.fadeOut(splash, 100, true);
			}
			catch (e)
			{
				splash.parentNode.removeChild(splash);
			}
		}
	};
	
	try {
		if (!mxClient.isBrowserSupported()) {
			mxUtils.error('Browser is not supported!', 200, false);
		} else {
			mxObjectCodec.allowEval = true;
			var node = mxUtils.load(config).getDocumentElement();
			editor = new mxEditor(node);
			mxObjectCodec.allowEval = false;
			
			// Adds active border for panning inside the container
			editor.graph.createPanningManager = function() {
				var pm = new mxPanningManager(this);
				pm.border = 30;
				
				return pm;
			};
			
			editor.graph.allowAutoPanning = true;
			editor.graph.timerAutoScroll = true;
			
			// Updates the window title after opening new files
			var title = document.title;
			var funct = function(sender) {
				document.title = title + ' - ' + sender.getTitle();
			};
			
			editor.addListener(mxEvent.OPEN, funct);
			
			// Prints the current root in the window title if the
			// current root of the graph changes (drilling).
			editor.addListener(mxEvent.ROOT, funct);
			funct(editor);
			
			// Displays version in statusbar
			editor.setStatus('mxGraph '+mxClient.VERSION);

			// Shows the application
			hideSplash();

			editor.open(TREE_XML_URL + '?' + new Date().getTime());
      
      var bounds = editor.graph.view.getGraphBounds();
      var container = $("#graph");
      
      // position root node on top center
      editor.graph.view.setTranslate(-bounds.x - (bounds.width - container.width() ) / 2, -bounds.y + 150);

		}
	} catch (e) {
		hideSplash();

		// Shows an error message if the editor cannot start
		mxUtils.alert('Cannot start application: ' + e.message);
		throw e; // for debugging
	}
	return editor;
}

function waitForTextReadComplete(reader) {
  reader.onloadend = function(event) {
    var text = event.target.result;
  	var doc = mxUtils.parseXml(text);
	  var codec = new mxCodec(doc);
	  var graph = editor.graph;
	  codec.decode(doc.documentElement, graph.getModel());
	}
}

function getRoots(editor){

  var cells = editor.graph.getChildVertices(editor.graph.getDefaultParent());
  var roots = [];
  for (var i = 0; i < cells.length; i++) {
    var cell = cells[i];
    var edges = cell.edges;

    var inboundCount = 0;
    if (edges != null) {
      for (var j = 0; j < edges.length; j++) {
        var edge = edges[j];
        if (edge.target == cell) {
          inboundCount++;
        }
      }
    }
    if (inboundCount == 0){
      roots.push(cell);
    }
  }
  return roots;
}