//
//  JotForm.m
//  JotForm
//
//  Created by Wang YuPing on 7/9/13.
//  Copyright (c) 2013 Interlogy, LLC. All rights reserved.
//

#import "JotForm.h"

@implementation JotForm
@synthesize operationQueue;

- (id) initWithApiKey : (NSString *) apikey debugMode : (BOOL) debugmode
{
    if ( self = [super init] ) {
        
        apiKey = apikey;
        debugMode = debugmode;
        baseUrl = BASE_URL;
        apiVersion = API_VERSION;
        operationQueue = [[NSOperationQueue alloc] init];
        
    }
    
    return self;
}

- (void) debugLog : (NSString *) str
{
    if ( debugMode == YES )
        NSLog(@"\n%@", str);
}

- (void) executeHttpRequest : (NSString *) path params : (NSMutableDictionary *) params method : (NSString *) method
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/%@", baseUrl, apiVersion, path];
    
    if ( [method isEqualToString:HTTPREQUEST_METHOD_GET] == YES ) {
        
        NSMutableArray *paramarray = [[NSMutableArray alloc] init];
        
        NSString *key;
        
        for ( id param in params ) {
            
            key = [param key];
            
            [paramarray addObject:[NSString stringWithFormat:@"%@=%@", key, [param objectForKey:key]]];
            
        }
        
        NSString *paramstr = [paramarray componentsJoinedByString:@"&"];
        
        [self debugLog:paramstr];
        
        urlStr = [NSString stringWithFormat:@"%@?%@", urlStr, paramstr];
        
        [paramarray release];
    }
    
    [self debugLog:urlStr];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [request setRequestMethod:method];
    [request setUserAgentString:USER_AGENT];
    [request addRequestHeader:@"apiKey" value:apiKey];
        
    if ( [method isEqualToString:HTTPREQUEST_METHOD_POST] ) {
        
        [self debugLog:@"posting"];
        
        NSArray *keys = [params allKeys];
        
        for ( NSString *key in keys )
            [request addPostValue:[params objectForKey:key] forKey:key];
    }
    
    [request setDelegate:self];
    [operationQueue addOperation:request];
}

- (void) executeGetRequest : (NSString *) url params : (NSMutableDictionary *) params
{
    return [self executeHttpRequest:url params:params method:HTTPREQUEST_METHOD_GET];
}

- (void) executePostRequest : (NSString *) url params : (NSMutableDictionary *) params
{
    return [self executeHttpRequest:url params:params method:HTTPREQUEST_METHOD_POST];
}

/**
 * Returns User object
 */

- (void) getUser
{
    [self executeGetRequest:@"user" params:nil];
}

/**
 * [getUserUsage description]
 */

- (void) getUsage
{
    [self executeGetRequest:@"user/usage" params:nil];
}

/**
 * [getForms description]
 */

- (void) getForms
{
    [self executeGetRequest:@"user/forms" params:nil];
}

/**
 * [getSubmissions description]
 */

- (void) getSubmissions
{
    [self executeGetRequest:@"user/submissions" params:nil];
}

/**
 * [getUserSubusers description]
 */

- (void) getSubusers
{
    [self executeGetRequest:@"user/subusers" params:nil];
}

/**
 * [getUserFolders description]
 */

- (void) getFolders
{
    [self executeGetRequest:@"user/folders" params:nil];
}

/**
 * [getUserReports description]
 */

- (void) getReports
{
    [self executeGetRequest:@"user/reports" params:nil];
}

- (void) getSettings
{
    [self executeGetRequest:@"user/settings" params:nil];
}

- (void) getHistory
{
    [self executeGetRequest:@"user/history" params:nil];
}

- (void) getForm : (long) formID
{
    [self executeGetRequest:[NSString stringWithFormat:@"form/%ld", formID] params:nil];
}

- (void) getFormQuestions : (long) formID
{
    [self executeGetRequest:[NSString stringWithFormat:@"form/%ld/questions", formID] params:nil];
}

- (void) getFormQuestions : (long) formID questionID : (long) qid
{
    [self executeGetRequest:[NSString stringWithFormat:@"form/%ld/questions/%ld", formID, qid] params:nil];
}

- (void) getFormSubmissions : (long) formID
{
    [self executeGetRequest:[NSString stringWithFormat:@"form/%ld/submissions", formID] params:nil];
}

- (void) createFormSubmissions : (long) formID submission : (NSMutableDictionary *) submission
{
    NSMutableDictionary *parameters = [[[NSMutableDictionary alloc] init] autorelease];
    
    NSArray *keys = [submission allKeys];
    
    NSString *subkey = @"";
    
    for ( NSString *key in keys ) {
        
        subkey = [NSString stringWithFormat:@"submission[%@][%@]", [key substringToIndex:[key rangeOfString:@"_"].location], [key substringToIndex:([key rangeOfString:@"_"].location + 1)]];
        
        [parameters setObject:[submission objectForKey:key] forKey:subkey];
        
    }
    
    [self executePostRequest:[NSString stringWithFormat:@"form/%ld/submissions", formID] params:parameters];
}

#pragma mark - ASIHttpRequest Delegate Method

- (void) requestFinished : (ASIHTTPRequest *) request
{
    [self debugLog:[request responseString]];
    
    NSInteger statuscode = [request responseStatusCode];
    
    if ( statuscode != 200 ) {
        [self debugLog:[request responseStatusMessage]];
    }
    
    SBJsonParser *jsonparser = [SBJsonParser new];
    
    id result = [jsonparser objectWithString:[request responseString]];
    
    self.didFinishBlock(result);
}

- (void) requestFailed : (ASIHTTPRequest *) request
{
    self.didFailBlock(nil);
}

- (void) dealloc
{
    [operationQueue release];
    
    [super dealloc];
}

@end
