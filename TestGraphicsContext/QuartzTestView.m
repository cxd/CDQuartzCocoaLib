//
//  QuartzTestView.m
//  TestGraphicsContext
//
//  Created by Chris Davey on 30/06/09.
//  Copyright 2009 none. All rights reserved.
//

#import "QuartzTestView.h"


@implementation QuartzTestView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)rect {
	
    // a context reference.
	// contexts can reference any type of graphics context.
	if (context == nil)
	{
		context = [[QContext alloc] initWithContext:[[NSGraphicsContext currentContext] graphicsPort]];
		[context retain];
		queue = [[QModifierQueue alloc] init];
		[queue retain];
		
	
		// the set of instructions to store within a queue.
		[queue enqueue:[[QFillColor alloc] initWithRGBA:1 G:0 B:0 A: 1]];
		[queue enqueue:[[QFilledRectangle alloc] initX:10 Y:10 WIDTH:100 HEIGHT:100]];
		[queue enqueue:[[QFillColor alloc] initWithRGBA:0 G:0 B:1 A: 0.5]];
		[queue enqueue:[[QFilledRectangle alloc] initX:10 Y:120 WIDTH:100 HEIGHT:100]];
		
		// test stroke rectangle.
		[queue enqueue:[[QSaveContext alloc] init]];
		[queue enqueue:[[QStrokeWidth alloc] initWidth:5.0]];
		[queue enqueue:[[QStrokeColor alloc] initWithRGBA:0 G:0 B:1 A: 1]];
		[queue enqueue:[[QStrokedRectangle alloc] initX:10 Y:120 WIDTH:100 HEIGHT:100]];
		[queue enqueue:[[QRestoreContext alloc] init]];
		
		// test shadow and outline
		[queue enqueue:[[QSaveContext alloc] init]];
		[queue enqueue:[[QShadow alloc] initWithBlur:2.0 O:5.0 YO:-5.0]];
		
		[queue enqueue:[[QFillColor alloc] initWithRGBA:0 G:1 B:0 A:1]];
		[queue enqueue:[[QFilledRectangle alloc] initX:120 Y:120 WIDTH:100 HEIGHT:100]];
		[queue enqueue:[[QRestoreContext alloc] init]];
		
		
		[queue enqueue:[[QSaveContext alloc] init]];
		
		[queue enqueue:[[QLineCap alloc] initWithStyle:QLineCapRounded]];
		[queue enqueue:[[QJoinCap alloc] initWithStyle:QJoinCapRounded]];
		[queue enqueue:[[QStrokeWidth alloc] initWidth:5.0]];
		[queue enqueue:[[QStrokeColor alloc] initWithRGBA:0.0 G:0.5 B:0.0 A: 1]];
		[queue enqueue:[[QStrokedRectangle alloc] initX:120 Y:120 WIDTH:100 HEIGHT:100]];
		[queue enqueue:[[QRestoreContext alloc] init]];
		
		
		[queue enqueue:[[QSaveContext alloc] init]];
		
		[queue enqueue:[[QFillColor alloc] initWithRGBA:1.0 G:0.0 B:0.0 A:1]];
		[queue enqueue:[[QFilledEllipse alloc] initX:200 Y:250 WIDTH:200 HEIGHT:60]];
		[queue enqueue:[[QStrokeColor alloc] initWithRGBA:0.0 G:0.0 B:1.0 A:1]];
		[queue enqueue:[[QStrokeWidth alloc] initWidth:5]];
		[queue enqueue:[[QStrokedEllipse alloc] initX:200 Y:250 WIDTH:200 HEIGHT:60]];
		[queue enqueue:[[QRestoreContext alloc] init]];
		
		
		// create test shape yin/yan circle.
		[queue enqueue:[[QTestYinYang alloc] initWithCentre:[[QPoint alloc]initX:110 Y:110]]];
					
		// test loading an image from a url.
		[queue enqueue:[[QImage alloc] initWithUrl:@"http://devimages.apple.com/home/images/iphonedevcenter.png" X:10 Y:300]];

		[queue enqueue:[[QSaveContext alloc] init]];
		
		[queue enqueue:[[QFillColor alloc] initWithRGBA:1.0 G:0.5 B:1.0 A:0.5]];
		[queue enqueue:[[QFilledCircle alloc] initX:350 Y:100 Radius:50]];
		
		[queue enqueue:[[QStrokeColor alloc] initWithRGBA:0.0 G:1.0 B:0.0 A:1]];
		[queue enqueue:[[QStrokeWidth alloc] initWidth:15]];
		[queue enqueue:[[QStrokedCircle alloc] initX:350 Y:100 Radius:50]];
		
		[queue enqueue:[[QRestoreContext alloc] init]];
	
		[queue enqueue:[[QSaveContext alloc] init]];
		
		[queue enqueue:[[QFillColor alloc] initWithRGBA:1.0 G:0.0 B:0.0 A:1]];
		[queue enqueue:[[QFilledCurvedRectangle alloc] initX:200 Y:350 WIDTH:200 HEIGHT:60]];
		[queue enqueue:[[QStrokeColor alloc] initWithRGBA:0.0 G:0.0 B:1.0 A:1]];
		[queue enqueue:[[QStrokeWidth alloc] initWidth:5]];
		[queue enqueue:[[QStrokedCurvedRectangle alloc] initX:200 Y:350 WIDTH:200 HEIGHT:60]];
		[queue enqueue:[[QRestoreContext alloc] init]];
		
		
		
		[queue enqueue:[[QSaveContext alloc] init]];
		[queue enqueue:[[QStrokeColor alloc] initWithRGBA:0 G:0 B:0 A: 1]];
		[queue enqueue:[[QLabel alloc] initWithText:@"Test Text" X: 100 Y: 50 WIDTH:250 HEIGHT:100]];
		[queue enqueue:[[QRestoreContext alloc] init]];
	}
	
	QModifierQueue *copy = [QModifierQueue updateContext:context SourceQueue:queue];
	[queue autorelease];
	queue = copy;
	[copy retain];
}

@end
