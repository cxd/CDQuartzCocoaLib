//
//  QShape.h
//  QuartzCocoaLib
//
//  Created by Chris Davey on 4/07/09.
//  Copyright 2009 none. All rights reserved.
//

#import "QFramework.h"
#import "QModifierQueue.h"
#import "QAbstractContextModifier.h"
#import "QBoundedObject.h"
#import "QRectangle.h"
#import "QVisitor.h"
#import "QContextModifier.h"

@interface QShape : QAbstractContextModifier<QBoundedObject,QVisitor> {

	QModifierQueue* queue;
	
}

@property(retain) QModifierQueue* queue;

-(id)init;
-(void)dealloc;
-(void)add:(QAbstractContextModifier *)modifier;
-(void)clear;
-(void)update:(QContext *)context;
-(QRectangle*)getBoundary;
-(void)visit:(id <QContextModifier>)modifier data:(id)arguments;
@end
