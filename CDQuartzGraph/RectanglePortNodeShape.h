//
//  AbstractBoundPortShape.h
//  CDQuartzGraph
//
//  Created by Chris Davey on 16/01/11.
//  Copyright 2011 cd. All rights reserved.
//

#import "CDQuartzGraphHeader.h"
#import "AbstractGraphShape.h"
#import "ShapeDelegate.h"
#import "AbstractPortShape.h"
#import "CurvedRectanglePort.h"
#import "AbstractNodeShape.h"

/**
 Rectangle port node shape has 4 ports around the 4 edges of
 a rectangular boundary.
 
 This shape can be inherited from in order to support
 behaviours using ports for connectors.
 
 **/
@interface RectanglePortNodeShape : AbstractNodeShape {
	CurvedRectanglePort *leftPort;
	CurvedRectanglePort *topPort;
	CurvedRectanglePort *rightPort;
	CurvedRectanglePort *bottomPort;
	QStrokeColor *strokeColor;
	QFillColor *foreColor;
	QStrokeWidth *strokeWidth;
}

@property(retain) QStrokeColor *strokeColor;
@property(retain) QFillColor *foreColor;
@property(retain) QStrokeWidth *strokeWidth;


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
 clear up the object.
 **/
-(void)dealloc;

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
 Resize by with and height.
 **/
-(void)resizeToWidth:(int)w height:(int)h; 

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
