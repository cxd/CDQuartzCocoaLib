//
//  EcmascriptShapeDescription.h
//  CDQuartzGraph
//
//  Created by Chris Davey on 7/02/11.
//  Copyright 2011 cd. All rights reserved.
//

#import "CDQuartzGraphHeader.h"
#import <WebKit/WebKit.h>
#import "AbstractNodeShape.h"
#import "ESBounds.h"
#import "ESColourParser.h"
#import "RectangleNode.h"
#import "CurvedRectangleNode.h"
#import "EllipseNode.h"
#import "CircleNode.h"

/**
 An ecmascript shape description provides a way in which
 to describe available shapes from within ecmascript.
 **/
@interface ESShapeDescription : NSObject {
	
	NSString *shapeType;
	
	NSString *color;
	
	NSString *outlineColor;
	
	NSString *labelText;
	
	float alpha;
	
	float outlineWidth;
	
	ESBounds *bounds;
	
	
}

@property(retain) NSString *shapeType;

@property(retain) NSString *color;

@property(retain) NSString *outlineColor;

@property(retain) NSString *labelText;

@property(assign) float alpha;

@property(assign) float outlineWidth;

@property(retain) ESBounds *bounds;


-(id)init;

-(void)dealloc;

/**
 Create a shape based on the value of shapeType.
 The bounds property must be not nil.
 
 There are only 4 supported shapes currently.
 
 RECT
 CURVED_RECT
 ELLIPSE
 CIRCLE
 
 **/
-(AbstractNodeShape *)createShape;



@end
