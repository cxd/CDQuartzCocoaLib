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

#pragma mark Encoder and Decoder.
/**
 Read data from an nscoder.
 **/
-(id)initWithCoder:(NSCoder *)aDecoder
{
	[super initWithCoder:aDecoder];
	self.mode = [aDecoder decodeIntForKey:@"mode"];	
	return self;
}
/**
 Write data to an nscoder.
 **/
-(void)encodeWithCoder:(NSCoder *)aCoder
{
	[super encodeWithCoder:aCoder];
	[aCoder encodeInt32:self.mode forKey:@"mode"];	
}

@end
