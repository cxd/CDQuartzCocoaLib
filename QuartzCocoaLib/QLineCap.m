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

#pragma mark Encoder and Decoder.
/**
 Read data from an nscoder.
 **/
-(id)initWithCoder:(NSCoder *)aDecoder
{
	[super initWithCoder:aDecoder];
	self.style = (LineCap)[aDecoder decodeIntForKey:@"style"];
	return self;
}
/**
 Write data to an nscoder.
 **/
-(void)encodeWithCoder:(NSCoder *)aCoder
{
	[super encodeWithCoder:aCoder];
	[aCoder encodeInt32:(int)self.style forKey:@"style"];	
}

@end
