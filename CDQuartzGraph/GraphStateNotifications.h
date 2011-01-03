//
//  GraphStateNotifications.h
//  CDQuartzGraph
//
//  Created by Chris Davey on 2/12/10.
//  Copyright 2010 cd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDQuartzNode.h"
#import "CDGraphViewState.h"
/**
 A set of symbols that are used by the graph to signal
 events raised by the notification centre.
 **/
@interface GraphStateNotifications : NSObject {

}

/**
 The node selected notification
 issues an NSNotification with a user dictionary
 containing the tuple ("node", CDQuartzGraphNode)
 **/
+(NSString*)nodeSelected;

/**
 The node deleted notification
 issues an NSNotification with a user dictionary containing the tuple
 ("node", CDQuartzGraphNode)
 **/
+(NSString*)nodeDeleted;

/**
 The node added notification issues
 an NSNotification with a user dictionary containing the tuple
 ("node", CDQuartzGraphNode)
 **/
+(NSString*)nodeAdded;

/**
 A node has collided with another node.
 UserInfo contains
 ("srcNode", node) ("otherNode", collidingNode)
 **/
+(NSString*)nodeCollision;

/**
 The node selected notification
 issues an NSNotification with a user dictionary
 containing the tuple ("node", CDQuartzGraphNode)
 **/
+(void)raiseNodeSelected:(CDGraphViewState*)sender node:(CDQuartzNode*)n;

/**
 The node deleted notification
 issues an NSNotification with a user dictionary containing the tuple
 ("node", CDQuartzGraphNode)
 **/
+(void)raiseNodeDeleted:(CDGraphViewState*)sender node:(CDQuartzNode*)n;

/**
 The node added notification issues
 an NSNotification with a user dictionary containing the tuple
 ("node", CDQuartzGraphNode)
 **/
+(void)raiseNodeAdded:(CDGraphViewState*)sender node:(CDQuartzNode*)n;

/**
 Raise the collision event.
 UserInfo contains
 ("srcNode", node) ("otherNode", collidingoNode)
 **/
+(void)raiseNodeCollided:(CDGraphViewState*)sender node:(CDQuartzNode *)n otherNode:(CDQuartzNode*)o;

@end
