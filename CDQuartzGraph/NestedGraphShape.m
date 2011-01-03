//
//  NestedGraphShape.m
//  CDQuartzGraph
//
//  Created by Chris Davey on 1/12/10.
//  Copyright 2010 cd. All rights reserved.
//

#import "NestedGraphShape.h"


@implementation NestedGraphShape

@synthesize nestedGraph;
@synthesize padding;

/**
 This init method is used only for initialising with the coder.
 **/
-(id)init
{
	self = [super init];
	return self;
}


/**
 Initialise with graph.
 **/
-(id)initWithGraph:(CDQuartzGraph *)g
{
	QRectangle *rect = [g computeBounds];
	// add padding
	self.padding = 25.0f;
	rect.x -= self.padding;
	rect.y -= self.padding;
	rect.width += self.padding;
	rect.height += self.padding;
	self = [super initWithBounds:rect];
	self.nestedGraph = g;
	[self.queue enqueue:self.nestedGraph];
	return self;
}

/**
 Initialise with graph and label.
 **/
-(id)initWithGraph:(CDQuartzGraph *)g AndLabel:(NSString *)l
{
	QRectangle *rect = [g computeBounds];
	// add padding
	self.padding = 25.0f;
	rect.x -= self.padding;
	rect.y -= self.padding;
	rect.width += self.padding;
	rect.height += self.padding;
	
	self = [super initWithBounds:rect AndLabel: l];
	self.nestedGraph = g;
	[self.queue enqueue:self.nestedGraph];
	return self;
}


/**
 Initialise with graph and label.
 **/
-(id)initWithGraph:(CDQuartzGraph *)g Padding:(float)p AndLabel:(NSString *)l
{
	QRectangle *rect = [g computeBounds];
	// add padding
	self.padding = p;
	rect.x -= self.padding;
	rect.y -= self.padding;
	rect.width += self.padding;
	rect.height += self.padding;
	
	self = [super initWithBounds:rect AndLabel: l];
	self.nestedGraph = g;
	[self.queue enqueue:self.nestedGraph];
	return self;
}



-(void)dealloc
{
	if (self.nestedGraph != nil) 
		[self.nestedGraph autorelease];
	[super dealloc];
}


-(void)createLabel
{
	[super createLabel];
	// change the position and scale of the label.
	// it should be positioned at the middle and top of the shape.
	if (self.labelShape != nil)
	{
		self.labelShape.height = self.padding;
	}
}

#pragma mark operations on the shape.
/**
 Move by a relative offset.
 **/
-(void)moveBy:(QPoint *)point
{
	[super moveBy:point];	
	[self.nestedGraph moveAllNodesBy:point];
}

/**
 Move to an absolute position.
 **/
-(void)moveTo:(QPoint *)point
{
	QRectangle *previousBounds = self.bounds;
	[previousBounds retain];
	[super moveTo:point];
	QPoint *delta = [[QPoint alloc] initX:previousBounds.x - self.bounds.x Y:previousBounds.y - self.bounds.y];
	[self.nestedGraph moveAllNodesBy:delta];
	[delta autorelease];
	[previousBounds autorelease];
}

/**
 Resize by with and height.
 NOTE: the NestedGraphShape does not resize its contents.
 Only the outer shape of the graph.
 **/
-(void)resizeToWidth:(int)w height:(int)h
{
	[super resizeToWidth:w height:h];
}


#pragma mark Encoder and Decoder.
/**
 Read data from an nscoder.
 **/
-(id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	self.nestedGraph = [aDecoder decodeObjectForKey:@"NestedGraphShape_nestedGraph"];
	return self;
}
/**
 Write data to an nscoder.
 **/
-(void)encodeWithCoder:(NSCoder *)aCoder
{
	[super encodeWithCoder:aCoder];
	[aCoder encodeObject:self.nestedGraph forKey:@"NestedGraphShape_nestedGraph"];
}

@end
