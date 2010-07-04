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

@end
