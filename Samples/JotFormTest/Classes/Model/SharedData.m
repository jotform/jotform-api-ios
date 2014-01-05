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
@synthesize sampleStrList;

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
    NSString *sampleStr = @"Get all forms,Get all submissions,Get all reports,Create form,Create submission,Create report,Register user,Create question,Load & Update setting,Get history,Get form properties,Create form properties";
    
    sampleStrList = (NSMutableArray *)[sampleStr componentsSeparatedByString:@","];
}

- (void) initAPIClient : (NSString *) apiKey
{
    apiClient = [[JotForm alloc] initWithApiKey:apiKey debugMode:NO];
}

@end
