//
//  JotForm.m
//  JotForm
//
//  Created by Wang YuPing on 7/9/13.
//  Copyright (c) 2013 Interlogy, LLC. All rights reserved.
//

#import "JotForm.h"

@implementation JotForm

- (id) initWithApiKey : (NSString *) apikey debugMode : (BOOL) debugmode
{
    if ( self = [super init] ) {
        
        apiKey = apikey;
        debugMode = debugmode;
        baseUrl = BASE_URL;
        apiVersion = API_VERSION;
        
    }
    
    return self;
}

- (void) debugLog : (NSString *) str
{
    if ( debugMode == YES )
        NSLog(@"\n%@", str);
}

- (id) executeHttpRequest : (NSString *) path params : (NSMutableDictionary *) params method : (NSString *) method
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
    }
    
    [self debugLog:urlStr];
    
    ASIFormDataRequest *request;

    request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [request setRequestMethod:method];
    [request setUserAgentString:USER_AGENT];
    [request addRequestHeader:@"apiKey" value:apiKey];

    if ( [method isEqualToString:HTTPREQUEST_METHOD_POST] ) {
        
        [self debugLog:@"posting"];
     
        NSArray *keys = [params allKeys];
        
        for ( NSString *key in keys )
            [request addPostValue:[params objectForKey:key] forKey:key];
    }
    
    [request startSynchronous];

    NSError *error = [request error];
    
    if ( !error ) {
        
        NSInteger statuscode = [request responseStatusCode];
        
        if ( statuscode != 200 ) {
            [self debugLog:[request responseStatusMessage]];
        }

        SBJsonParser *jsonparser = [SBJsonParser new];
        
        id result = [jsonparser objectWithString:[request responseString]];
        
        return result;
    }
    
    return nil;
}

- (id) executeGetRequest : (NSString *) url params : (NSMutableDictionary *) params
{
    return [self executeHttpRequest:url params:params method:HTTPREQUEST_METHOD_GET];
}

- (id) executePostRequest : (NSString *) url params : (NSMutableDictionary *) params
{
    return [self executeHttpRequest:url params:params method:HTTPREQUEST_METHOD_POST];
}

/**
 * Returns User object
 * @return [type] [description]
 */

- (id) getUser
{
    id res = [self executeGetRequest:@"user" params:nil];
    return res;
}

/**
 * [getUserUsage description]
 * @return [type] [description]
 */

- (id) getUsage
{
    id res = [self executeGetRequest:@"user/usage" params:nil];
    return res;
}

/**
 * [getForms description]
 * @return [type] [description]
 */

- (id) getForms
{
    id res = [self executeGetRequest:@"user/forms" params:nil];
    return res;
}

/**
 * [getSubmissions description]
 * @return [type] [description]
 */

- (id) getSubmissions
{
    id res = [self executeGetRequest:@"user/submissions" params:nil];
    return res;
}

/**
 * [getUserSubusers description]
 * @return [type] [description]
 */

- (id) getSubusers
{
    id res = [self executeGetRequest:@"user/subusers" params:nil];
    return res;
}

/**
 * [getUserFolders description]
 * @return [type] [description]
 */

- (id) getFolders
{
    id res = [self executeGetRequest:@"user/folders" params:nil];
    return res;
}

@end
