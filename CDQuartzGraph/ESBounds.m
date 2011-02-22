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


+ (NSString *)webScriptNameForSelector:(SEL)sel
{
	
    // change the javascript name from 'forward_' to 'forward' ...
	if (sel == @selector(setX:))
		return @"setX";
	if (sel == @selector(x))
		return @"getX";
	if (sel == @selector(setY:))
		return @"setY";
	if (sel == @selector(y))
		return @"getY";
	if (sel == @selector(setWidth:))
		return @"setWidth";
	if (sel == @selector(width))
		return @"getWidth";
	if (sel == @selector(setHeight:))
		return @"setHeight";
	if (sel == @selector(height))
		return @"getHeight";
	return nil;
}


@end
