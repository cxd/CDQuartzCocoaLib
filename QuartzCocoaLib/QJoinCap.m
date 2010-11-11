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

#pragma mark Encoder and Decoder.
/**
 Read data from an nscoder.
 **/
-(id)initWithCoder:(NSCoder *)aDecoder
{
	[super initWithCoder:aDecoder];
	self.style = (JoinCap)[aDecoder decodeIntForKey:@"style"];
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
