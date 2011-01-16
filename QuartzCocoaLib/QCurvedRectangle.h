//
//  QCurvedRectangle.h
//  QuartzCocoaLib
//
//  Created by Chris Davey on 16/01/11.
//  Copyright 2011 cd. All rights reserved.
//

#import "QRectangle.h"

/**
 A curved rectangle is very similar to an ellipse.
 It uses the same ellipse drawing method
 however uses smaller radius at the corners in order
 to draw curved edges.
 **/
@interface QCurvedRectangle : QRectangle {
	float radius;
}
/**
 Radius for rectangle corners.
 **/
@property(assign) float radius;


/**
 Allow parameterless constructor for NSCoding.
 **/
-(id)init;
-(id)initX:(float)xcoord Y:(float)ycoord WIDTH:(float)w HEIGHT:(float)h;
-(id)initWithRect:(CGRect) rect;
-(id)initX:(float)xcoord Y:(float)ycoord WIDTH:(float)w HEIGHT:(float)h RADIUS:(float)r;
-(id)initWithRect:(CGRect) rect RADIUS:(float)r;
-(void)update:(QContext*) context;
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
