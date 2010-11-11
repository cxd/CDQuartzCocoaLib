//
//  QFillPath.m
//  QuartzCocoaLib
//
//  Created by Chris Davey on 4/07/09.
//  Copyright 2009 none. All rights reserved.
//

#import "QFillPath.h"


@implementation QFillPath


-(id)init
{
	self = [super init];
	return self;
}

-(void)update:(QContext*)context
{
	CGContextFillPath(context.context);
}

#pragma mark Encoder and Decoder.
/**
 Read data from an nscoder.
 **/
-(id)initWithCoder:(NSCoder *)aDecoder
{
	return [super initWithCoder:aDecoder];	
}
/**
 Write data to an nscoder.
 **/
-(void)encodeWithCoder:(NSCoder *)aCoder
{
	[super encodeWithCoder:aCoder];	
}
@end
