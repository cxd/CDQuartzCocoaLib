//
//  EcmascriptBounds.m
//  CDQuartzGraph
//
//  Created by Chris Davey on 7/02/11.
//  Copyright 2011 cd. All rights reserved.
//

#import "ESBounds.h"


@implementation ESBounds

@synthesize x;
@synthesize y;
@synthesize width;
@synthesize height;

-(id)init {
	self = [super init];
	return self;
}

-(void)dealloc {
	[super dealloc];	
}

+ (BOOL)isSelectorExcludedFromWebScript:(SEL)sel { 
	return NO;
	
}
+ (BOOL)isKeyExcludedFromWebScript:(const char *)name { 
	return NO;	
}


@end
