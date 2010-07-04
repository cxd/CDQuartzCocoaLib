//
//  QContext.h
//  QuartzCocoaLib
//
//  Created by Chris Davey on 30/06/09.
//  Copyright 2009 none. All rights reserved.
//

#import "QFramework.h"



@interface QContext : NSObject {
	CGContextRef context;
}

@property(assign) CGContextRef context;

-(id)initWithContext:(CGContextRef) graphicsContext;
-(void)dealloc;
-(void)flipW:(float)w H:(float)h;

@end
