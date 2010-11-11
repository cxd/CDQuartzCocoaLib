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

-(id)initWithQColor:(QColor *)color
{
	self = [super init];
	self.alpha = color.alpha;
	self.red = color.red;
	self.blue = color.blue;
	self.green = color.green;
	return self;
}

-(void)update:(QContext *)context
{
}


#pragma mark Encoder and Decoder.
/**
 Read data from an nscoder.
 **/
-(id)initWithCoder:(NSCoder *)aDecoder
{
	[super initWithCoder:aDecoder];
	self.alpha = [aDecoder decodeFloatForKey:@"alpha"];
	self.red = [aDecoder decodeFloatForKey:@"red"];
	self.blue = [aDecoder decodeFloatForKey:@"blue"];
	self.green = [aDecoder decodeFloatForKey:@"green"];	
	return self;
}
/**
 Write data to an nscoder.
 **/
-(void)encodeWithCoder:(NSCoder *)aCoder
{
	[super encodeWithCoder:aCoder];
	[aCoder encodeFloat:self.alpha forKey:@"alpha"];
	[aCoder encodeFloat:self.red forKey:@"red"];
	[aCoder encodeFloat:self.blue forKey:@"blue"];
	[aCoder encodeFloat:self.green forKey:@"green"];
}

@end
