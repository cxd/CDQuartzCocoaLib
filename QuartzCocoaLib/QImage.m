//
//  QImage.m
//  QuartzCocoaLib
//
//  Created by Chris Davey on 5/07/09.
//  Copyright 2009 none. All rights reserved.
//

#import "QImage.h"


@implementation QImage


@synthesize anchor;
@synthesize width;
@synthesize height;
@synthesize imageRef;

/**
 Allow parameterless constructor for NSCoding.
 **/
-(id)init
{
	self = [super init];
	return self;
}

-(id)initWithUrl:(NSString *)url X:(float)x Y:(float)y
{
	self = [super init];
	self.anchor = [[QPoint alloc] initX:x Y:y];
	CFURLRef urlRef;
	BOOL isHttp = NO;
	BOOL isJPG = NO;
	BOOL isPNG = NO;
	NSRange range = [url rangeOfString:@"http:" options:NSCaseInsensitiveSearch];
	if (range.location != NSNotFound)
	{
		isHttp = YES;
	}
	range = [url rangeOfString:@".jpg" options:NSCaseInsensitiveSearch];
	if (range.location != NSNotFound)
	{
		isJPG = YES;
	}
	range = [url rangeOfString:@".png" options:NSCaseInsensitiveSearch];
	if (range.location != NSNotFound)
	{
		isPNG = YES;
	}
	if (!isHttp)
	{
		urlRef = CFURLCreateWithFileSystemPath(NULL, 
											   (CFStringRef)url,
											   kCFURLPOSIXPathStyle,
											   false);
	} else {
		urlRef = CFURLCreateWithString(NULL,
									   (CFStringRef)url,
									   NULL);
	}
	CGDataProviderRef provider = CGDataProviderCreateWithURL(urlRef);
	CFRelease(urlRef);
	if (isJPG)
	{
		self.imageRef = CGImageCreateWithJPEGDataProvider(provider, 
														  NULL, 
														  true, 
														  kCGRenderingIntentDefault);
	} else {
		self.imageRef = CGImageCreateWithPNGDataProvider(provider, 
														  NULL, 
														  true, 
														  kCGRenderingIntentDefault);
	}
	CGDataProviderRelease(provider);
	self.width = CGImageGetWidth(self.imageRef);
	self.height = CGImageGetHeight(self.imageRef);
	return self;
}

-(id)initWithUrl:(NSString *)url POINT:(QPoint *)p
{
	self = [self initWithUrl:url X:p.x Y:p.y];
	return self;
}

-(id)initWithUrl:(NSString *)url X:(float)x Y:(float)y Width:(float)w Height:(float)h
{
	self = [self initWithUrl:url X:x Y:y];
	self.width = w;
	self.height = h;
	return self;
}

-(id)initWithUrl:(NSString *)url POINT:(QPoint *)p Width:(float)w Height:(float)h
{
	self = [self initWithUrl:url X:p.x Y:p.y];
	self.width = w;
	self.height = h;
	return self;
}

-(id)initWithResource:(NSString *)resource X:(float)x Y:(float)y
{
	self = [super init];
	self.anchor = [[QPoint alloc] initX:x Y:y];
	BOOL isJPG = NO;
	BOOL isPNG = NO;
	NSRange range = [resource rangeOfString:@".jpg" options:NSCaseInsensitiveSearch];
	if (range.location != NSNotFound)
	{
		isJPG = YES;
	}
	range = [resource rangeOfString:@".png" options:NSCaseInsensitiveSearch];
	if (range.location != NSNotFound)
	{
		isPNG = YES;
	}
	CFURLRef url;
    CFBundleRef mainBundle = CFBundleGetMainBundle();
	url = CFBundleCopyResourceURL(
								  mainBundle,
								  (CFStringRef)resource,
								  CFSTR("jpg"),
								  NULL);
	CGDataProviderRef provider = CGDataProviderCreateWithURL(url);
	if (isJPG)
	{
		self.imageRef = CGImageCreateWithJPEGDataProvider(provider, 
														  NULL, 
														  true, 
														  kCGRenderingIntentDefault);
	} else {
		self.imageRef = CGImageCreateWithPNGDataProvider(provider, 
														 NULL, 
														 true, 
														 kCGRenderingIntentDefault);
	} 
	CFRelease(url);
	CGDataProviderRelease(provider);
	self.width = CGImageGetWidth(self.imageRef);
	self.height = CGImageGetHeight(self.imageRef);
	
	return self;
}

-(void)dealloc
{
	if (self.imageRef != NULL)
	{
	CGImageRelease(self.imageRef);
	}
	[self.anchor autorelease];
	[super dealloc];
}

-(void)update:(QContext*)context
{
	CGRect rect = CGRectMake(self.anchor.x, self.anchor.y, self.width, self.height);
	CGContextDrawImage (context.context, rect, self.imageRef);
}

-(QRectangle*)getBoundary
{
	return [[QRectangle alloc] initX:self.anchor.x Y:self.anchor.y WIDTH:self.width HEIGHT:self.height];
}

#pragma mark Encoder and Decoder.
/**
 Read data from an nscoder.
 **/
-(id)initWithCoder:(NSCoder *)aDecoder
{
	[super initWithCoder:aDecoder];
	self.anchor = [aDecoder decodeObjectForKey:@"anchor"];
	self.width = [aDecoder decodeFloatForKey:@"width"];
	self.height = [aDecoder decodeFloatForKey:@"height"];
	BOOL hasImage = [aDecoder decodeBoolForKey:@"imageExists"];
	if (!hasImage) return self;
	
	// the following is supported on iOS4.2 but not iOS3.2
#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 42000
	// read the image from the memory buffer.
	NSMutableData *buffer = [aDecoder decodeObjectForKey:@"buffer"];
	[buffer retain];
	CGImageSourceRef source = CGImageSourceCreateWithData((CFDataRef)buffer, NULL);
	self.imageRef = CGImageSourceCreateImageAtIndex(source, 0, NULL);
	CFRelease(source);
	[buffer release];
#endif
	
#else
	
	// read the image from the memory buffer.
	NSMutableData *buffer = [aDecoder decodeObjectForKey:@"buffer"];
	[buffer retain];
	CGImageSourceRef source = CGImageSourceCreateWithData((CFDataRef)buffer, NULL);
	self.imageRef = CGImageSourceCreateImageAtIndex(source, 0, NULL);
	CFRelease(source);
	[buffer release];
	
#endif
	return self;
}
/**
 Write data to an nscoder.
 **/
-(void)encodeWithCoder:(NSCoder *)aCoder
{
	[super encodeWithCoder:aCoder];
	[aCoder encodeObject:self.anchor forKey:@"anchor"];
	[aCoder encodeFloat:self.width forKey:@"width"];
	[aCoder encodeFloat:self.height forKey:@"height"];
	
	if (self.imageRef == NULL)
	{
		[aCoder encodeBool:NO forKey:@"imageExists"];
		return;
	}
	[aCoder encodeBool:YES forKey:@"imageExists"];
	// copy the image reference to the buffer.
	// the following is supported on iOS4 but not iOS3.2
#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 42000
	NSMutableData *buffer = [NSMutableData data];
	[buffer retain];
	CGImageDestinationRef dest = CGImageDestinationCreateWithData((CFMutableDataRef)buffer, CFSTR("public.tiff"), 1, NULL);
	CGImageDestinationAddImage(dest, self.imageRef, NULL);
	CGImageDestinationFinalize(dest);
	CFRelease(dest);
	[aCoder encodeObject:buffer forKey:@"buffer"];
	[buffer release];
#endif
	
#else
	NSMutableData *buffer = [NSMutableData data];
	[buffer retain];
	CGImageDestinationRef dest = CGImageDestinationCreateWithData((CFMutableDataRef)buffer, CFSTR("public.tiff"), 1, NULL);
	CGImageDestinationAddImage(dest, self.imageRef, NULL);
	CGImageDestinationFinalize(dest);
	CFRelease(dest);
	[aCoder encodeObject:buffer forKey:@"buffer"];
	[buffer release];
	
#endif
}
@end
