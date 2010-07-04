//
//  QRestoreContext.h
//  QuartzCocoaLib
//
//  Created by Chris Davey on 4/07/09.
//  Copyright 2009 none. All rights reserved.
//

#import "QFramework.h"
#import "QAbstractContextModifier.h"

@interface QRestoreContext : QAbstractContextModifier {

}
-(id)init;
-(void)update:(QContext*)context;


@end
