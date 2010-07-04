//
//  QDrawable.h
//  QuartzCocoaLib
//
//  Created by Chris Davey on 30/06/09.
//  Copyright 2009 none. All rights reserved.
//
#import "QFramework.h"
#import "QContext.h"

@protocol QContextModifier

/**
 Change the supplied context.
 **/
-(void)update:(QContext *)context;

@end
