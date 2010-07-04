/*
 *  QVisitor.h
 *  QuartzCocoaLib
 *
 *  Created by Chris Davey on 7/07/09.
 *  Copyright 2009 none. All rights reserved.
 *
 */

#import "QContextModifier.h"

@protocol QVisitor

-(void)visit:(id <QContextModifier>)modifier data:(id)arguments;

@end
