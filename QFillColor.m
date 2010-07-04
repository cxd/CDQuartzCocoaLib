//
//  QFillColor.m
//  QuartzCocoaLib
//
//  Created by Chris Davey on 30/06/09.
//  Copyright 2009 none. All rights reserved.
//

#import "QFillColor.h"


@implementation QFillColor


-(void)update:(QContext *)context
{
	CGContextSetRGBFillColor (context.context, self.red, self.green, self.blue, self.alpha);
}

@end
