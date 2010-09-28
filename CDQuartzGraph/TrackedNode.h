//
//  TrackedNode.h
//  CDQuartzGraphTouch
//
//  Created by Chris Davey on 6/09/10.
//  Copyright 2010 none. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDQuartzNode.h"

@interface TrackedNode : NSObject {

	int index;
	
	CDQuartzNode *node;
	
}

@property(assign) int index;

@property(retain) CDQuartzNode *node;

-(id)init;

-(id)initWithNode:(CDQuartzNode *)n atIndex:(int)i;

-(void)dealloc;

@end
