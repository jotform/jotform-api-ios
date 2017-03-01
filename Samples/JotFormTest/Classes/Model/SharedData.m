//
//  SharedData.m
//  JotFormTest
//
//  Created by Interlogy, LLC on 1/5/14.
//  Copyright (c) 2014 Interlogy, LLC. All rights reserved.
//

#import "SharedData.h"

static SharedData *g_sharedInfo = nil;

@implementation SharedData

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
    NSString *sampleStr = @"Get all forms,Get all submissions,Get all reports,Create form,Create submission,Create report,Register user,Create question,Load & Update setting,Get history,Get form properties,Create form properties,Create Forms,Create Form Questions";
    
    self.sampleStrList = (NSMutableArray *)[sampleStr componentsSeparatedByString:@","];
}

- (void) initAPIClient : (NSString *) apiKey
{
    self.apiClient = [[JotForm alloc] initWithApiKey:apiKey debugMode:NO euApi:NO];
}

- (NSArray *) getFormOrderbyList
{
    NSString *orderbyStr = @"id,username,title,status,created_at,updated_at,new,count,slug";
    
    NSArray *orderbyList = [orderbyStr componentsSeparatedByString:@","];
    
    return orderbyList;
}

@end
