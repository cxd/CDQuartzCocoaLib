//
//  CDGraphViewState.h
//  CDQuartzGraph
//
//  Created by Chris Davey on 14/09/10.
//  Copyright 2010 none. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CDQuartzGraphHeader.h"
#import "CDQuartzGraph.h"
#import "CDQuartzNode.h"
#import "CDQuartzEdge.h"


#import "ShapeDelegate.h"
#import "Drawable.h"

#import "AbstractGraphShape.h"
#import "AbstractNodeShape.h"
#import "AbstractConnectorShape.h"

#import "GraphLayoutAlgorithm.h"

#import "TrackedNode.h"
#import "TrackedEdge.h"

@protocol CDGraphViewOperation;

@interface CDGraphViewState : NSObject {
	/**
	 Internal graph instance.
	 **/
	CDQuartzGraph *graph;
	
	/**
	A collection of nodes that are currently tracked.
	**/
	NSMutableArray *trackNodes;
	
	/**
	 A set of points that are stored when the user hovers over a shape.
	 **/
	NSMutableArray *hoverPoints;
	
	/**
	 A collection of points that are currently assigned.
	 **/
	NSMutableArray *trackPoints;
	
	/**
	 A collection of edges that are currently 
	 eligible for manipulation by the mouse cursor.
	 **/
	NSMutableArray *selectEdges;
	
	/**
	 A collection of edges that are not connected to any objects in the graph.
	 **/
	NSMutableArray *detachedEdges;
	
	/**
	 The graph layout algorithm.
	 **/
	id<GraphLayoutAlgorithm> algorithm;
	
	/**
	 Internal state transition graph.
	 **/
	CDGraph* transitions;
	
	/**
	 A flag to indicate whether the current operation should be cancelled.
	 **/
	BOOL isCancelled;
	
	/**
	 A flag to indicate whether the current operation should delete.
	 **/
	BOOL shouldDelete;
	
	/**
	 The new node that has been added to the graph.
	 **/
	CDQuartzNode *newNode;
	
	/**
	 The current active operation.
	 **/
	CDNode *current;
	
	/**
	 The bounds of the space in which the graph is visible.
	 **/
	QRectangle *bounds;
	
	/**
	 A flag use to determine whether the state should be redrawn.
	 **/
	BOOL redraw;
	
	/**
	 A flag to indicate whether the connections are being edited.
	 **/
	BOOL editConnections;
	
	/**
	 A flag used to indicate that editing is active.
	 **/
	BOOL isEditing;
}

/**
 Internal graph instance.
 **/
@property(retain) CDQuartzGraph *graph;

/**
 A collection of nodes that are currently tracked.
 **/
@property(retain) NSMutableArray *trackNodes;


/**
 A set of points that are stored when the user hovers over a shape.
 **/
@property(retain) NSMutableArray *hoverPoints;

/**
 A collection of edges that are currently 
 eligible for manipulation by the mouse cursor.
 **/
@property(retain) NSMutableArray *selectEdges;

/**
 A collection of edges that are not connected to any objects in the graph.
 **/
@property(retain) NSMutableArray *detachedEdges;

/**
 A reference to a graph layout algorithm.
 **/
@property(retain) id<GraphLayoutAlgorithm> algorithm;


/**
 A flag to indicate whether the current operation should be cancelled.
 **/
@property(assign) BOOL isCancelled;

/**
 The new node that has been added to the graph.
 **/
@property(retain) CDQuartzNode *newNode;

/**
 A collection of points that are currently assigned.
 **/
@property(retain) NSMutableArray *trackPoints;

/**
 A flag to indicate whether the current operation should delete.
 **/
@property(assign) BOOL shouldDelete;

/**
 The bounds of the space in which the graph is visible.
 **/
@property(retain) QRectangle *bounds;

/**
 A flag use to determine whether the state should be redrawn.
 **/
@property(assign) BOOL redraw;

/**
 A flag to indicate whether the connections are being edited.
 **/
@property(assign) BOOL editConnections;

/**
 A flag used to indicate that editing is active.
 **/
@property(assign) BOOL isEditing;

/**
 Initialise with the bounds of the visible area.
 **/
-(id)initWithBounds:(QRectangle *)b;

/**
 Initialise with the graph instance and the bounds of the visible area.
 **/
-(id)initWithGraph:(CDQuartzGraph *)g andBounds:(QRectangle *)b;

-(void)dealloc;


/**
 Initialise the state transition graph
 **/
-(void)buildTransitions;

/**
 Find a tracked node at the supplied index.
 **/
-(TrackedNode *)findNode:(int)idx;

/**
 Find the tracked edge associated with the index.
 **/
-(TrackedEdge *)findTrackedEdge:(int)idx;

/**
 Search for and identify tracking nodes against the set of points.
 **/
-(void)searchForTrackingNodes;

/**
 Find the set of edges that exist within the range
 of the points used to hover over the edge shapes.
 **/
-(void)searchForTrackingEdges;

/**
 Update the state with the selection of points
 **/
-(void)trackShapes:(NSMutableArray*)points andDelete:(BOOL)flag;

/**
 Hover over shapes in the collection.
 **/
-(void)hoverShapes:(NSMutableArray *)points;

/**
 Cancel the current operation if possible.
 **/
-(void)cancelOperation:(BOOL)cancelFlag;

/**
 Add a new graph node to the state.
 **/
-(void)addNode:(CDQuartzNode *)node;

/**
 Update the state.
 **/
-(void)updateState;

@end
