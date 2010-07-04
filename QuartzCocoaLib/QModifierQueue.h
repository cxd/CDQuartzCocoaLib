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
@interface QModifierQueue : NSObject {
	NSMutableArray *sequence;
}


-(id)init;
-(void)enqueue:(QAbstractContextModifier *) modifier;
-(QAbstractContextModifier *)dequeue;
-(QAbstractContextModifier *)top;
-(QAbstractContextModifier *)tail;
-(BOOL)isEmpty;
-(void)clear;
-(void)dealloc;

+(QModifierQueue *)updateContext:(QContext *)context SourceQueue:(QModifierQueue *)source;

+(QModifierQueue *)traverseQueue:(QModifierQueue *)source Visitor:(id <QVisitor>)visitor Args:(id)arguments;

@end
