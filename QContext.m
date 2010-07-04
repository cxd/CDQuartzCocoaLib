//
//  QContext.m
//  QuartzCocoaLib
//
//  Created by Chris Davey on 30/06/09.
//  Copyright 2009 none. All rights reserved.
//

#import "QContext.h"


@implementation QContext

@synthesize context;


-(id)initWithContext:(CGContextRef) graphicsContext
{
	self = [super init];
	self.context = graphicsContext;
	CGContextRetain(self.context);
	return self;
}

-(void)dealloc
{
	CGContextRelease(self.context);
	[super dealloc];
}

-(void)flipW:(float)w H:(float)h {
	// flip the coordinate system.
	CGContextTranslateCTM (self.context, w, h);
	CGContextScaleCTM (self.context, 1.0, -1.0);
}

@end


