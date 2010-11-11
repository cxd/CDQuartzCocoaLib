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

#pragma mark Encoder and Decoder.
/**
 Read data from an nscoder.
 **/
-(id)initWithCoder:(NSCoder *)aDecoder
{
	[super initWithCoder:aDecoder];
	self.width = [aDecoder decodeFloatForKey:@"width"];	
	return self;
}
/**
 Write data to an nscoder.
 **/
-(void)encodeWithCoder:(NSCoder *)aCoder
{
	[super encodeWithCoder:aCoder];
	[aCoder encodeFloat:self.width forKey:@"width"];	
}

@end
