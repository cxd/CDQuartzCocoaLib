//
//  CDQuartzGraph.h
//  CDQuartzGraph
//
//  Created by Chris Davey on 14/08/10.
//  Copyright 2010 none. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "QuartzCocoaLib/QuartzCocoaLib.h"
#import "CDGraph/CDGraph.h"

#import "ShapeDelegate.h"
#import "Drawable.h"

#import "AbstractGraphShape.h"
#import "AbstractNodeShape.h"
#import "AbstractConnectorShape.h"

#import "CDQuartzEdge.h"
#import "CDQuartzNode.h"

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
 Change the supplied context.
 **/
-(void)update:(QContext *)context;

@end
