//
//  UIGraphView.h
//  CDQuartzGraphTouch
//
//  Created by Chris Davey on 6/09/10.
//  Copyright 2010 none. All rights reserved.
//

#import <UIKit/UIKit.h>
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

/**
 The Graph View provides support for drawing graphs within an UIView. 
 **/
@interface UIGraphView : UIView {

	/**
	 Internal graph instance.
	 **/
	CDQuartzGraph *graph;
	
	NSMutableArray *trackNodes;
	
	id<GraphLayoutAlgorithm> algorithm;
	
}

/**
 Internal graph instance.
 **/
@property(retain) CDQuartzGraph *graph;

@property(retain) NSMutableArray *trackNodes;

/**
 A reference to a graph layout algorithm.
 **/
@property(retain) id<GraphLayoutAlgorithm> algorithm;


-(void)beginTracking:(UITouch *)touch atIndex:(int)idx;

-(void)moveTracked:(UITouch *)touch atIndex:(int)idx;

-(void)endTracking:(UITouch *)touch atIndex:(int)idx;

-(TrackedNode *)findNode:(int)idx;
@end
