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

@end
