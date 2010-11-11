//
//  QModifierQueue.h
//  QuartzCocoaLib
//
//  Created by Chris Davey on 30/06/09.
//  Copyright 2009 none. All rights reserved.
//


#import "QFramework.h"
#import "QContextModifier.h"
#import "QAbstractContextModifier.h"
#import "QVisitor.h"


/*
 A modifier queue allows the user to queue a series
 of modifications that can be applied into a QContext.
 
 A QModifierQueue can be passed between contexts
 and once applied a copy if returned.
 
 */
@interface QModifierQueue : NSObject<NSCoding> {
	NSMutableArray *sequence;
}


-(id)init;
-(void)enqueue:(id<QContextModifier>) modifier;
-(id<QContextModifier>)dequeue;
-(id<QContextModifier>)top;
-(id<QContextModifier>)tail;
-(BOOL)isEmpty;
-(void)clear;
-(void)dealloc;

+(QModifierQueue *)updateContext:(QContext *)context SourceQueue:(QModifierQueue *)source;

+(QModifierQueue *)traverseQueue:(QModifierQueue *)source Visitor:(id <QVisitor>)visitor Args:(id)arguments;

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
