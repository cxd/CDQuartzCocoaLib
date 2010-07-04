//
//  QBlendMode.m
//  QuartzCocoaLib
//
//  Created by Chris Davey on 4/07/09.
//  Copyright 2009 none. All rights reserved.
//

#import "QBlendMode.h"


@implementation QBlendMode

@synthesize mode;

-(id)init {
	self = [super init];
	self.mode = QBlendNormal;
	return self;
}

-(id)initWithStyle:(BlendMode)s
{
	self = [super init];
	self.mode = s;
	return self;
}
-(void)update:(QContext *)context
{
	CGContextSetBlendMode(context.context, self.mode);	
}

@end
