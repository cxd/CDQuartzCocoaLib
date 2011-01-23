//
//  CircleNode.m
//  CDQuartzGraph
//
//  Created by Chris Davey on 16/01/11.
//  Copyright 2011 cd. All rights reserved.
//

#import "CircleNode.h"


@implementation CircleNode

@synthesize outlineCircle;
@synthesize filledCircle;
@synthesize radius;


/**
 Default initialisation.
 **/
-(id)init
{
	self = [super init];
	self.bounds.width = 200;
	self.bounds.height = 200;
	self.radius = 100;
	[self createShapes];
	return self;
}

/**
 Initialise with bounds.
 **/
-(id)initWithBounds:(QRectangle *)b 
{
	if (b.width > b.height)
	{
		b.height = b.width;	
	}
	else {
		b.width = b.height;	
	}
	self = [super initWithBounds:b];
	self.radius = b.width/2.0f;
	[self createShapes];
	return self;
}

/**
 Default initialisation.
 **/
-(id)initWithLabel:(NSString *)l
{
	self = [super initWithLabel:l];
	self.bounds.width = 200;
	self.bounds.height = 200;
	self.radius = 100;
	[self createShapes];
	return self;
}

/**
 Initialise with bounds and label.
 **/
-(id)initWithBounds:(QRectangle *)b AndLabel:(NSString *)l
{
	if (b.width > b.height)
	{
		b.height = b.width;	
	}
	else {
		b.width = b.height;	
	}
	self = [super initWithBounds:b AndLabel:l];
	self.radius = b.width/2.0f;
	[self createShapes];
	return self;
}



/**
 clear up the object.
 **/
-(void)dealloc
{
	[self.filledCircle autorelease];
	[self.outlineCircle autorelease];
	[super dealloc];
}

-(void)createShapes
{
	self.strokeColor = [[QStrokeColor alloc] initWithQColor:self.outlineColor];
	[self.queue enqueue:self.strokeColor];
	[self.queue enqueue:[[[QLineCap alloc] initWithStyle:QLineCapRounded] autorelease]];
	[self.queue enqueue:[[[QJoinCap alloc] initWithStyle:QJoinCapRounded] autorelease]];
	self.strokeWidth = [[QStrokeWidth alloc] initWidth:self.outlineWeight];
	[self.queue enqueue:self.strokeWidth];
	self.foreColor = [[QFillColor alloc] initWithQColor:self.fillColor];
	[self.queue enqueue:self.foreColor];
	
	
	self.filledCircle = [[QFilledCircle alloc] initX:self.bounds.x + self.radius 
												   Y:self.bounds.y + self.radius 
											  Radius:self.radius];
	[self.queue enqueue:self.filledCircle];
	
	self.outlineCircle = [[QStrokedCircle alloc] initX:self.bounds.x + self.radius 
														Y:self.bounds.y + self.radius 
												   Radius:self.radius];
	[self.queue enqueue:self.outlineCircle];
}

/**
 Move by a relative offset.
 **/
-(void)moveBy:(QPoint *)point
{
	[super moveBy:point];
	self.filledCircle.centre.x = self.bounds.x + self.radius;
	self.filledCircle.centre.y = self.bounds.y + self.radius;
	self.outlineCircle.centre.x = self.bounds.x + self.radius;
	self.outlineCircle.centre.y = self.bounds.y + self.radius;
}

/**
 Move to an absolute position.
 **/
-(void)moveTo:(QPoint *)point
{
	[super moveTo:point];
	self.filledCircle.centre.x = self.bounds.x + self.radius;
	self.filledCircle.centre.y = self.bounds.y + self.radius;
	self.outlineCircle.centre.x = self.bounds.x + self.radius;
	self.outlineCircle.centre.y = self.bounds.y + self.radius;	
}

/**
 Resize by with and height.
 **/
-(void)resizeToWidth:(int)w height:(int)h
{
	[super resizeToWidth:w height:h];
	
	if (w > h)
	{
		self.bounds.height = w;	
	}
	else {
		self.bounds.width = h;	
	}
	self.radius = self.bounds.width/2.0f;
	self.filledCircle.radius = self.radius;
	self.outlineCircle.radius = self.radius;
}

#pragma mark Encoder and Decoder.
/**
 Read data from an nscoder.
 **/
-(id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	
	return self;
}
/**
 Write data to an nscoder.
 **/
-(void)encodeWithCoder:(NSCoder *)aCoder
{
	[super encodeWithCoder:aCoder];
	
}

@end
