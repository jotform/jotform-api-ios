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
        [operationQueue setMaxConcurrentOperationCount:1];
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
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    
    if ( [method isEqualToString:HTTPREQUEST_METHOD_GET] == YES ) {
        
        NSMutableArray *paramarray = [[NSMutableArray alloc] init];
        
        NSArray *keys = [params allKeys];
        
        for ( NSString *key in keys )
            [paramarray addObject:[NSString stringWithFormat:@"%@=%@", key, [params objectForKey:key]]];
        
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

- (void) getUser
{
    [self executeGetRequest:@"user" params:nil];
}

- (void) getUsage
{
    [self executeGetRequest:@"user/usage" params:nil];
}

- (void) getForms
{
    [self executeGetRequest:@"user/forms" params:nil];
}

- (void) getSubmissions
{
    [self executeGetRequest:@"user/submissions" params:nil];
}

- (void) getSubmissions : (NSInteger) limit orderBy : (NSString *) orderBy filter : (NSMutableDictionary *) filter
{
    NSMutableDictionary *params = [[[NSMutableDictionary alloc] init] autorelease];
    
    [params setObject:[NSNumber numberWithInt:limit] forKey:@"limit"];

    if ( orderBy != nil ) {
        [params setObject:orderBy forKey:@"order_by"];
    }
    
    if ( filter != nil ) {
        SBJsonWriter *jsonWriter = [[[SBJsonWriter alloc] init] autorelease];
        NSString *filterStr = [jsonWriter stringWithObject:filter];
        
        [params setObject:filterStr forKey:@"filter"];
    }
    
    [self executeGetRequest:@"user/submissions" params:params];
}

- (void) getSubusers
{
    [self executeGetRequest:@"user/subusers" params:nil];
}

- (void) getFolders
{
    [self executeGetRequest:@"user/folders" params:nil];
}

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

- (void) getForm : (long long) formID
{
    [self executeGetRequest:[NSString stringWithFormat:@"form/%lld", formID] params:nil];
}

- (void) getFormQuestions : (long long) formID
{
    [self executeGetRequest:[NSString stringWithFormat:@"form/%lld/questions", formID] params:nil];
}

- (void) getFormQuestions : (long long) formID questionID : (long long) qid
{
    [self executeGetRequest:[NSString stringWithFormat:@"form/%lld/question/%lld", formID, qid] params:nil];
}

- (void) getFormSubmissions : (long long) formID
{
    NSMutableDictionary *params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:@"true" forKey:@"qid_enabled"];
    
    [self executeGetRequest:[NSString stringWithFormat:@"form/%lld/submissions", formID] params:params];
}

- (void) getFormSubmissions : (long long) formID limit : (NSInteger) limit orderBy : (NSString *) orderBy filter : (NSMutableDictionary *) filter
{
    [filter setObject:[NSNumber numberWithLongLong:formID] forKey:@"form_id"];
    
    [self getSubmissions:limit orderBy:orderBy filter:filter];
}

- (void) createFormSubmissions : (long long) formID submission : (NSMutableDictionary *) submission
{
    NSMutableDictionary *parameters = [[[NSMutableDictionary alloc] init] autorelease];
    
    NSArray *keys = [submission allKeys];
    
    NSString *subkey = @"";
    
    for ( NSString *key in keys ) {
        
        subkey = [NSString stringWithFormat:@"submission[%@][%@]", [key substringToIndex:[key rangeOfString:@"_"].location], [key substringToIndex:([key rangeOfString:@"_"].location + 1)]];
        
        [parameters setObject:[submission objectForKey:key] forKey:subkey];
        
    }
    
    [self executePostRequest:[NSString stringWithFormat:@"form/%lld/submissions", formID] params:parameters];
}

- (void) getFormFiles : (long long) formID
{
    [self executeGetRequest:[NSString stringWithFormat:@"form/%lld/files", formID] params:nil];
}

- (void) getFormWebhooks : (long long) formID
{
    [self executeGetRequest:[NSString stringWithFormat:@"form/%lld/webhooks", formID] params:nil];
}

- (void) createFormWebhooks : (long long) formID hookUrl : (NSString *) webhookURL
{
    NSMutableDictionary *params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:webhookURL forKey:@"webhookURL"];
    
    [self executePostRequest:[NSString stringWithFormat:@"form/%lld/webhooks", formID] params:params];
}

- (void) getSubmission : (long long) sid
{
    [self executeGetRequest:[NSString stringWithFormat:@"submission/%lld", sid] params:nil];
}

- (void) getReport : (long long) reportID
{
    [self executeGetRequest:[NSString stringWithFormat:@"report/%lld", reportID] params:nil];
}

- (void) getFolder : (long long) folderID
{
    [self executeGetRequest:[NSString stringWithFormat:@"folder/%lld", folderID] params:nil];
}

- (void) getFormProperties : (long long) formID
{
    [self executeGetRequest:[NSString stringWithFormat:@"form/%lld/properties", formID] params:nil];
}

- (void) getFormProperty : (long long) formID propertyKey : (NSString *) propertyKey
{
    [self executeGetRequest:[NSString stringWithFormat:@"form/%lld/properties/%@", formID, propertyKey] params:nil];
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
    self.didFailBlock([request error]);
}

- (void) dealloc
{
    [operationQueue release];
    
    [super dealloc];
}

@end
