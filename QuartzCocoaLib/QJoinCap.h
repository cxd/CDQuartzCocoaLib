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

#pragma mark Encoder and Decoder.
/**
 Read data from an nscoder.
 **/
-(id)initWithCoder:(NSCoder *)aDecoder;
/**
 Write data to an nscoder.
 **/
-(void)encodeWithCoder:(NSCoder *)aCoder;

@end
