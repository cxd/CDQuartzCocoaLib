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

@interface CDGraphView : NSView {
	/**
	 Internal graph instance.
	 **/
	CDQuartzGraph *graph;
	
	CDQuartzNode *trackNode;
	
	id<GraphLayoutAlgorithm> algorithm;
}

/**
 Internal graph instance.
 **/
@property(retain) CDQuartzGraph *graph;

@property(retain) CDQuartzNode *trackNode;

/**
 A reference to a graph layout algorithm.
 **/
@property(retain) id<GraphLayoutAlgorithm> algorithm;

@end
