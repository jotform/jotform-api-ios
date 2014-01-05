//
//  SharedData.m
//  JotFormTest
//
//  Created by Administrator on 1/5/14.
//  Copyright (c) 2014 Interlogy, LLC. All rights reserved.
//

#import "SharedData.h"

static SharedData *g_sharedInfo = nil;

@implementation SharedData
@synthesize apiClient;

- (id) init {
	if ( self = [super init] ) {
		[self initSharedData];
	}
	return self;
}

+ (SharedData *) sharedData {
    
	if (g_sharedInfo == nil) {
		g_sharedInfo = [[SharedData alloc] init];
	}
    
	return g_sharedInfo;
}

- (void) initSharedData
{

}

- (void) initAPIClient : (NSString *) apiKey
{
    apiClient = [[JotForm alloc] initWithApiKey:apiKey debugMode:NO];
}

@end
