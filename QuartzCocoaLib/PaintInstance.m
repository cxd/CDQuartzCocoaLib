//
//  PaintInstance.m
//  Pour
//
//  Created by Chris Davey on 3/08/09.
//  Copyright 2009 none. All rights reserved.
//

#import "PaintInstance.h"


@implementation PaintInstance

const float DEFAULT_ENERGY = 5.0;
const float ENERGY_CHANGE = 0.005;
const int MAX_OBJECTS = 100;
const float DEFAULT_RADIUS = 15.0;
const float MAX_RADIUS = 100.0;

@synthesize droplets;
@synthesize vector; // overall direction of movement.
@synthesize energy;
@synthesize fillColor;
@synthesize point;
@synthesize frame;

-(id)initX: (float)x Y:(float)y Rect:(CGRect) f {
	self = [super init];
	self.droplets = [[NSMutableArray alloc] initWithCapacity:MAX_OBJECTS];
	self.energy = DEFAULT_ENERGY; // initial energy.
	self.fillColor = [[QFillColor alloc] initWithRGBA:0.0 G:0.5 B:1.0 A:0.2];
	self.vector = [[Vector2D alloc] initWithMagnitude:0.0 Direction:0.0];
	self.point = [[QPoint alloc] initX:x Y:y];
	self.frame = f;
	return self;
}

-(id)initWithFillColor:(QFillColor *)color X:(float)x Y:(float)y Rect:(CGRect) f
{
	self = [super init];
	self.droplets = [[NSMutableArray alloc] init];
	self.energy = DEFAULT_ENERGY; // initial energy.
	self.fillColor = color;
	self.vector = [[Vector2D alloc] initWithMagnitude:0.0 Direction:0.0];
	self.point = [[QPoint alloc] initX:x Y:y];
	self.frame = f;
	return self;	
}


-(void)dealloc {
	for(id i in self.droplets)
	{
		[i autorelease];	
	}
	[self.droplets removeAllObjects];
	[self.droplets autorelease];
	[self.fillColor autorelease];
	[super dealloc];
}


-(void)enqueue:(QModifierQueue *)queue
{
	[queue enqueue:[[[QSaveContext alloc] init] autorelease]];
	
	for(PouredDroplet *drop in self.droplets)
	{
		[queue enqueue:self.fillColor];
		[queue enqueue:drop.arc];	
		[queue enqueue:[[[QFillPath alloc] init] autorelease]];
	}
	[queue enqueue:[[[QRestoreContext alloc] init] autorelease]];
}

-(void)updateMotion:(Vector2D *)motion
{
	[motion normalize];
	float rightX = self.frame.size.width + DEFAULT_RADIUS;
	float leftX = 0.0 - DEFAULT_RADIUS;
	float topY = 0.0 - DEFAULT_RADIUS;
	float bottomY = self.frame.size.height + DEFAULT_RADIUS;
	NSMutableArray *removable = [[NSMutableArray alloc] init];
	// recalculate the x and y positions based on their acceleration and the direction of motion.
	for(PouredDroplet *drop in self.droplets)
	{
		if ( (drop.centreX <= leftX) || (drop.centreX >= rightX) )
		{
			// we want to remove this drop.
			[removable addObject:drop];
			continue;
		}
		if ( (drop.centreY <= topY) || (drop.centreY >= bottomY) )
		{
			// we want to remove this drop.
			[removable addObject:drop];
			continue;
		}
		if (self.energy < 0.0)
		{
			[removable addObject:drop];
			continue;
		}
		// recalculate the x and y positions based on their acceleration and the direction of motion.
		float startX = drop.centreX;
		float startY = drop.centreY;
		// work out the angle 
		float nX = startX + self.energy * motion.x;
		float nY = startY + -1.0 * self.energy * motion.y;

		float rnd = rand()/(RAND_MAX*1.0);
		if (rnd <= 0.5)
		{
			nX -= 1.5;
		} else {
			nX += 1.5;
		}
		
		if (drop.arc.radius < MAX_RADIUS)
			drop.arc.radius +=(rnd)*5.0;
		drop.arc.centre.x = nX;
		drop.arc.centre.y = nY;
		drop.centreX = nX;
		drop.centreY = nY;
		//NSLog(@"New X %d New Y %d", nX, nY);
		// calculate whether the droplet is out of bounds.
	}
	for(PouredDroplet *drop in removable)
	{
		[self.droplets removeObject:drop];
		[drop autorelease];
	}
	[removable removeAllObjects];
	[removable autorelease];
	
}


-(void)update
{
	self.energy -= ENERGY_CHANGE;
	if (self.energy < 0) return;
	// add a new object if maximum objects has not been reached.
	float rnd = rand()/(RAND_MAX*1.0);
	if ([self.droplets count] < MAX_OBJECTS)
	{
		float var = 0;
		if (rnd <= 0.5)
		{
			var = -2.5;
		} else {
			var = 2.5;
		}
		float radius = rnd * (DEFAULT_RADIUS +5);
		if (radius < DEFAULT_RADIUS)
			radius = DEFAULT_RADIUS;
		PouredDroplet *drop = [[PouredDroplet alloc] initX:self.point.x + var Y:self.point.y Radius: radius];
		[self.droplets addObject:drop];
		[drop autorelease];
	}
	// recalculate the x and y positions based on their acceleration and the direction of motion.
	/*
	for(PouredDroplet *drop in self.droplets)
	{
		drop.centreY = drop.centreY - 0.5 * self.energy;
		drop.arc.centre.y = drop.centreY;
	}
	 */
}



@end
