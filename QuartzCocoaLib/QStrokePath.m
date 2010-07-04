//
//  QStrokePath.m
//  QuartzCocoaLib
//
//  Created by Chris Davey on 4/07/09.
//  Copyright 2009 none. All rights reserved.
//

#import "QStrokePath.h"


@implementation QStrokePath

-(id)init
{
	self = [super init];
	return self;
}

-(void)update:(QContext*)context
{
	CGContextStrokePath(context.context);
}

@end
