//
//  CDGraphViewOperation.h
//  CDQuartzGraph
//
//  Created by Chris Davey on 16/09/10.
//  Copyright 2010 none. All rights reserved.
//

#import "CDGraphViewState.h"

@protocol CDGraphViewOperation


/**
 Does the operation apply to the current state.
 **/
-(BOOL)appliesTo:(CDGraphViewState *)state;

/**
 Update the state. 
 **/
-(void)update:(CDGraphViewState *)state;

@end
