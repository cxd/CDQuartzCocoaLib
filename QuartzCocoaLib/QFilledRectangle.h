//
//  QRectangle.h
//  QuartzCocoaLib
//
//  Created by Chris Davey on 30/06/09.
//  Copyright 2009 none. All rights reserved.
//

#import "QFramework.h"
#import "QContextModifier.h"
#import "QContext.h"
#import "QRectangle.h"
#import "QBoundedObject.h"

@interface QFilledRectangle : QRectangle <QBoundedObject> {
}

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
