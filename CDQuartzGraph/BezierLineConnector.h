//
//  BezierLineConnector.h
//  CDQuartzGraph
//
//  Created by Chris Davey on 14/08/10.
//  Copyright 2010 none. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AbstractGraphShape.h"
#import "QuartzCocoaLib/QuartzCocoaLib.h"
#import "ShapeDelegate.h"
#import "AbstractConnectorShape.h"

/**
 A connector used to draw a line between 2 shapes.
 **/
@interface BezierLineConnector : AbstractConnectorShape {
	QBezierCurve *curve;
	QStrokeColor *strokeColor;
	QStrokeWidth *strokeWidth;
}

/**
 bezier curve.
 **/
@property(retain) QBezierCurve *curve; 

/**
 stroke color
 **/
@property(retain) QStrokeColor *strokeColor;

/**
 stroke width
 **/
@property(retain) QStrokeWidth *strokeWidth;

/**
 Default initialisation.
 **/
-(id)init;

/**
 Initialise with bounds.
 **/
-(id)initWithBounds:(QRectangle *)b;

/**
 Default initialisation.
 **/
-(id)initWithLabel:(NSString *)l;

/**
 Initialise with bounds and label.
 **/
-(id)initWithBounds:(QRectangle *)b AndLabel:(NSString *)l;


/**
 Dealloc.
 **/
-(void)dealloc;

/**
 Initialise the line with default bounds.
 **/
-(void)initialiseRect:(QRectangle *)b;

/**
 Event raised when outline weight has changed.
 **/
-(void)onOutlineWeightChanged;

/**
 Event raised when outline color changed.
 **/
-(void)onOutlineColorChanged;

/**
 Connect the start line to supplied port.
 **/
-(void)connectStartTo:(AbstractPortShape *)port;

/**
 Connect the end line to supplied port.
 **/
-(void)connectEndTo:(AbstractPortShape *)port;

/**
 Move start point by relative amount.
 **/
-(void)moveStartBy:(QPoint *)p;

/**
 Move end point by relative amount.
 **/
-(void)moveEndBy:(QPoint *)p;

/**
 Move start point to absolute point.
 **/
-(void)moveStartTo:(QPoint *)p;

/**
 Move end point to absolute point.
 **/
-(void)moveEndTo:(QPoint *)p;

/**
 Update Connections.
 **/
-(void)updateConnections;
@end
