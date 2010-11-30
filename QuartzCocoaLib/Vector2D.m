//
//  Vector.m
//  Pour
//
//  Created by Chris Davey on 4/08/09.
//  Copyright 2009 none. All rights reserved.
//

#import "Vector2D.h"



@implementation Vector2D

const float TO_RADIANS = (M_PI / 180.0);
const float TO_DEGREES = (180.0 / M_PI);

@synthesize magnitude;
@synthesize direction;
@synthesize x;
@synthesize y;

-(id)initWithMagnitude:(float) m Direction:(float)d
{
	self = [super init];
	self.magnitude = m;
	self.direction = d;
	[self calculateCoordinates];
	return self;
}


/**
 Create a vector of given x y components.
 **/
-(id)initX:(float) xcoord Y:(float)ycoord
{
	self = [super init];
	self.x = xcoord;
	self.y = ycoord;
	[self calculatePolarForm];
	return self;
}


-(void)setAngle:(float)angle
{
	self.direction = angle * TO_RADIANS;	
}

-(float)getAngle {
	return self.direction * TO_DEGREES;
}


-(void)calculateCoordinates
{
	self.x = self.magnitude * cos(self.direction);
	self.y = self.magnitude * sin(self.direction);
}


/**
 Convert the vector into x and y components
 **/
-(void)calculateCoordinatesOfMagnitude:(float) m Direction:(float)d
{
	self.magnitude = m;
	self.direction = d;
	[self calculateCoordinates];
}


/**
 Convert to polar form using x and y components.
 **/
-(void)calculatePolarForm
{
	self.magnitude = sqrtf(self.x * self.x + self.y * self.y);
	if (self.magnitude == 0.0)
	{
		self.direction = 0.0;
		return;
	}
	float angle = TO_DEGREES * asin(self.y / self.magnitude);
	if (self.x < 0)
		angle += 180.0;
	else if ((self.x > 0) && (self.y < 0)) 
		angle += 360.0;
	[self setAngle:angle];
}


/**
 Convert to polar form using x and y components.
 **/
-(void)calculatePolarFormWithX:(float)xcoord Y:(float)ycoord
{
	self.x = xcoord;
	self.y = ycoord;
	[self calculatePolarForm];
}


/**
 Normalize the current vector.
 **/
-(void)normalize
{
	self.x /= self.magnitude;
	self.y /= self.magnitude;
	[self calculatePolarForm]; // recaculate magnitude which should equal 1.0
}


/**
 Add two vectors.
 **/
+(Vector2D *)add:(Vector2D *)a AND:(Vector2D *)b
{
	return [[[Vector2D alloc] initX:(a.x + b.x)
									 Y:(a.y + b.y)] autorelease];
}

/**
 Subtract two vectors.
 **/
+(Vector2D *)subtract:(Vector2D *)a AND:(Vector2D *)b
{
	return [[[Vector2D alloc] initX:(a.x - b.x)
									 Y:(a.y - b.y)] autorelease];	
}


/**
Dot product of two vectors.
 let the result r = dotProduct
 if (r < 0) then angle is > 90 
 if (r > 0) then angle is < 90
 else angle = 90.
 **/
+(float)dotProduct:(Vector2D *)a AND:(Vector2D *)b
{
	return (a.magnitude*b.magnitude)+(a.direction*b.direction);
}

/**
 Calculate the angle between 2 vectors.
 **/
+(float)angleBetween:(Vector2D *)a AND:(Vector2D *)b
{
	float dot = [Vector2D dotProduct:a AND:b];
	float magnitudes = (a.magnitude * b.magnitude);
	if (magnitudes == 0.0)
	{
		return 0.0; // cannot calculate	
	}
	float cosAngle = dot / (a.magnitude * b.magnitude);
	return acos(cosAngle) * TO_DEGREES;
}



/**
 Calculate the cross product of two vectors.
 **/
+(Vector2D *)crossProduct:(Vector2D *)a AND:(Vector2D *)b
{
	return [[[Vector2D alloc] initX:(a.x*b.y) - (a.y*b.x)  Y:(a.y*b.x) - (a.x*b.y)] autorelease];
}

@end
