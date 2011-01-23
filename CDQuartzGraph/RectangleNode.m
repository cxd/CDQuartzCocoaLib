//
//  RectangleNode.m
//  CDQuartzGraph
//
//  Created by Chris Davey on 16/01/11.
//  Copyright 2011 cd. All rights reserved.
//

#import "RectangleNode.h"


@implementation RectangleNode


@synthesize outlineRectangle;
@synthesize filledRectangle;


/**
 Default initialisation.
 **/
-(id)init
{
	self = [super init];
	self.bounds.width = 200;
	self.bounds.height = 150;
	[self createShapes];
	return self;
}

/**
 Initialise with bounds.
 **/
-(id)initWithBounds:(QRectangle *)b
{
	self = [super initWithBounds:b];
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
	self.bounds.height = 150;
	[self createShapes];
	return self;
}

/**
 Initialise with bounds and label.
 **/
-(id)initWithBounds:(QRectangle *)b AndLabel:(NSString *)l
{
	self = [super initWithBounds:b AndLabel:l];
	[self createShapes];
	return self;
}


-(void)dealloc
{
	[self.filledRectangle autorelease];
	[self.outlineRectangle autorelease];
	
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
	
	self.filledRectangle = [[QFilledRectangle alloc] initX:self.bounds.x
														  Y:self.bounds.y 
													  WIDTH:self.bounds.width 
													 HEIGHT:self.bounds.height];
	[self.queue enqueue:self.filledRectangle];
	
	self.outlineRectangle = [[QStrokedRectangle alloc] initX:self.bounds.x 
															Y:self.bounds.y
														WIDTH:self.bounds.width 
													   HEIGHT:self.bounds.height];
	[self.queue enqueue:self.outlineRectangle];
}

/**
 Move by a relative offset.
 **/
-(void)moveBy:(QPoint *)point
{
	[super moveBy:point];	
	self.filledRectangle.x = self.bounds.x;
	self.filledRectangle.y = self.bounds.y;
	self.outlineRectangle.x = self.bounds.x;
	self.outlineRectangle.y = self.bounds.y;
}

/**
 Move to an absolute position.
 **/
-(void)moveTo:(QPoint *)point
{
	[super moveTo:point];
	self.filledRectangle.x = self.bounds.x;
	self.filledRectangle.y = self.bounds.y;
	self.outlineRectangle.x = self.bounds.x;
	self.outlineRectangle.y = self.bounds.y;	
}

/**
 Resize by with and height.
 **/
-(void)resizeToWidth:(int)w height:(int)h
{
	[super resizeToWidth:w height:h];
	self.filledRectangle.width = self.bounds.width;
	self.filledRectangle.height = self.bounds.height;
	self.outlineRectangle.width = self.bounds.width;
	self.outlineRectangle.height = self.bounds.height;
}

#pragma mark Encoder and Decoder.
/**
 Read data from an nscoder.
 **/
-(id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	self.outlineRectangle = [aDecoder decodeObjectForKey:@"RectangleNode_outlineRectangle"];
	self.filledRectangle = [aDecoder decodeObjectForKey:@"RectangleNode_filledRectangle"];
	return self;
}

/**
 Write data to an nscoder.
 **/
-(void)encodeWithCoder:(NSCoder *)aCoder
{
	[super encodeWithCoder:aCoder];
	[aCoder encodeObject:self.outlineRectangle forKey:@"RectangleNode_outlineRectangle"];
	[aCoder encodeObject:self.filledRectangle forKey:@"RectangleNode_filledRectangle"];
	
}

@end