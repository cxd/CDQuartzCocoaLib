//
//  QJoinCap.m
//  QuartzCocoaLib
//
//  Created by Chris Davey on 4/07/09.
//  Copyright 2009 none. All rights reserved.
//

#import "QJoinCap.h"


@implementation QJoinCap

@synthesize style;

-(id)init
{
	self = [super init];
	self.style = QJoinCapSquared;
	return self;
}

-(id)initWithStyle:(JoinCap)cap
{
	self = [super init];
	self.style = cap;
	return self;
}

-(void)update:(QContext*)context
{
	CGContextSetLineJoin(context.context, self.style);	
}


@end
