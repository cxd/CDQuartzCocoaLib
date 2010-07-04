//
//  QPoint.h
//  QuartzCocoaLib
//
//  Created by Chris Davey on 4/07/09.
//  Copyright 2009 none. All rights reserved.
//

#import "QFramework.h"


@interface QPoint : NSObject {
	float x;
	float y;
}
@property(assign) float x;
@property(assign) float y;

-(id)init;
-(id)initWithX:(float)x Y:(float)y;
-(QPoint *)midPoint:(QPoint *)other;
-(float)distanceTo:(QPoint *)other;
-(float)horizontalDistanceTo:(QPoint *)other;
-(float)verticalDistanceTo:(QPoint *)other;



@end
