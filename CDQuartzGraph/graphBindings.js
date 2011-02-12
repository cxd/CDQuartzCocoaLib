/**

 The graph bindings script is used to interpret a json object
 and manipulate an existing graph.
 
 The JSON object is used to specify the graph data structure.

**/

var graph = window.Graph;

/**
 Add a node to the graph.
 **/
function addNodeWithName(name) {
	graph.addNodeWithName(name);
}

/**
 Connect two nodes togethor.
 **/
function connectNodeToTarget(name, target) {
	graph.connectNodeToTarget(name, target);
}

/**
 Create a shape instance.
 **/
function makeShapeInstance() {
	return graph.makeShapeInstance();
}

/**
 Set the shape given the supplied name.
 **/
function setShapeForName(shape, name) {
	graph.setShapeForName(shape, name);
}

/**
 Use the json string to generate the graph.
 **/
function parseFromJSON(jsonString) {
	parseGraphObject(window.JSON.parse(jsonString));
}

/**
 Process the ecmascript object using 
 **/
function parseGraphObject(graphObject) {
	
	processGraphNodes(graphObject);
	
}
/**
 Add all nodes defined in the graph object.
 **/
function processGraphNodes(graphObject) {
	for(var obj in graphObject.nodes) {
		
		if (typeof(obj.node) == 'undefined')
			continue;
		
		graph.addNodeWithName(obj.node);
		
		var shape = graph.makeShapeInstance();
		
		if (typeof(obj.color) != 'undefined') {
			shape.color = obj.color;
		} else {
			shape.color = "rgb(1.0, 1.0, 1.0)";
		}
		
		if (typeof(obj.outlineColor) != 'undefined') {
			shape.outlineColor = obj.outlineColor;
		} else {
			shape.outlineColor = "rgb(1.0, 1.0, 1.0)";	
		}
		
		if (typeof(obj.width) != 'undefined') {
			shape.bounds.width = parseFloat(obj.width);
		} else {
			shape.bounds.width = 100.0f;
		}
		
		if (typeof(obj.height) != 'undefined') {
			shape.bounds.height = parseFloat(obj.height);
		} else {
			shape.bounds.height = 50.0f;
		}
		
		
		if (typeof(obj.x) != 'undefined') {
			shape.bounds.x = parseFloat(obj.x);
		} else {
			shape.bounds.x = 50.0f;
		}
		
		if (typeof(obj.y) != 'undefined') {
			shape.bounds.y = parseFloat(obj.y);
		} else {
			shape.bounds.y = 50.0f;
		}
		
		if (typeof(obj.shapeType) != 'undefined') {
			shape.shapeType = obj.shapeType;
		} else {
			shape.shapeType = 'CURVED_RECT';	
		}
		
		graph.setShapeForName(shape, obj.node);
		
	}
}

/**
 Connect the edges.
 **/
function processEdges(graphObject) {

	for(var edge in graphObject.edges) {
		
		graphObject.connectNodeToTarget(edge.from, edge.to);
		
	}
	
}
