//
//  QRectangle.m
//  QuartzCocoaLib
//
//  Created by Chris Davey on 4/07/09.
//  Copyright 2009 none. All rights reserved.
//

#import "QRectangle.h"


@implementation QRectangle


@synthesize x;
@synthesize y;
@synthesize width;
@synthesize height;

-(id)initX:(float)xcoord Y:(float)ycoord WIDTH:(float)w HEIGHT:(float)h
{
	self = [super init];
	self.x = xcoord;
	self.y = ycoord;
	self.width = w;
	self.height = h;
	return self;
}

-(id)initWithRect:(CGRect) rect {
	self = [super init];
	self.x = rect.origin.x;
	self.y = rect.origin.y;
	self.width = rect.size.width;
	self.height = rect.size.height;
	return self;
}

-(void)update:(QContext*) context
{
}


-(QRectangle*)getBoundary
{
	return self;	
}


/**
 Calculate the midpoint of this rectangle.
 **/
-(QPoint *)midPoint
{
	return [[QPoint alloc] initX:self.x + (self.width/ 2.0f) Y:self.y + (self.height/2.0f)];	
}

@end
