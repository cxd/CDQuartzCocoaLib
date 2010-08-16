//
//  CDQuartzNode.h
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

@interface CDQuartzNode : CDNode<QContextModifier,Drawable> {
	/**
	 A shape delegate is used to perform 
	 the drawing of the graphical representation of
	 the vertice.
	 **/
	AbstractNodeShape* shapeDelegate;
}

/**
 A shape delegate is used to perform 
 the drawing of the graphical representation of
 the vertice.
 **/
@property(retain) AbstractNodeShape* shapeDelegate;

/**
 Initialise with user data.
 Create a default shape delegate 
 which will draw a rounded corner rectangle.
 **/
-(id)initWithData:(NSObject *)userData;

/**
 Initialise with a copy of another node.
 Create a default shape delegate 
 which will draw a rounded corner rectangle.
 **/
-(id)initWithCopy:(CDNode *)node;

/**
 Initialise with user data.
 Create a default shape delegate 
 which will draw a rounded corner rectangle.
 **/
-(id)initWithShape:(AbstractNodeShape*) s AndData:(NSObject *)userData;

/**
 Initialise with a copy of another node.
 Create a default shape delegate 
 which will draw a rounded corner rectangle.
 **/
-(id)initWithShape:(AbstractNodeShape*) s AndCopy:(CDNode *)node;

/**
 Dealloc
 **/
-(void)dealloc;

/**
 Change the supplied context.
 **/
-(void)update:(QContext *)context;

@end
