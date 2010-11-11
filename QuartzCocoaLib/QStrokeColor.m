//
//  QStrokeColor.m
//  QuartzCocoaLib
//
//  Created by Chris Davey on 4/07/09.
//  Copyright 2009 none. All rights reserved.
//

#import "QStrokeColor.h"


@implementation QStrokeColor

-(void)update:(QContext*) context
{
	CGContextSetRGBStrokeColor (context.context, self.red, self.green, self.blue, self.alpha);
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
