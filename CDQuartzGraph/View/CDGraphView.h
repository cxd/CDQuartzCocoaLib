//
//  CDGraphView.h
//  CDQuartzGraph
//
//  Created by Chris Davey on 22/08/10.
//  Copyright 2010 none. All rights reserved.
//

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
#import "CDGraphViewState.h"

/**
 The Graph View provides support for drawing graphs within an NSView. 
 **/
@interface CDGraphView : NSView {
	/**
	 Internal graph instance.
	 **/
	CDQuartzGraph *graph;
	
	id<GraphLayoutAlgorithm> algorithm;
	
	CDGraphViewState *state;
	
	/**
	 A flag to indicate whether the view should delete.
	 **/
	BOOL shouldDelete;
}

/**
 Internal graph instance.
 **/
@property(retain) CDQuartzGraph *graph;

/**
 The state associated with the view.
 **/
@property(retain) CDGraphViewState *state;

/**
 A reference to a graph layout algorithm.
 **/
@property(retain) id<GraphLayoutAlgorithm> algorithm;

/**
 A flag to indicate whether the view should delete.
 **/
@property(assign) BOOL shouldDelete;

@end
