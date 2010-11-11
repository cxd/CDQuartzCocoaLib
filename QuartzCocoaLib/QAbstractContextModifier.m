//
//  QAbstractContextModifier.m
//  QuartzCocoaLib
//
//  Created by Chris Davey on 30/06/09.
//  Copyright 2009 none. All rights reserved.
//

#import "QAbstractContextModifier.h"


@implementation QAbstractContextModifier

-(void)update:(QContext*)context
{
	
}

#pragma mark Encoder and Decoder.
/**
 Read data from an nscoder.
 **/
-(id)initWithCoder:(NSCoder *)aDecoder
{
	return self;
}
/**
 Write data to an nscoder.
 **/
-(void)encodeWithCoder:(NSCoder *)aCoder
{
}

@end
