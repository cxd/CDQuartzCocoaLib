//
//  ESColourParser.h
//  CDQuartzGraph
//
//  Created by Chris Davey on 9/02/11.
//  Copyright 2011 cd. All rights reserved.
//

#import "CDQuartzGraphHeader.h"


/**
 The colour parser will accept an input string in the following format.
 
 <float> ::= 0.0 .. Z
 <rgb> ::= rgb(<float>, <float>, <float>)
 <rgba> ::= rgba(<float>, <float>, <float>)
 
 
 
 **/
@interface ESColourParser : NSObject {

	NSString *source;
	
	QColor *color;
}

@property(retain, nonatomic) NSString *source;
@property(retain, nonatomic) QColor *color;

/**
 Initialise parser with string.
 **/
-(id)initParser:(NSString*)s;

/**
 Parse the source string.
 **/
-(QColor *)parseSource;



@end
