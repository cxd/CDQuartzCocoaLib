//
//  CDPersistantQuartzEdge.h
//  CDQuartzGraph
//
//  Created by Chris Davey on 10/11/10.
//  Copyright 2010 none. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDGraph/CDPersistedEdge.h"
#import "AbstractConnectorShape.h"

/**
 The persistant quartz edge is used to
 store edges in the same way the persistent edge is used.
 however this also stores shapedelegate information and port connection information.
 **/
@interface CDPersistentQuartzEdge : CDPersistedEdge {
	// a reference to the shape delegate
	AbstractConnectorShape *edgeShape;
}

@property(retain) AbstractConnectorShape *edgeShape;

-(id)init;

-(void)dealloc;

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
