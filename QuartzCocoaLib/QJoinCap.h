//
//  QJoinCap.h
//  QuartzCocoaLib
//
//  Created by Chris Davey on 4/07/09.
//  Copyright 2009 none. All rights reserved.
//

#import "QFramework.h"
#import "QAbstractContextModifier.h"
#import "QEnums.h"

@interface QJoinCap : QAbstractContextModifier {
	JoinCap style;
}
@property(assign) JoinCap style;

-(id)init;
-(id)initWithStyle:(JoinCap)cap;
-(void)update:(QContext*)context;

@end
