//
//  QAbstractContextModifier.h
//  QuartzCocoaLib
//
//  Created by Chris Davey on 30/06/09.
//  Copyright 2009 none. All rights reserved.
//

#import "QFramework.h"
#import "QContextModifier.h"
#import "QContext.h"

@interface QAbstractContextModifier : NSObject <QContextModifier> {
	
}
-(void)update:(QContext*)context;

@end
