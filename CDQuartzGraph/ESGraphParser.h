//
//  ESGraphParser.h
//  CDQuartzGraph
//
//  Created by Chris Davey on 12/02/11.
//  Copyright 2011 cd. All rights reserved.
//

#import "CDQuartzGraphHeader.h"
#import "CDGraphViewState.h"
#import "CDGraphView.h"
#import "CDQuartzGraphHeader.h"
#import "CDQuartzGraph.h"
#import "CDQuartzNode.h"
#import "CDQuartzEdge.h"
#import "CurvedRectangleNode.h"
#import "RectangleNode.h"
#import "CircleNode.h"
#import "EllipseNode.h"

/**
 The graph parser is used to convert the supplied graph
 into an ecmascript JSON string for use in the
 scripting editor.
 **/
@interface ESGraphParser : NSObject {

	NSMutableString *builder;
	
	NSString* result;
	
	CDQuartzGraph *graph;
	
}

@property(retain,nonatomic) NSString* result;
@property(retain, nonatomic) NSMutableString* builder;
@property(retain, nonatomic) CDQuartzGraph* graph;

-(id)initWithGraph:(CDQuartzGraph *)g;
-(NSString *)parse;

@end
