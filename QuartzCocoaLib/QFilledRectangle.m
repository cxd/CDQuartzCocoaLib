//
//  QRectangle.m
//  QuartzCocoaLib
//
//  Created by Chris Davey on 30/06/09.
//  Copyright 2009 none. All rights reserved.
//

#import "QFilledRectangle.h"


@implementation QFilledRectangle

-(void)update:(QContext*) context
{
	CGContextFillRect(context.context, CGRectMake(self.x, self.y, self.width, self.height)); 
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
