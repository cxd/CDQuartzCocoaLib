//
//  QRestoreContext.m
//  QuartzCocoaLib
//
//  Created by Chris Davey on 4/07/09.
//  Copyright 2009 none. All rights reserved.
//

#import "QRestoreContext.h"


@implementation QRestoreContext
-(id)init
{
	self = [super init];
	return self;
}
-(void)update:(QContext*)context
{
	CGContextRestoreGState(context.context);	
}
@end
