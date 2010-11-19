//
//  QRectangle.h
//  QuartzCocoaLib
//
//  Created by Chris Davey on 4/07/09.
//  Copyright 2009 none. All rights reserved.
//

#import "QFramework.h"
#import "QAbstractContextModifier.h"
#import "QContext.h"
#import "QPoint.h"


@interface QRectangle : QAbstractContextModifier {
	float x;
	float y;
	float width;
	float height;
}


@property float x;
@property float y;
@property float width;
@property float height;

/**
 Allow parameterless constructor for NSCoding.
 **/
-(id)init;

-(id)initX:(float)xcoord Y:(float)ycoord WIDTH:(float)w HEIGHT:(float)h;
-(id)initWithRect:(CGRect) rect;
-(void)update:(QContext*) context;
-(QRectangle*)getBoundary;
/**
 Calculate the midpoint of this rectangle.
 **/
-(QPoint *)midPoint;

/**
 Determine whether the supplied point resides within
 the rectangle.
 **/
-(BOOL)contains:(QPoint *)point;

/**
 Check whether a rectangle intersects with the rectangle
 of this object.
 **/
-(BOOL)intersects:(QRectangle *)other;

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
