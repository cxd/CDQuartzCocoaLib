//
//  CirclePortShape.h
//  CDQuartzGraph
//
//  Created by Chris Davey on 25/09/10.
//  Copyright 2010 none. All rights reserved.
//

#import "CDQuartzGraphHeader.h"
#import "AbstractGraphShape.h"
#import "ShapeDelegate.h"
#import "AbstractPortShape.h"

@interface CirclePortShape : AbstractPortShape {
	QArc *outlineArc;
	QArc *filledCircle;
	QStrokeColor *strokeColor;
	QFillColor *color;
	QStrokeWidth *strokeWidth;
}


/**
 Initialise with the parent of the port.
 **/
-(id)initWithParent:(AbstractGraphShape *)p;

/**
 Initialise with the parent of the port.
 **/
-(id)initWithParent:(AbstractGraphShape *)p AndBounds:(QRectangle *)r;

-(void)createShapes;
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
