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

@end
