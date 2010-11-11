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

@interface QAbstractContextModifier : NSObject <QContextModifier, NSCoding> {
	
}
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
