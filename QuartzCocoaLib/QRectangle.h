//
//  QRectangle.h
//  QuartzCocoaLib
//
//  Created by Chris Davey on 4/07/09.
//  Copyright 2009 none. All rights reserved.
//

#import "QFramework.h"
#import "QAbstractContextModifier.h"
#import "QContext.h"


@interface QRectangle : QAbstractContextModifier {
	float x;
	float y;
	float width;
	float height;
}


@property float x;
@property float y;
@property float width;
@property float height;

-(id)initWithX:(float)xcoord Y:(float)ycoord WIDTH:(float)w HEIGHT:(float)h;
-(id)initWithRect:(CGRect) rect;
-(void)update:(QContext*) context;
-(QRectangle*)getBoundary;

@end
