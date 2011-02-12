//
//  ESColourParser.m
//  CDQuartzGraph
//
//  Created by Chris Davey on 9/02/11.
//  Copyright 2011 cd. All rights reserved.
//

#import "ESColourParser.h"


@implementation ESColourParser


@synthesize source;

@synthesize color;

/**
 Initialise parser with string.
 **/
-(id)initParser:(NSString*)s
{
	self = [super init];
	self.source = s;
	return self;
}

-(void)dealloc {
	self.source = nil;
	self.color = nil;
	[super dealloc];
}

/**
 Parse the source string.
 **/
-(QColor *)parseSource
{
	// tokenise the string.
	NSRange range = [self.source rangeOfString:@"rgba" options: NSCaseInsensitiveSearch];
	if (range.length == 0)
	{
		range = [self.source rangeOfString:@"rgb" options: NSCaseInsensitiveSearch];	
	}
	if (range.length == 0) 
		return nil;
	
	NSString *rest = [self.source substringWithRange:NSMakeRange(range.location + range.length, self.source.length - (range.location + range.length))];
	// search for brackets.
	range = [rest rangeOfString:@"("];
	if (range.length == 0)
		return nil;
	rest = [rest substringWithRange:NSMakeRange(range.location + range.length, rest.length + (range.location + range.length))];
	range = [rest rangeOfString:@")"];
	if (range.length == 0)
		return nil;
	rest = [rest substringWithRange:NSMakeRange(0, range.location)];
	// convert the rest into a set of values.
	NSScanner *scanner = [NSScanner scannerWithString:rest];
	NSString *input = @"";
	NSMutableArray *results = [[NSMutableArray alloc] initWithCapacity:3];
	while([scanner scanUpToString:@"," intoString:&input])
	{
		NSScanner *numScanner = [NSScanner scannerWithString:input];
		float n = 0.0f;
		if ([numScanner scanFloat:&n])
		{
			[results addObject:[NSNumber numberWithFloat:n]];	
		} else {
			[results addObject:[NSNumber numberWithFloat:1.0]];	
		}
	}
	while ([results count] < 4) {
		[results addObject:[NSNumber numberWithFloat:1.0]];
	}
	return [[[QColor alloc] initWithRGBA: [[results objectAtIndex:0] floatValue] 
									  G: [[results objectAtIndex:1] floatValue]
									  B: [[results objectAtIndex:2] floatValue]
									  A: [[results objectAtIndex:3] floatValue]] autorelease];
}




@end
