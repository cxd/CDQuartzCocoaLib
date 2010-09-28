//
//  QGraphViewOperation.h
//  CDQuartzGraph
//
//  Created by Chris Davey on 14/09/10.
//  Copyright 2010 none. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDGraphViewState.h"
#import "CDGraphViewOperation.h"

@interface QGraphViewOperation : NSObject<CDGraphViewOperation> {
	/**
	 The next set of valid states.
	 **/
	NSMutableArray *children;
}

/**
 The next set of valid states.
 **/
@property(retain) NSMutableArray *children;

/**
 Does the operation apply to the current state.
 **/
-(BOOL)appliesTo:(CDGraphViewState *)state;

/**
 Update the state. 
 **/
-(void)update:(CDGraphViewState *)state;

@end
