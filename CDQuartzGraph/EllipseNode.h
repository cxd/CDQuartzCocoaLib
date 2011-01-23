//
//  EllipseNode.h
//  CDQuartzGraph
//
//  Created by Chris Davey on 16/01/11.
//  Copyright 2011 cd. All rights reserved.
//

#import "CDQuartzGraphHeader.h"
#import "CDQuartzGraph.h"
#import "AbstractGraphShape.h"
#import "RectanglePortNodeShape.h"

@interface EllipseNode : RectanglePortNodeShape {
	QFilledEllipse *filledEllipse;
	QStrokedEllipse *outlineEllipse;
}

@property(retain) QFilledEllipse *filledEllipse;
@property(retain) QStrokedEllipse *outlineEllipse;

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
 Create shapes.
 **/
-(void)createShapes;

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
