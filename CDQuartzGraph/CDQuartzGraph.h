//
//  CDQuartzGraph.h
//  CDQuartzGraph
//
//  Created by Chris Davey on 14/08/10.
//  Copyright 2010 none. All rights reserved.
//

#import "CDQuartzGraphHeader.h"


#import "ShapeDelegate.h"
#import "Drawable.h"

#import "AbstractGraphShape.h"
#import "AbstractNodeShape.h"
#import "AbstractConnectorShape.h"

#import "CDQuartzEdge.h"
#import "CDQuartzNode.h"
#import "CDPersistentQuartzEdge.h"
#import <float.h>


@interface CDQuartzGraph : CDGraph<QContextModifier,Drawable> {
	/**
	 A shape delegate is used to perform 
	 the drawing of the graphical representation of
	 the vertice.
	 **/
	AbstractGraphShape* shapeDelegate;
	
}

/**
 A shape delegate is used to perform 
 the drawing of the graphical representation of
 the vertice.
 **/
@property(retain) AbstractGraphShape* shapeDelegate;

/**
 Default initialiser
 **/
-(id)init;

/**
 Initialise the graph with a shape delegate.
 **/
-(id)initWithShape:(AbstractGraphShape*) s;


/**
 Initialise with a copy of the graph.
 For all nodes in the graph generate a
 default shape provider.
 **/
-(id)initWithCopy:(CDGraph *)copy;

/**
 Initialise with a copy of the graph.
 For all nodes in the graph generate a
 default shape provider.
 **/
-(id)initWithShape:(AbstractGraphShape*) s AndCopy:(CDGraph *)copy;


/**
 Dealloc
 **/
-(void)dealloc;

/**
 Connect the two nodes and use the supplied shape.
 **/
-(CDEdge *)connect:(CDNode *)fromNode 
				to:(CDNode *)toNode 
		 withShape:(AbstractConnectorShape *)shape
		  fromPort:(AbstractPortShape *)from 
			toPort:(AbstractPortShape*)to;
/**
 Change the supplied context.
 **/
-(void)update:(QContext *)context;

/**
 Find the first node that contains the point.
 **/
-(CDQuartzNode *)findNodeContaining:(QPoint *)p;

/**
 Find an edge that is contained by the supplied point.
 **/
-(CDQuartzEdge *)findEdgeContaining:(QPoint *)p;

/**
 Check whether a rectangle intersects with the rectangle
 of this object.
 **/
-(CDQuartzNode *)findIntersectingNode:(QRectangle *)other;

/**
 Move by a relative offset.
 **/
-(void)moveNode:(CDQuartzNode *)node By:(QPoint *)point;

/**
 Move to an absolute position.
 **/
-(void)moveNode:(CDQuartzNode *)node To:(QPoint *)point;

/**
 Resize by with and height.
 **/
-(void)resizeNode:(CDQuartzNode *)node ToWidth:(int)w height:(int)h;

/**
 Update any connections associated with the node.
 **/
-(void)updateConnections:(CDQuartzNode *)node;

/**
 Find the closest port.
 **/
-(AbstractPortShape *)closestPort:(QPoint *)point toNode:(CDQuartzNode *)node;

#pragma mark Encoder and Decoder.
/**
 Read data from an nscoder.
 **/
-(id)initWithCoder:(NSCoder *)aDecoder;
/**
 Write data to an nscoder.
 **/
-(void)encodeWithCoder:(NSCoder *)aCoder;

@end
