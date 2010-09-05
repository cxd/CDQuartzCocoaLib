//
//  CDQuartzEdge.h
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

@interface CDQuartzEdge : CDEdge<QContextModifier,Drawable> {
	/**
	 A shape delegate is used to perform 
	 the drawing of the graphical representation of
	 the edge.
	 **/
	AbstractConnectorShape* shapeDelegate;
	
}

/**
 A shape delegate is used to perform 
 the drawing of the graphical representation of
 the edge.
 **/
@property(retain) AbstractConnectorShape* shapeDelegate;

/**
 Default initialiser.
 **/
-(id)init;

/**
 Initialise with an alternate shape delegate.
 **/
-(id)initWithShape:(AbstractConnectorShape*) s;


/**
 Dealloc
 **/
-(void)dealloc;

/**
 Change the supplied context.
 **/
-(void)update:(QContext *)context;

/**
 Update Connections.
 **/
-(void)updateConnections;

@end
