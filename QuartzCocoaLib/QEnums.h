/*
 *  QEnums.h
 *  QuartzCocoaLib
 *
 *  Created by Chris Davey on 4/07/09.
 *  Copyright 2009 none. All rights reserved.
 *
 */
#import "QFramework.h"
// line styles for corners.
typedef enum  {
	QLineCapButted = kCGLineCapButt,
	QLineCapRounded = kCGLineCapRound,
	QLineCapSquared = kCGLineCapSquare
} LineCap;

// join styles for connected paths.
typedef enum {
	QJoinCapBevel = kCGLineJoinBevel,
	QJoinCapRounded = kCGLineJoinRound,
	QJoinCapSquared = kCGLineJoinMiter
} JoinCap;

// blend styles for graphics context
typedef enum {
	QBlendNormal = kCGBlendModeNormal, 
    QBlendMultiply = kCGBlendModeMultiply, 
    QBlendScreen = kCGBlendModeScreen, 
    QBlendOverlay = kCGBlendModeOverlay, 
    QBlendDarken = kCGBlendModeDarken, 
    QBlendLighten = kCGBlendModeLighten, 
    QBlendDodge = kCGBlendModeColorDodge, 
    QBlendBurn = kCGBlendModeColorBurn, 
    QBlendSoftLight = kCGBlendModeSoftLight, 
    QBlendHardLight = kCGBlendModeHardLight, 
    QBlendDifference = kCGBlendModeDifference, 
    QBlendExclusion = kCGBlendModeExclusion, 
    QBlendHue = kCGBlendModeHue, 
    QBlendSaturation = kCGBlendModeSaturation, 
    QBlendColor = kCGBlendModeColor, 
    QBlendLuminosity = kCGBlendModeLuminosity, 
    QBlendClear = kCGBlendModeClear, 
    QBlendCopy = kCGBlendModeCopy, 
    QBlendSourceIn = kCGBlendModeSourceIn, 
    QBlendSourceOut = kCGBlendModeSourceOut, 
    QBlendSourceTop = kCGBlendModeSourceAtop, 
    QBlendDestinationOver = kCGBlendModeDestinationOver, 
    QBlendDestinationIn = kCGBlendModeDestinationIn, 
    QBlendDestinationOut = kCGBlendModeDestinationOut, 
    QBlendTop = kCGBlendModeDestinationAtop, 
    QBlendXOR = kCGBlendModeXOR, 
    QBlendPlusDarker = kCGBlendModePlusDarker, 
    QBlendPlusLighter = kCGBlendModePlusLighter 
} BlendMode;
