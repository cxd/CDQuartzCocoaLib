//
//  QStrokeWidth.m
//  QuartzCocoaLib
//
//  Created by Chris Davey on 4/07/09.
//  Copyright 2009 none. All rights reserved.
//

#import "QStrokeWidth.h"


@implementation QStrokeWidth

@synthesize width;

-(id)init
{
	self = [super init];
	self.width = 1.0;
	return self;
}

-(id)initWidth:(float)w
{
	self = [super init];
	self.width = w;
	return self;
}

-(void)update:(QContext*)context
{
	CGContextSetLineWidth(context.context, self.width);	
}
@end
