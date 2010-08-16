//
//  AbstractGraphShape.h
//  CDQuartzGraph
//
//  Created by Chris Davey on 14/08/10.
//  Copyright 2010 none. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "QuartzCocoaLib/QuartzCocoaLib.h"
#import "ShapeDelegate.h"

/**
 The abstract shape delegate provides the base
 class for extension when generating graph shapes.
 **/
@interface AbstractGraphShape : QShape<ShapeDelegate> {
	/**
	 The bounds of the shape.
	 **/
	QRectangle *bounds;
	/**
	 Fill color for the shape.
	 **/
	QColor *fillColor;
	/**
	 Outline color for the shape.
	 **/
	QColor *outlineColor;
	/**
	 Weight of the outline.
	 **/
	float outlineWeight;
	
	/**
	 The displacement of this shape.
	 **/
	QPoint* displacement;
	
}

/**
 The bounds of the shape.
 **/
@property(retain) QRectangle *bounds;

/**
 Fill color for the shape.
 **/
@property(retain) QColor *fillColor;
/**
 Outline color for the shape.
 **/
@property(retain) QColor *outlineColor;
/**
 Weight of the outline.
 **/
@property(assign) float outlineWeight;

/**
 Displacement of graph shape.
 **/
@property(retain) QPoint* displacement;

/**
 Attach observers.
 **/
-(void)attachObservers;

/**
 Receive key value observing events.
 **/
-(void)observeValueForKeyPath:(NSString *)keyPath
					 ofObject:(id)object
					   change:(NSDictionary *)change
					  context:(void *)context;

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
 Default initialisation.
 **/
-(id)init;

/**
 Initialise with bounds.
 **/
-(id)initWithBounds:(QRectangle *)b;

/*
 Dealloc.
 */
-(void)dealloc;

/**
 Check whether a point occurs within the bounds
 of this object.
 **/
-(BOOL)isWithinBounds:(QPoint *)point;

/**
 Check whether a rectangle intersects with the rectangle
 of this object.
 **/
-(BOOL)intersects:(QRectangle *)other;

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
