//
//  TestGraphView.h
//  TestCDQuartzGraph
//
//  Created by Chris Davey on 18/08/10.
//  Copyright 2010 none. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "QuartzCocoaLib/QuartzCocoaLib.h"
#import "CDGraph/CDGraph.h"
#import "CDQuartzGraph/CDQuartzGraphLib.h"

@interface TestGraphView : CDGraphView {
	QModifierQueue *queue;
}

-(CDQuartzGraph *)createGraph;
@end
