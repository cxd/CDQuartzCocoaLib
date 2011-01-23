//
//  EllipseNode.m
//  CDQuartzGraph
//
//  Created by Chris Davey on 16/01/11.
//  Copyright 2011 cd. All rights reserved.
//

#import "EllipseNode.h"


@implementation EllipseNode

@synthesize filledEllipse;
@synthesize outlineEllipse;


/**
 Default initialisation.
 **/
-(id)init
{
	self = [super init];
	self.bounds.width = 200;
	self.bounds.height = 80;
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
	self.bounds.height = 80;
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


/**
 clear up the object.
 **/
-(void)dealloc
{
	[self.filledEllipse autorelease];
	[self.outlineEllipse autorelease];
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
	
	
	self.filledEllipse = [[QFilledEllipse alloc] initX:self.bounds.x
													 Y:self.bounds.y
												 WIDTH:self.bounds.width
												HEIGHT:self.bounds.height];
	[self.queue enqueue:self.filledEllipse];
	
	self.outlineEllipse = [[QStrokedEllipse alloc] initX:self.bounds.x 
													 Y:self.bounds.y 
												   WIDTH:self.bounds.width
												  HEIGHT:self.bounds.height];
	[self.queue enqueue:self.outlineEllipse];
}


/**
 Move by a relative offset.
 **/
-(void)moveBy:(QPoint *)point
{
	[super moveBy:point];	
	self.filledEllipse.x = self.bounds.x;
	self.filledEllipse.y = self.bounds.y;
	self.outlineEllipse.x = self.bounds.x;
	self.outlineEllipse.y = self.bounds.y;
}

/**
 Move to an absolute position.
 **/
-(void)moveTo:(QPoint *)point
{
	[super moveTo:point];
	self.filledEllipse.x = self.bounds.x;
	self.filledEllipse.y = self.bounds.y;
	self.outlineEllipse.x = self.bounds.x;
	self.outlineEllipse.y = self.bounds.y;	
}

/**
 Resize by with and height.
 **/
-(void)resizeToWidth:(int)w height:(int)h
{
	[super resizeToWidth:w height:h];
	self.filledEllipse.width = self.bounds.width;
	self.filledEllipse.height = self.bounds.height;
	self.outlineEllipse.width = self.bounds.width;
	self.outlineEllipse.height = self.bounds.height;
}



#pragma mark Encoder and Decoder.
/**
 Read data from an nscoder.
 **/
-(id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	self.outlineEllipse = [aDecoder decodeObjectForKey:@"EllipseNode_outlineEllipse"];
	self.filledEllipse = [aDecoder decodeObjectForKey:@"EllipseNode_filledEllipse"];
	return self;
}

/**
 Write data to an nscoder.
 **/
-(void)encodeWithCoder:(NSCoder *)aCoder
{
	[super encodeWithCoder:aCoder];
	[aCoder encodeObject:self.outlineEllipse forKey:@"EllipseNode_outlineEllipse"];
	[aCoder encodeObject:self.filledEllipse forKey:@"EllipseNode_filledEllipse"];
	
}


@end
