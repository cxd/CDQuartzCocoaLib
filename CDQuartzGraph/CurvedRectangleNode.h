//
//  CurvedRectangleNode.h
//  CDQuartzGraph
//
//  Created by Chris Davey on 14/08/10.
//  Copyright 2010 none. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AbstractGraphShape.h"
#import "QuartzCocoaLib/QuartzCocoaLib.h"
#import "ShapeDelegate.h"
#import "AbstractNodeShape.h"
#import "CurvedRectanglePort.h"

@interface CurvedRectangleNode : AbstractNodeShape {
	QStrokedRectangle *outlineRectangle;
	QFilledRectangle *filledRectangle;
	QStrokeColor *strokeColor;
	QFillColor *color;
	QStrokeWidth *strokeWidth;
	CurvedRectanglePort *leftPort;
	CurvedRectanglePort *topPort;
	CurvedRectanglePort *rightPort;
	CurvedRectanglePort *bottomPort;
}

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
 Left hand port.
 **/
@property(retain) CurvedRectanglePort *leftPort;

/**
 Top port.
 **/
@property(retain) CurvedRectanglePort *topPort;

/**
 RHS port.
 **/
@property(retain) CurvedRectanglePort *rightPort;

/**
 Bottom port.
 **/
@property(retain) CurvedRectanglePort *bottomPort;


/**
 
 **/
-(void)dealloc;

/**
 Create shapes.
 **/
-(void)createShapes;

/**
 Create the set of ports associated with the rectangle.
 **/
-(void)createPorts;

/**
 Event raised when outline weight has changed.
 **/
-(void)onOutlineWeightChanged;

/**
 Event raised when fill color changed.
 **/
-(void)onFillColorChanged;

/**
 Event raised when outline color changed.
 **/
-(void)onOutlineColorChanged;

/**
 Move by a relative offset.
 **/
-(void)moveBy:(QPoint *)point;

/**
 Move to an absolute position.
 **/
-(void)moveTo:(QPoint *)point;

/**
 Resize by with and height.
 **/
-(void)resizeToWidth:(int)w height:(int)h; 

@end
