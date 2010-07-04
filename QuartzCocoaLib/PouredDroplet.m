//
//  PouredDroplet.m
//  Pour
//
//  Created by Chris Davey on 3/08/09.
//  Copyright 2009 none. All rights reserved.
//

#import "PouredDroplet.h"


@implementation PouredDroplet

const float DEFAULT_ACCELERATION = 1.5;
const float DEFAULT_FRICTION = 0.1;


@synthesize centreX;
@synthesize centreY;
@synthesize acceleration;
@synthesize arc;
@synthesize angle;
@synthesize radius;



-(id)initWithX:(float) x Y:(float) y Radius:(float) r
{
	self = [super init];
	self.centreX = x;
	self.centreY = y;
	self.angle = 0.0;
	self.acceleration = DEFAULT_ACCELERATION;
	self.radius = r;
	self.arc = [[QArc alloc]
				initWithX:self.centreX
				Y: self.centreY
				Radius: self.radius
				StartAngle: 0.0
				EndAngle: 360.0 
				START: YES 
				END: YES
				CLOCKWISE:YES];
	return self;
}

-(id)initWithX:(float) x Y:(float) y Radius:(float) r Aceleration:(float) a;
{
	self = [super init];
	self.centreX = x;
	self.centreY = y;
	self.acceleration = a;
	self.radius = r;
	self.angle = 0.0;
	self.arc = [[QArc alloc]
				initWithX:self.centreX
				Y: self.centreY
				Radius: self.radius
				StartAngle: 0.0
				EndAngle: 360.0 
				START: YES 
				END: YES
				CLOCKWISE:YES];
	return self;
}

-(void)dealloc {
	if (self.arc != nil)
	{
		[self.arc autorelease];	
	}
	[super dealloc];
}



@end
