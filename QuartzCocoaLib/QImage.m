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


-(id)initWithUrl:(NSString *)url X:(float)x Y:(float)y
{
	self = [super init];
	self.anchor = [[QPoint alloc] initWithX:x Y:y];
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
	self.anchor = [[QPoint alloc] initWithX:x Y:y];
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
	CGImageRelease(self.imageRef);
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
	return [[QRectangle alloc] initWithX:self.anchor.x Y:self.anchor.y WIDTH:self.width HEIGHT:self.height];
}

@end
