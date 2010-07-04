//
//  UImageCategory.m
//  QuartzCocoaLib
//
//  Created by Chris Davey on 28/06/10.
//  Copyright 2010 none. All rights reserved.
//


#ifdef TARGET_OS_IPHONE

#import "UImageCategory.h"


@implementation UIImage(ImageExtensions)


-(void)readRawImageData:(unsigned char*)rawData
{
	// First get the image into your data buffer
    CGImageRef imageRef = [self CGImage];
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData, 
												 width, 
												 height,
												 bitsPerComponent, 
												 bytesPerRow, 
												 colorSpace,
												 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
	CGContextSetRGBFillColor(context, 1, 1, 1, 1);
	CGContextFillRect(context, CGRectMake(0, 0, width, height));
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
}

/**
 Access the pixel data for the image.
 start at xx and yy and read for count pixels.
 Data is returned as an array of UIColor.
 
 EG:
 
 NSArray *colors = [myImage getRGBAforX:0 andY:0 count:width*height];
 
 **/
-(NSArray*)rgbaUIColorForX:(int)xx andY:(int)yy count:(int)count
{
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:count];
	NSUInteger bytesPerPixel = 4;
    NSUInteger width = CGImageGetWidth([self CGImage]);
    NSUInteger height = CGImageGetHeight([self CGImage]);
    NSUInteger bytesPerRow = bytesPerPixel * width;
    unsigned char* rawData = malloc(height * width * 4);
    
	[self readRawImageData:rawData];
    	
    // Now your rawData contains the image data in the RGBA8888 pixel format.
    int byteIndex = (bytesPerRow * yy) + xx * bytesPerPixel;
    for (int ii = 0 ; ii < count ; ++ii)
    {
        CGFloat red   = (rawData[byteIndex]     * 1.0) / 255.0;
        CGFloat green = (rawData[byteIndex + 1] * 1.0) / 255.0;
        CGFloat blue  = (rawData[byteIndex + 2] * 1.0) / 255.0;
        CGFloat alpha = (rawData[byteIndex + 3] * 1.0) / 255.0;
        byteIndex += 4;
		
        UIColor *acolor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
        [result addObject:acolor];
    }
	
	free(rawData);
	
	return result;
}

/**
 Convert the image into a 32bit RGBA representation for
 each pixel.
 **/
-(NSArray*)rgba32BitVectorForX:(int)xx andY:(int)yy count:(int)count
{
	NSMutableArray *result = [NSMutableArray arrayWithCapacity:count];
	NSUInteger bytesPerPixel = 4;
    NSUInteger width = CGImageGetWidth([self CGImage]);
    NSUInteger height = CGImageGetHeight([self CGImage]);
    NSUInteger bytesPerRow = bytesPerPixel * width;
    unsigned char* rawData = malloc(height * width * 4);
    
	[self readRawImageData:rawData];
	
    // Now your rawData contains the image data in the RGBA8888 pixel format.
    int byteIndex = (bytesPerRow * yy) + xx * bytesPerPixel;
    for (int ii = 0 ; ii < count ; ++ii)
    {
        int red   = (rawData[byteIndex]     * 1.0) / 255.0;
        int green = (rawData[byteIndex + 1] * 1.0) / 255.0;
        int blue  = (rawData[byteIndex + 2] * 1.0) / 255.0;
        int alpha = (rawData[byteIndex + 3] * 1.0) / 255.0;
        byteIndex += 4;
		int value = (red << 24) | (green << 16) | (blue << 8) | alpha;
        [result addObject:[NSNumber numberWithInt:value]];
    }
	
	free(rawData);
	
	return result;
}

/**
 Unpack an array containing packed integers into an array
 of UIColors.
 **/
+(NSArray *)rgbaUIColorForPackedColor:(NSArray *)packedColors
{
	NSMutableArray *result = [NSMutableArray arrayWithCapacity:[packedColors count]];
	for(int i=0;i<[packedColors count];i++)
	{
		NSNumber* packed = [packedColors objectAtIndex:i];
		int pVal = [packed intValue];
		// unpack.
		int red = (pVal >> 24) & 0xff;
		int green = (pVal >> 16) & 0xff;
		int blue = (pVal >> 8) & 0xff;
		int alpha = (pVal & 0xff);
		UIColor *acolor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
        [result addObject:acolor];
	}
	return result;
}



@end

#endif