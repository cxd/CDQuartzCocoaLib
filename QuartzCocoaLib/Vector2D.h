//
//  Vector.h
//  Pour
//
//  Created by Chris Davey on 4/08/09.
//  Copyright 2009 none. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "math.h"


@interface Vector2D : NSObject {
	float magnitude; // length of vector
	float direction; // angle in radians of vector.
	float x;
	float y;
}
/**
 Size of vector.
 **/
@property(assign) float magnitude;
/**
 Angle radians for direction.
 **/
@property(assign) float direction;
@property(assign) float x;
@property(assign) float y;

/**
 Create a vector of given magnitude and direction.
 **/
-(id)initWithMagnitude:(float) m Direction:(float)d;

/**
 Create a vector of given x y components.
 **/
-(id)initWithX:(float) xcoord Y:(float)ycoord;


/**
 Convert the vector into x and y components
 **/
-(void)calculateCoordinates;

/**
 Convert the vector into x and y components
 **/
-(void)calculateCoordinatesOfMagnitude:(float) m Direction:(float)d;


/**
 Convert to polar form using x and y components.
 **/
-(void)calculatePolarForm;


/**
 Convert to polar form using x and y components.
 **/
-(void)calculatePolarFormWithX:(float)xcoord Y:(float)ycoord;

/**
 Set the direction as a degrees angle.
 **/
-(void)setAngle:(float)angle;
/**
 Get the degrees of the angle.
 **/
-(float)getAngle;

/**
 Normalize the current vector.
 **/
-(void)normalize;

/**
 Add two vectors.
 **/
+(Vector2D *)add:(Vector2D *)a AND:(Vector2D *)b;

/**
 Subtract two vectors.
 **/
+(Vector2D *)subtract:(Vector2D *)a AND:(Vector2D *)b;


/**
Dot product of two vectors.
 let the result r = dotProduct
 if (r < 0) then angle is > 90 
 if (r > 0) then angle is < 90
 else angle = 90.
 **/
+(float)dotProduct:(Vector2D *)a AND:(Vector2D *)b;

/**
 Calculate the angle between 2 vectors.
 **/
+(float)angleBetween:(Vector2D *)a AND:(Vector2D *)b;

/**
 Calculate the cross product of two vectors.
 **/
+(Vector2D *)crossProduct:(Vector2D *)a AND:(Vector2D *)b;

@end
