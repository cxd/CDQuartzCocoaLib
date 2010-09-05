//
//  BezierLineConnector.m
//  CDQuartzGraph
//
//  Created by Chris Davey on 14/08/10.
//  Copyright 2010 none. All rights reserved.
//

#import "BezierLineConnector.h"


@implementation BezierLineConnector

@synthesize curve;
@synthesize strokeColor;
@synthesize strokeWidth;

/**
 Default initialisation.
 Rectangle is by default 150 x 150
 **/
-(id)init
{
	self = [super init];
	self.bounds.width = 150;
	self.bounds.height = 150;
	[self initialiseRect:self.bounds];
	return self;
}

/**
 Initialise with bounds.
 **/
-(id)initWithBounds:(QRectangle *)b
{
	self = [super initWithBounds:b];
	[self initialiseRect:self.bounds];
	return self;
}

/**
 Default initialisation.
 **/
-(id)initWithLabel:(NSString *)l
{
	self = [super initWithLabel:l];
	self.bounds.width = 150;
	self.bounds.height = 150;
	[self initialiseRect:self.bounds];
	return self;	
}

/**
 Initialise with bounds and label.
 **/
-(id)initWithBounds:(QRectangle *)b AndLabel:(NSString *)l
{
	self = [super initWithBounds:b AndLabel:l];
	[self initialiseRect:self.bounds];
	return self;	
}


/**
 Dealloc.
 **/
-(void)dealloc
{
	if (self.curve != nil)
	{
		[self.curve autorelease];	
	}
	if (self.strokeColor != nil)
	{
		[self.strokeColor autorelease];	
	}
	if (self.strokeWidth != nil)
	{
		[self.strokeWidth autorelease];	
	}
	[super dealloc];
}

/**
 Initialise the line with default bounds.
 Use the diagonal of the bounds to set the key points.
 **/
-(void)initialiseRect:(QRectangle *)b
{
	self.strokeColor = [[QStrokeColor alloc] initWithRGB:0.0 G:0.0 B:0.0];
	self.strokeWidth = [[QStrokeWidth alloc] initWidth:2.0f];
	float sX = b.x;
	float sY = b.y;
	
	float eX = b.x + b.width;
	float eY = b.y + b.height;
	
	self.curve = [[QBezierCurve alloc] initX:sX Y:sY X2:eX Y2:eY CX1:sX CY1:sY CX2:eX CY2:eY];
	self.curve.isStart = YES;
	//self.curve.isEnd = YES;
	
	[self.queue enqueue:self.strokeColor];
	[self.queue enqueue:self.strokeWidth];
	[self.queue enqueue:self.curve];
	[self.queue enqueue:[[QStrokePath alloc] init]];
}

/**
 Event raised when outline weight has changed.
 **/
-(void)onOutlineWeightChanged
{
	strokeWidth.width = self.outlineWeight;	
}


/**
 Event raised when outline color changed.
 **/
-(void)onOutlineColorChanged
{
	strokeColor.red = self.outlineColor.red;
	strokeColor.blue = self.outlineColor.blue;
	strokeColor.green = self.outlineColor.green;
	strokeColor.alpha = self.outlineColor.alpha;
}


/**
 Connect the start line to supplied port.
 **/
-(void)connectStartTo:(AbstractPortShape *)port
{
	[super connectStartTo:port];
}

/**
 Connect the end line to supplied port.
 **/
-(void)connectEndTo:(AbstractPortShape *)port
{
	[super connectEndTo:port];
	
}

/**
 Update Connections.
 **/
-(void)updateConnections
{
	[super updateConnections];
	float sX, sY, sCX, sCY, eX, eY, eCX, eCY = 0.0;
	if (self.startPort != nil)
	{
		sX = self.startPort.bounds.x + self.startPort.bounds.width/2.0;
		sY = self.startPort.bounds.y + self.startPort.bounds.height/2.0;
	}
	if (self.endPort != nil)
	{
		eX = self.endPort.bounds.x + self.endPort.bounds.width/2.0;
		eY = self.endPort.bounds.y + self.endPort.bounds.height/2.0;
		if ((sX - eX < 0) && (sY - eY < 0))
		{
			eX = self.endPort.bounds.x;
		}
	}
	
	// calculate a control point for start of curve.
	
	if (sX < eX)
	{
		sCX = sX + 20;
		eCX = eX - 20;
	}
	else 
	{
		sCX = sX - 20;
		eCX = eX + 20;
	}
	if (sY < eY)
	{
		sCY = sY + 20;
		eCY = eY - 20;
	} else 
	{
		sCY = sY - 20;
		eCY = eY + 20;
	}

	self.curve.start.x = sX;
	self.curve.start.y = sY;
	self.curve.control1.x = sCX;
	self.curve.control1.y = sCY;
	self.curve.end.x = eX;
	self.curve.end.y = eY;
	self.curve.control2.x = eCX;
	self.curve.control2.y = eCY;
	// calculate a control point for end of curve.
	
}

-(void)moveStartBy:(QPoint *)p
{
	[super moveStartBy:p];
	self.curve.start.x += p.x;
	self.curve.start.y += p.y;
}

-(void)moveEndBy:(QPoint *)p
{
	[super moveEndBy:p];
	self.curve.end.x += p.x;
	self.curve.end.y += p.y;
}

-(void)moveStartTo:(QPoint *)p
{
	[super moveStartTo:p];
	self.curve.start.x = p.x;
	self.curve.start.y = p.y;
}

-(void)moveEndTo:(QPoint *)p
{
	[super moveEndTo:p];
	self.curve.end.x = p.x;
	self.curve.end.y = p.y;
}

@end
