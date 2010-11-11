//
//  CDPersistantQuartzEdge.m
//  CDQuartzGraph
//
//  Created by Chris Davey on 10/11/10.
//  Copyright 2010 none. All rights reserved.
//

#import "CDPersistentQuartzEdge.h"


@implementation CDPersistentQuartzEdge

@synthesize edgeShape;

-(id)init
{
	self = [super init];
	return self;
}

-(void)dealloc
{
	if (self.edgeShape != nil)
	{
	[self.edgeShape autorelease];	
	}
	[super dealloc];
}

#pragma mark Encoder and Decoder.
/**
 Read data from an nscoder.
 **/
-(id)initWithCoder:(NSCoder *)aDecoder
{
	[super initWithCoder:aDecoder];
	self.edgeShape= [aDecoder decodeObjectForKey:@"edgeShape"];
	return self;
}
/**
 Write data to an nscoder.
 **/
-(void)encodeWithCoder:(NSCoder *)aCoder
{
	[super encodeWithCoder:aCoder];
	[aCoder encodeObject:self.edgeShape forKey:@"edgeShape"];
}
@end
