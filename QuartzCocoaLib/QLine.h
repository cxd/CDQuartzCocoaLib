//
//  QLine.h
//  QuartzCocoaLib
//
//  Created by Chris Davey on 4/07/09.
//  Copyright 2009 none. All rights reserved.
//

#import "QFramework.h"
#import "QAbstractContextModifier.h"
#import "QPoint.h"
#import "QBoundedObject.h"

@interface QLine : QAbstractContextModifier<QBoundedObject> {
	QPoint* start;
	QPoint* end;
	BOOL isStart;
	BOOL isEnd;
}

@property(retain) QPoint* start;
@property(retain) QPoint* end;
@property(assign) BOOL isStart;
@property(assign) BOOL isEnd;

-(id)initX: (float)x Y: (float)y X2: (float)xx Y2:(float)yy;
-(id)initX: (float)x Y:(float)y X2:(float)xx Y2:(float) yy START:(BOOL) s END:(BOOL) e;
-(id)initWithStart: (QPoint *)from Finish: (QPoint *)to;
-(id)initWithStart: (QPoint *)from Finish: (QPoint *)to START:(BOOL) s END:(BOOL) e;

-(void)dealloc;
-(void)update:(QContext *)context;
-(QRectangle*)getBoundary;
@end
