//
//  QTestYinYang.m
//  QuartzCocoaLib
//
//  Created by Chris Davey on 5/07/09.
//  Copyright 2009 none. All rights reserved.
//

#import "QTestYinYang.h"


@implementation QTestYinYang


-(id)initWithCentre:(QPoint *)centre
{
	self = [super init];
	QFillColor *bgFill = [[QFillColor alloc]initWithRGB:1 G:1 B:1];
	QStrokeColor *bgStroke = [[QStrokeColor alloc] initWithRGB:0 G:0.5 B:1];
	QFillColor *fgFill = [[QFillColor alloc] initWithRGB:0 G:0.5 B:1];
	QArc *bgArc = [[QArc alloc] initWithCentre:centre 
										Radius:50 
									StartAngle:0.0 
									  EndAngle:360.0
										 START:YES 
										   END:YES 
									 CLOCKWISE:YES];
	QArc *centreArc01 = [[QArc alloc] initWithCentre:centre 
											  Radius:50 
										  StartAngle:90.0 
											EndAngle:270.0 
											   START:YES 
												 END:NO
										   CLOCKWISE:YES];
	
	QPoint *topArcCentre = [[QPoint alloc] initWithX:centre.x Y:centre.y + 25];
	
	QPoint *bottomArcCentre = [[QPoint alloc] initWithX:centre.x Y:centre.y - 25];
	
	QArc *topArc = [[QArc alloc] initWithCentre:topArcCentre
										 Radius: 25
									 StartAngle:90
									   EndAngle:270
										  START:NO
											END:YES
									  CLOCKWISE:NO];
	QArc *bottomArc = [[QArc alloc] initWithCentre:bottomArcCentre
											Radius: 25
										StartAngle:90
										  EndAngle:270
											 START:YES
											   END:YES];
	
	QPoint *topEyeCentre = [[QPoint alloc] initWithX:centre.x Y:centre.y + 25];
	QPoint *bottomEyeCentre = [[QPoint alloc] initWithX:centre.x Y:centre.y - 25];
	
	QArc *topEye = [[QArc alloc] initWithCentre:topEyeCentre
										 Radius: 10.0
									 StartAngle:0.0
									   EndAngle:360.0
										  START:YES
											END:YES];
	
	QArc *bottomEye = [[QArc alloc] initWithCentre:bottomEyeCentre
											Radius: 10.0
										StartAngle:0.0
										  EndAngle:360.0
											 START:YES
											   END:YES];
	
	
	[self add:bgStroke];
	
	[self add:[[QSaveContext alloc] init]];
	[self add:bgFill];
	[self add:[[QShadow alloc] initWithBlur:5.0 O:5.0 YO:-3.0]];
	[self add:bgArc];
	[self add:[[QFillPath alloc] init]];
	[self add:[[QRestoreContext alloc] init]];
	
	[self add:fgFill];
	[self add:centreArc01];
	
	
	[self add:topArc];
	[self add:[[QFillPath alloc] init]];
	
	[self add:bgFill];
	[self add:bottomArc];
	[self add:[[QFillPath alloc] init]];
	
	[self add:[[QSaveContext alloc] init]];
	[self add:[[QShadow alloc] initWithBlur:5.0 O:5.0 YO:-3.0]];
	
	[self add:bgFill];
	[self add:topEye];
	[self add:[[QFillPath alloc] init]];
	
	[self add:fgFill];
	[self add:bottomEye];
	[self add:[[QFillPath alloc] init]];
	
	[self add:[[QRestoreContext alloc] init]];
	return self;
}

@end
