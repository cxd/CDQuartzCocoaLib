//
//  QStrokedRectangle.m
//  QuartzCocoaLib
//
//  Created by Chris Davey on 4/07/09.
//  Copyright 2009 none. All rights reserved.
//

#import "QStrokedRectangle.h"


@implementation QStrokedRectangle

-(void)update:(QContext*) context
{
	CGContextStrokeRect(context.context, CGRectMake(self.x, self.y, self.width, self.height)); 
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
