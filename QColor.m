//
//  QColor.m
//  QuartzCocoaLib
//
//  Created by Chris Davey on 4/07/09.
//  Copyright 2009 none. All rights reserved.
//

#import "QColor.h"


@implementation QColor



@synthesize red;
@synthesize green;
@synthesize blue;
@synthesize alpha;


-(id)init
{
	self = [super init];
	self.red = 0.0;
	self.green = 0.0;
	self.blue = 0.0;
	self.alpha = 1.0;
	return self;
}

-(id)initWithRGB:(float)r G:(float)g B:(float)b
{
	self = [super init];
	self.alpha = 1.0;
	self.red = r;
	self.blue = b;
	self.green = g;
	return self;
}

-(id)initWithRGBA:(float)r G:(float)g B:(float)b A:(float)a
{
	self = [super init];
	self.alpha = a;
	self.red = r;
	self.blue = b;
	self.green = g;
	return self;
}


-(void)update:(QContext *)context
{
}

@end
