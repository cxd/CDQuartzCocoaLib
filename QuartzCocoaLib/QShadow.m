//
//  QShadow.m
//  QuartzCocoaLib
//
//  Created by Chris Davey on 4/07/09.
//  Copyright 2009 none. All rights reserved.
//

#import "QShadow.h"


@implementation QShadow

@synthesize offset;
@synthesize yoffset;
@synthesize blur;
@synthesize color;
@synthesize colorSpace;
@synthesize colorRef;

-(id)init 
{
	self = [super init];
	self.colorSpace = CGColorSpaceCreateDeviceRGB();
	self.offset = 5.0;
	self.yoffset = self.offset;
	self.blur = 1;
	self.color = [[QColor alloc] init];
	self.color.alpha = 0.9;
	return self;
}
-(id)initWithBlur:(float)b O:(float)o
{
	self = [super init];
	self.colorSpace = CGColorSpaceCreateDeviceRGB();
	self.offset = o;
	self.yoffset = o;
	self.blur = b;
	self.color = [[QColor alloc] init];
	self.color.alpha = 0.9;
	return self;
}

-(id)initWithColor:(QColor*)col
{
	self = [super init];
	self.colorSpace = CGColorSpaceCreateDeviceRGB();
	self.offset = 5.0;
	self.yoffset = self.offset;
	self.blur = 1;
	self.color = col;
	return self;
}
-(id)initWithBlur:(float)b O:(float)o C:(QColor *)col
{
	self = [super init];
	self.colorSpace = CGColorSpaceCreateDeviceRGB();
	self.offset = o;
	self.yoffset = o;
	self.blur = b;
	self.color = col;
	return self;
}

-(id)initWithBlur:(float)b O:(float)o YO:(float)y
{
	self = [super init];
	self.colorSpace = CGColorSpaceCreateDeviceRGB();
	self.offset = o;
	self.yoffset = y;
	self.blur = b;
	self.color = [[QColor alloc] init];
	self.color.alpha = 1.0f;
	return self;	
}

-(id)initWithBlur:(float)b O:(float)o YO:(float)y C:(QColor *)col
{
	self = [super init];
	self.colorSpace = CGColorSpaceCreateDeviceRGB();
	self.offset = o;
	self.yoffset = y;
	self.blur = b;
	self.color = col;
	return self;
}

-(void)update:(QContext *)context
{
	if (self.colorRef != NULL)
	{
		CGColorRelease(self.colorRef);
		self.colorRef = NULL;
	}
	float vals[] = {self.color.red,self.color.blue,self.color.green,self.color.alpha};
	self.colorRef = CGColorCreate(self.colorSpace, 
								  vals);
	//if (vals != nil)
	//	free(vals);
	CGContextSetShadowWithColor(context.context, 
								CGSizeMake(self.offset,self.yoffset), 
								self.blur, 
								self.colorRef);
}

-(void)dealloc
{
	[self.color autorelease];
	if (self.colorSpace != NULL)
	{
		CGColorSpaceRelease(self.colorSpace);	
	}
	[super dealloc];
}

#pragma mark Encoder and Decoder.
/**
 Read data from an nscoder.
 **/
-(id)initWithCoder:(NSCoder *)aDecoder
{
	[super initWithCoder:aDecoder];
	self.colorSpace = CGColorSpaceCreateDeviceRGB();
	self.offset = [aDecoder decodeFloatForKey:@"offset"];
	self.yoffset = [aDecoder decodeFloatForKey:@"yoffset"];
	self.blur = [aDecoder decodeFloatForKey:@"blur"];
	self.color = [aDecoder decodeObjectForKey:@"color"];
	return self;
}

/**
 Write data to an nscoder.
 **/
-(void)encodeWithCoder:(NSCoder *)aCoder
{
	[super encodeWithCoder:aCoder];
	[aCoder encodeObject:self.color forKey:@"color"];
	[aCoder encodeFloat:self.offset forKey:@"offset"];
	[aCoder encodeFloat:self.yoffset forKey:@"yoffset"];
	[aCoder encodeFloat:self.blur forKey:@"blur"];
}

@end
