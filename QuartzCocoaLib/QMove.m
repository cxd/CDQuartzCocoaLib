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

@end
