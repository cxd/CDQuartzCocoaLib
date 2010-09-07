//
//  TestGraphUIView.h
//  TestCDQuartzGraphTouch
//
//  Created by Chris Davey on 7/09/10.
//  Copyright 2010 none. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDQuartzGraphHeader.h"
#import "CDQuartzGraphLib.h"

@interface TestGraphUIView : UIGraphView {
	QModifierQueue *queue;
}

-(CDQuartzGraph *)createGraph;

@end
