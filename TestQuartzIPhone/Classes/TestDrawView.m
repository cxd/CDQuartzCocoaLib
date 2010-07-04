//
//  TestDrawView.m
//  TestQuartzIPhone
//
//  Created by Chris Davey on 5/07/09.
//  Copyright 2009 none. All rights reserved.
//

#import "TestDrawView.h"


@implementation TestDrawView


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
	// a context reference.
	// contexts can reference any type of graphics context.
	QContext *context = [[QContext alloc] initWithContext:UIGraphicsGetCurrentContext()];
	[context retain];
	[context flipW:0.0 H:rect.size.height];
	
	QModifierQueue *queue = [[QModifierQueue alloc] init];
	[queue retain];
	
	// the set of instructions to store within a queue.
	[queue enqueue:[[QFillColor alloc] initWithRGBA:1 G:0 B:0 A: 1]];
	[queue enqueue:[[QFilledRectangle alloc] initWithX:10 Y:10 WIDTH:100 HEIGHT:100]];
	[queue enqueue:[[QFillColor alloc] initWithRGBA:0 G:0 B:1 A: 0.5]];
	[queue enqueue:[[QFilledRectangle alloc] initWithX:10 Y:120 WIDTH:100 HEIGHT:100]];
	
	// test stroke rectangle.
	[queue enqueue:[[QSaveContext alloc] init]];
	[queue enqueue:[[QStrokeWidth alloc] initWidth:5.0]];
	[queue enqueue:[[QStrokeColor alloc] initWithRGBA:0 G:0 B:1 A: 1]];
	[queue enqueue:[[QStrokedRectangle alloc] initWithX:10 Y:120 WIDTH:100 HEIGHT:100]];
	[queue enqueue:[[QRestoreContext alloc] init]];
	
	// test shadow and outline
	[queue enqueue:[[QSaveContext alloc] init]];
	[queue enqueue:[[QFillColor alloc] initWithRGBA:0 G:1 B:0 A:1]];
	[queue enqueue:[[QShadow alloc] initWithBlur:5.0 O:8.0 YO:-8.0]];
	[queue enqueue:[[QFilledRectangle alloc] initWithX:120 Y:120 WIDTH:100 HEIGHT:100]];
	[queue enqueue:[[QRestoreContext alloc] init]];
	[queue enqueue:[[QLineCap alloc] initWithStyle:QLineCapRounded]];
	[queue enqueue:[[QJoinCap alloc] initWithStyle:QJoinCapRounded]];
	[queue enqueue:[[QStrokeWidth alloc] initWidth:5.0]];
	[queue enqueue:[[QStrokeColor alloc] initWithRGBA:0.0 G:0.5 B:0.0 A: 1]];
	[queue enqueue:[[QStrokedRectangle alloc] initWithX:120 Y:120 WIDTH:100 HEIGHT:100]];
	
	// create test shape yin/yan circle.
	[queue enqueue:[[QTestYinYang alloc] initWithCentre:[[QPoint alloc]initWithX:110 Y:110]]];
	
	// test loading an image from a url.
	[queue enqueue:[[QImage alloc] initWithUrl:@"http://devimages.apple.com/home/images/iphonedevcenter.png" X:10 Y:300]];
	
	
	QModifierQueue *copy = [QModifierQueue updateContext:context SourceQueue:queue];
	[copy autorelease];
	[queue release];
	[context release];
}


- (void)dealloc {
    [super dealloc];
}


@end
