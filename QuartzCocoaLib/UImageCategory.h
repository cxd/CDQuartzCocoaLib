//
//  UImageCategory.h
//  QuartzCocoaLib
//
//  Created by Chris Davey on 28/06/10.
//  Copyright 2010 none. All rights reserved.
//

#import "QFramework.h"

#ifdef TARGET_OS_IPHONE


@interface UIImage(ImageExtensions)

-(void)readRawImageData:(unsigned char*)rawData;

-(NSArray*)rgbaUIColorForX:(int)xx andY:(int)yy count:(int)count;

-(NSArray*)rgba32BitVectorForX:(int)xx andY:(int)yy count:(int)count;

+(NSArray *)rgbaUIColorForPackedColor:(NSArray *)packedColors;


@end

#endif