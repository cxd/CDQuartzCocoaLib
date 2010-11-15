//
//  CDGraphViewState.h
//  CDQuartzGraph
//
//  Created by Chris Davey on 14/09/10.
/**
 Copyright (c) 2010, Chris Davey
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 **/

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

#import "IEditNodeDelegate.h"

@protocol CDGraphViewOperation;

@interface CDGraphViewState : NSObject<CDGraphVisitor> {
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
	 A delegate that will perform shape editing on behalf of the state.
	 **/
	id<IEditNodeDelegate> editDelegate;
	
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
	
	/**
	 Change label.
	 **/
	BOOL selectLabel;
	
	/**
	 QPoints used to estimate the overall dimensions of the graph.
	 **/
	QPoint* minPoint;
	QPoint* maxPoint;
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
 A delegate that will perform shape editing on behalf of the state.
 This is a weak reference to the delegate.
 **/
@property(assign) id<IEditNodeDelegate> editDelegate;

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
 Change label.
 **/
@property(assign) BOOL selectLabel;

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

/**
 Compute the bounds for the graph based on the current rectangle.
 **/
-(QRectangle *)computeBounds:(QRectangle *)curRect;

/**
 Vist method used when processing the graph to compute the bounds.
 **/
-(void) visit:(CDNode *) node;

@end
