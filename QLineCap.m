//
//  QLineCap.m
//  QuartzCocoaLib
//
//  Created by Chris Davey on 4/07/09.
//  Copyright 2009 none. All rights reserved.
//

#import "QLineCap.h"


@implementation QLineCap

@synthesize style;

-(id)init
{
	self = [super init];
	self.style = QLineCapSquared;
	return self;
}
-(id)initWithStyle:(LineCap)cap
{
	self = [super init];
	self.style = cap;
	return self;
}

-(void)update:(QContext*)context
{
	CGContextSetLineCap(context.context, self.style);	
}

@end
