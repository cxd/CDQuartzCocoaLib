//
//  QMove.m
//  QuartzCocoaLib
//
//  Created by Chris Davey on 5/07/09.
//  Copyright 2009 none. All rights reserved.
//

#import "QMove.h"


@implementation QMove

@synthesize position;

/**
 Allow parameterless constructor for NSCoding.
 **/
-(id)init
{
	self = [super init];
	return self;
}

-(id)initX:(float)x Y:(float)y
{
	self = [super init];
	self.position = [[QPoint alloc] initX:x Y:y];
	return self;
}

-(id)initWithPoint:(QPoint *)p
{
	self = [super init];
	self.position = [[QPoint alloc] initX:p.x Y:p.y];
	return self;
}

-(void)dealloc
{
	[self.position autorelease];
	[super dealloc];
}

-(void)update:(QContext *)context
{
	CGContextMoveToPoint(context.context, self.position.x, self.position.y);
}


#pragma mark Encoder and Decoder.
/**
 Read data from an nscoder.
 **/
-(id)initWithCoder:(NSCoder *)aDecoder
{
	[super initWithCoder:aDecoder];
	self.position = [aDecoder decodeObjectForKey:@"position"];
	return self;
}
/**
 Write data to an nscoder.
 **/
-(void)encodeWithCoder:(NSCoder *)aCoder
{
	[super encodeWithCoder:aCoder];
	[aCoder encodeObject:self.position forKey:@"position"];	
}

@end
