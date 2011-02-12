//
//  EcmascriptBounds.h
//  CDQuartzGraph
//
//  Created by Chris Davey on 7/02/11.
//  Copyright 2011 cd. All rights reserved.
//

#import "CDQuartzGraphHeader.h"
#import <WebKit/WebKit.h>

/**
 Ecmascript bounds object.
 **/
@interface ESBounds : NSObject {
	float x;
	float y;
	float width;
	float height;
}

@property(assign) float x;
@property(assign) float y;
@property(assign) float width;
@property(assign) float height;

@end
