//
//  GraphStateNotifications.m
//  CDQuartzGraph
//
//  Created by Chris Davey on 2/12/10.
//  Copyright 2010 cd. All rights reserved.
//

#import "GraphStateNotifications.h"


@implementation GraphStateNotifications

/**
 The node selected notification
 issues an NSNotification with a user dictionary
 containing the tuple ("node", CDQuartzGraphNode)
 **/
+(NSString*)nodeSelected
{
	return @"CDQuartzGraphNode_Selected";	
}

/**
 The node deleted notification
 issues an NSNotification with a user dictionary containing the tuple
 ("node", CDQuartzGraphNode)
 **/
+(NSString*)nodeDeleted
{
	return @"CDQuartzGraphNode_Deleted";	
}

/**
 The node added notification issues
 an NSNotification with a user dictionary containing the tuple
 ("node", CDQuartzGraphNode)
 **/
+(NSString*)nodeAdded
{
	return @"CDQuartzGraphNode_Added";		
}

/**
 A node has collided with another node.
 UserInfo contains
 ("srcNode", node) ("otherNode", collidingNode)
 **/
+(NSString*)nodeCollision
{
	return @"CDQuartzGraphNode_Collided";	
}


/**
 The node selected notification
 issues an NSNotification with a user dictionary
 containing the tuple ("node", CDQuartzGraphNode)
 **/
+(void)raiseNodeSelected:(CDGraphViewState*)sender node:(CDQuartzNode*)n
{
	[[NSNotificationCenter defaultCenter] 
	 postNotificationName:[GraphStateNotifications nodeSelected]
	 object:sender
	 userInfo:[[[NSDictionary alloc] 
				initWithObjectsAndKeys:n, @"node", nil] autorelease]];
}

/**
 The node deleted notification
 issues an NSNotification with a user dictionary containing the tuple
 ("node", CDQuartzGraphNode)
 **/
+(void)raiseNodeDeleted:(CDGraphViewState*)sender node:(CDQuartzNode*)n
{
	[[NSNotificationCenter defaultCenter] 
	 postNotificationName:[GraphStateNotifications nodeDeleted]
	 object:sender
	 userInfo:[[[NSDictionary alloc] initWithObjectsAndKeys:n, @"node", nil]
			   autorelease]];
}

/**
 The node added notification issues
 an NSNotification with a user dictionary containing the tuple
 ("node", CDQuartzGraphNode)
 **/
+(void)raiseNodeAdded:(CDGraphViewState*)sender node:(CDQuartzNode*)n
{
	[[NSNotificationCenter defaultCenter] 
	 postNotificationName:[GraphStateNotifications nodeAdded]
	 object:sender
	 userInfo:[[[NSDictionary alloc] initWithObjectsAndKeys:n, @"node", nil] 
			   autorelease]];
}

/**
Raise the collision event.
UserInfo contains
("srcNode", node) ("otherNode", collidingoNode)
**/
+(void)raiseNodeCollided:(CDGraphViewState*)sender node:(CDQuartzNode *)n otherNode:(CDQuartzNode*)o
{
	[[NSNotificationCenter defaultCenter] 
	 postNotificationName:[GraphStateNotifications nodeCollision]
	 object:sender
	 userInfo:[[[NSDictionary alloc] initWithObjectsAndKeys:
			   n, @"node", 
			   o, @"otherNode", nil] autorelease]];	
}

@end
