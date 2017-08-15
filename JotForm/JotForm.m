//
//  JotForm.m
//  JotForm
//
//  Created by Wang YuPing on 7/9/13.
//  Copyright (c) 2013 Interlogy, LLC. All rights reserved.
//

#import "JotForm.h"
#import "AFHTTPSessionManager.h"


#define BASE_URL                     @"https://api.jotform.com"
#define BASE_URL_EU                  @"https://eu-api.jotform.com"
#define SUBMIT_REPORT_URL            @"https://submit.jotform.com"
#define SUBMIT_SUGGESTION_URL        @"https://submit.jotform.me"
#define HTTPREQUEST_METHOD_GET       @"GET"
#define HTTPREQUEST_METHOD_POST      @"POST"
#define HTTPREQUEST_METHOD_DELETE    @"DELETE"
#define HTTPREQUEST_METHOD_PUT       @"PUT"
#define API_VERSION                  @"v1"


@interface JotForm () {
    NSString *apiKey;
    NSString *baseUrl;
    NSString *submitReportUrl;
    NSString *submitSuggestionUrl;
    NSString *apiVersion;
    BOOL debugMode;
}


@end

@implementation JotForm

- (id)init {
    if (self = [super init]) {
        apiKey = @"";
        debugMode = NO;
        baseUrl = BASE_URL;
        submitReportUrl = SUBMIT_REPORT_URL;
        submitSuggestionUrl = SUBMIT_SUGGESTION_URL;
        apiVersion = API_VERSION;
    }
    return self;
}

- (id)initWithApiKey:(NSString *)apikey debugMode:(BOOL)debugmode euApi:(BOOL)euApi {
    if (self = [super init]) {
        apiKey = apikey;
        debugMode = debugmode;
        if (euApi) {
            baseUrl = BASE_URL_EU;
        } else {
            baseUrl = BASE_URL;
        }
        submitReportUrl = SUBMIT_REPORT_URL;
        submitSuggestionUrl = SUBMIT_SUGGESTION_URL;
        apiVersion = API_VERSION;
    }
    return self;
}

- (void)debugLog:(NSString *)str {
    if (debugMode == YES)
        NSLog(@"\n%@", str);
}

- (void)executeGetEUapi:(NSString *)path
              onSuccess:(void (^)(id))successBlock
              onFailure:(void (^)(NSError *))failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@", baseUrl, path];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    
    [manager GET:urlStr
      parameters:nil
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             successBlock(responseObject);
         }
         failure:^(NSURLSessionTask *operation, NSError *error) {
             failureBlock(error);
         }];
}

- (void)createReport:(long long)formID reportParams:(NSMutableDictionary *)reportParams
           onSuccess:(void (^)(id))successBlock
           onFailure:(void (^)(NSError *))failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/submit/%lld/", submitReportUrl,formID];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    [self debugLog:[NSString stringWithFormat:@"paramstr = %@", reportParams]];
    
    [manager POST:urlStr
       parameters:reportParams
         progress:nil
          success:^(NSURLSessionTask *task, id responseObject) {
              successBlock(responseObject);
          }
          failure:^(NSURLSessionTask *operation, NSError *error) {
              failureBlock(error);
          }];
}

- (void)createSuggestion:(long long)formID suggestionParams:(NSMutableDictionary *)suggestionParams
               onSuccess:(void (^)(id))successBlock
               onFailure:(void (^)(NSError *))failureBlock;
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/submit/%lld/", submitSuggestionUrl,formID];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    [self debugLog:[NSString stringWithFormat:@"paramstr = %@", suggestionParams]];
    
    [manager POST:urlStr
       parameters:suggestionParams
         progress:nil
          success:^(NSURLSessionTask *task, id responseObject) {
              successBlock(responseObject);
          }
          failure:^(NSURLSessionTask *operation, NSError *error) {
              failureBlock(error);
          }];
}

- (void)login:(NSMutableDictionary *)userinfo
    onSuccess:(void (^)(id))successBlock
    onFailure:(void (^)(NSError *))failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/user/login", baseUrl,apiVersion];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    [self debugLog:[NSString stringWithFormat:@"paramstr = %@", userinfo]];
    
    [manager POST:urlStr parameters:userinfo progress:nil
          success:^(NSURLSessionTask *task, id responseObject) {
              successBlock(responseObject);
          }
          failure:^(NSURLSessionTask *operation, NSError *error) {
              failureBlock(error);
          }];
}

- (void)logout:(NSMutableDictionary *)userinfo
     onSuccess:(void (^)(id))successBlock
     onFailure:(void (^)(NSError *))failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/user/logout?apiKey=%@", baseUrl,apiVersion,apiKey];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    [self debugLog:[NSString stringWithFormat:@"paramstr = %@", userinfo]];
    
    [manager POST:urlStr parameters:userinfo progress:nil
          success:^(NSURLSessionTask *task, id responseObject) {
              successBlock(responseObject);
          }
          failure:^(NSURLSessionTask *operation, NSError *error) {
              failureBlock(error);
          }];
}

- (void)registerUser:(NSMutableDictionary *)userinfo
           onSuccess:(void (^)(id))successBlock
           onFailure:(void (^)(NSError *))failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/user/register?apiKey=%@", baseUrl,apiVersion,apiKey];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    [self debugLog:[NSString stringWithFormat:@"paramstr = %@", userinfo]];
    
    [manager POST:urlStr parameters:userinfo progress:nil
          success:^(NSURLSessionTask *task, id responseObject) {
              successBlock(responseObject);
          }
          failure:^(NSURLSessionTask *operation, NSError *error) {
              failureBlock(error);
          }];
}

- (void)getUser:(void (^)(id))successBlock
      onFailure:(void (^)(NSError *))failureBlock  {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/user?apiKey=%@", baseUrl,apiVersion, apiKey];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    
    [manager GET:urlStr
      parameters:nil
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             successBlock(responseObject);
         }
         failure:^(NSURLSessionTask *operation, NSError *error) {
             failureBlock(error);
         }];
}

- (void)getUsage:(void (^)(id))successBlock
       onFailure:(void (^)(NSError *))failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/user/usage?apiKey=%@", baseUrl,apiVersion, apiKey];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    
    [manager GET:urlStr
      parameters:nil
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             successBlock(responseObject);
         }
         failure:^(NSURLSessionTask *operation, NSError *error) {
             failureBlock(error);
         }];
}

- (void)getForms:(void (^)(id))successBlock
       onFailure:(void (^)(NSError *))failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/user/forms?apiKey=%@", baseUrl, apiVersion, apiKey];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    
    [manager GET:urlStr
      parameters:nil
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             successBlock(responseObject);
         }
         failure:^(NSURLSessionTask *operation, NSError *error) {
             failureBlock(error);
         }];
}

- (void)getForms:(NSInteger)offset
           limit:(NSInteger)limit
         orderBy:(NSString *)orderBy
          filter:(NSMutableDictionary *)filter
       onSuccess:(void (^)(id))successBlock
       onFailure:(void (^)(NSError *))failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *params = [self createConditions:offset limit:limit filter:filter orderBy:orderBy];
    NSMutableArray *paramarray = [[NSMutableArray alloc] init];
    NSArray *keys = [params allKeys];
    
    for (NSString *key in keys)
        [paramarray
         addObject:[NSString stringWithFormat:@"%@=%@", key,
                    params[key]]];
    
    NSString *paramstr = [paramarray componentsJoinedByString:@"&"];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/user/forms?apiKey=%@&%@", baseUrl,apiVersion, apiKey,paramstr];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    
    [manager GET:urlStr
      parameters:nil
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             successBlock(responseObject);
         }
         failure:^(NSURLSessionTask *operation, NSError *error) {
             failureBlock(error);
         }];
}

- (void)getSubmissions:(void (^)(id))successBlock
             onFailure:(void (^)(NSError *))failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/user/submissions?apiKey=%@", baseUrl,apiVersion, apiKey];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    
    [manager GET:urlStr
      parameters:nil
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             successBlock(responseObject);
         }
         failure:^(NSURLSessionTask *operation, NSError *error) {
             failureBlock(error);
         }];
}

- (void)getSubmissions:(NSInteger)offset
                 limit:(NSInteger)limit
               orderBy:(NSString *)orderBy
                filter:(NSMutableDictionary *)filter
             onSuccess:(void (^)(id))successBlock
             onFailure:(void (^)(NSError *))failureBlock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *params =
    [self createConditions:offset limit:limit filter:filter orderBy:orderBy];
    
    NSMutableArray *paramarray = [[NSMutableArray alloc] init];
    NSArray *keys = [params allKeys];
    
    for (NSString *key in keys)
        [paramarray
         addObject:[NSString stringWithFormat:@"%@=%@", key,
                    params[key]]];
    
    NSString *paramstr = [paramarray componentsJoinedByString:@"&"];
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/user/submissions?apiKey=%@&%@",baseUrl, apiVersion, apiKey,paramstr];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    
    [manager GET:urlStr
      parameters:nil
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             successBlock(responseObject);
         }
         failure:^(NSURLSessionTask *operation, NSError *error) {
             failureBlock(error);
         }];
}

- (void)getSubusers:(void (^)(id))successBlock
          onFailure:(void (^)(NSError *))failureBlock  {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/user/subusers?apiKey=%@", baseUrl, apiVersion, apiKey];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    
    [manager GET:urlStr
      parameters:nil
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             successBlock(responseObject);
         }
         failure:^(NSURLSessionTask *operation, NSError *error) {
             failureBlock(error);
         }];
}

- (void)getFolders:(void (^)(id))successBlock
         onFailure:(void (^)(NSError *))failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/users/folders?apiKey=%@", baseUrl,apiVersion, apiKey];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    
    [manager GET:urlStr
      parameters:nil
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             successBlock(responseObject);
         }
         failure:^(NSURLSessionTask *operation, NSError *error) {
             failureBlock(error);
         }];
}

- (void)getFolder:(long long)folderID
        onSuccess:(void (^)(id))successBlock
        onFailure:(void (^)(NSError *))failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/folder/%lld?apiKey=%@", baseUrl, apiVersion,folderID, apiKey];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    
    [manager GET:urlStr
      parameters:nil
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             successBlock(responseObject);
         }
         failure:^(NSURLSessionTask *operation, NSError *error) {
             failureBlock(error);
         }];
}

- (void)getReports:(void (^)(id))successBlock
         onFailure:(void (^)(NSError *))failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/user/reports/apiKey=%@", baseUrl, apiVersion, apiKey];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    
    [manager GET:urlStr
      parameters:nil
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             successBlock(responseObject);
         }
         failure:^(NSURLSessionTask *operation, NSError *error) {
             failureBlock(error);
         }];
}

- (void)deleteReport:(long long)reportID
           onSuccess:(void (^)(id))successBlock
           onFailure:(void (^)(NSError *))failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/user/reports/%lld?apiKey=%@", baseUrl, apiVersion,reportID, apiKey];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    
    [manager DELETE:urlStr parameters:nil
            success:^(NSURLSessionTask *task, id responseObject) {
                successBlock(responseObject);
            }
            failure:^(NSURLSessionTask *operation, NSError *error) {
                failureBlock(error);
            }];
}

- (void)getSettings:(void (^)(id))successBlock
          onFailure:(void (^)(NSError *))failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/user/settings?apiKey=%@", baseUrl, apiVersion, apiKey];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    
    [manager GET:urlStr
      parameters:nil
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             successBlock(responseObject);
         }
         failure:^(NSURLSessionTask *operation, NSError *error) {
             failureBlock(error);
         }];
}

- (void)updateSettings:(NSMutableDictionary *)settings
             onSuccess:(void (^)(id))successBlock
             onFailure:(void (^)(NSError *))failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/user/settings?apiKey=%@", baseUrl,apiVersion,apiKey];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    [self debugLog:[NSString stringWithFormat:@"paramstr = %@", settings]];
    
    [manager POST:urlStr parameters:settings progress:nil
          success:^(NSURLSessionTask *task, id responseObject) {
              successBlock(responseObject);
          }
          failure:^(NSURLSessionTask *operation, NSError *error) {
              failureBlock(error);
          }];
}

- (void)getHistory:(void (^)(id))successBlock
         onFailure:(void (^)(NSError *))failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/user/history?apiKey=%@", baseUrl,apiVersion, apiKey];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    
    [manager GET:urlStr
      parameters:nil
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             successBlock(responseObject);
         }
         failure:^(NSURLSessionTask *operation, NSError *error) {
             failureBlock(error);
         }];
}

- (void)getHistory:(NSString *)action
              date:(NSString *)date
            sortBy:(NSString *)sortBy
         startDate:(NSString *)startDate
           endDate:(NSString *)endDate
         onSuccess:(void (^)(id))successBlock
         onFailure:(void (^)(NSError *))failureBlock {
    NSMutableDictionary *params = [self createHistoryQuery:action
                                                      date:date
                                                    sortBy:sortBy
                                                 startDate:startDate
                                                   endDate:endDate];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/user/history?apiKey=%@", baseUrl, apiVersion,apiKey];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    [self debugLog:[NSString stringWithFormat:@"paramstr = %@", params]];
    
    [manager GET:urlStr
      parameters:params
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             successBlock(responseObject);
         }
         failure:^(NSURLSessionTask *operation, NSError *error) {
             failureBlock(error);
         }];
    
}

- (void)getForm:(long long)formID
      onSuccess:(void (^)(id))successBlock
      onFailure:(void (^)(NSError *))failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/form/%lld?apiKey=%@", baseUrl, apiVersion,formID, apiKey];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    
    [manager GET:urlStr
      parameters:nil
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             successBlock(responseObject);
         }
         failure:^(NSURLSessionTask *operation, NSError *error) {
             failureBlock(error);
         }];
    
}

- (void)getFormQuestions:(long long)formID
               onSuccess:(void (^)(id))successBlock
               onFailure:(void (^)(NSError *))failureBlock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/form/%lld/questions?apiKey=%@", baseUrl,
                        apiVersion,formID, apiKey];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    
    [manager GET:urlStr
      parameters:nil
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             successBlock(responseObject);
         }
         failure:^(NSURLSessionTask *operation, NSError *error) {
             failureBlock(error);
         }];
}

- (void)getFormQuestion:(long long)formID questionID:(long long)qid
              onSuccess:(void (^)(id))successBlock
              onFailure:(void (^)(NSError *))failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/form/%lld/question/%lld?apiKey=%@", baseUrl,
                        apiVersion,formID,qid, apiKey];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    
    [manager GET:urlStr
      parameters:nil
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             successBlock(responseObject);
         }
         failure:^(NSURLSessionTask *operation, NSError *error) {
             failureBlock(error);
         }];
}

- (void)getFormSubmissions:(long long)formID
                 onSuccess:(void (^)(id))successBlock
                 onFailure:(void (^)(NSError *))failureBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"true" forKey:@"qid_enabled"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/form/%lld/submissions?apiKey=%@", baseUrl,apiVersion,formID, apiKey];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    [self debugLog:[NSString stringWithFormat:@"paramstr = %@", params]];
    
    [manager GET:urlStr parameters:params progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             successBlock(responseObject);
         }
         failure:^(NSURLSessionTask *operation, NSError *error) {
             failureBlock(error);
         }];
}

- (void)getFormSubmissions:(long long)formID
                    offset:(NSInteger)offset
                     limit:(NSInteger)limit
                   orderBy:(NSString *)orderBy
                    filter:(NSMutableDictionary *)filter
                 onSuccess:(void (^)(id))successBlock
                 onFailure:(void (^)(NSError *))failureBlock {
    NSMutableDictionary *params =
    [self createConditions:offset limit:limit filter:filter orderBy:orderBy];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/form/%lld/submissions?apiKey=%@", baseUrl,apiVersion,formID, apiKey];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    [self debugLog:[NSString stringWithFormat:@"paramstr = %@", params]];
    
    [manager GET:urlStr parameters:params progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             successBlock(responseObject);
         }
         failure:^(NSURLSessionTask *operation, NSError *error) {
             failureBlock(error);
         }];
}

- (void)getFormReports:(long long)formID
             onSuccess:(void (^)(id))successBlock
             onFailure:(void (^)(NSError *))failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/form/%lld/reports?apiKey=%@", baseUrl,apiVersion,formID, apiKey];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    
    [manager GET:urlStr parameters:nil progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             successBlock(responseObject);
         }
         failure:^(NSURLSessionTask *operation, NSError *error) {
             failureBlock(error);
         }];
}

- (void)createFormSubmissions:(long long)formID
                   submission:(NSMutableDictionary *)submission
                    onSuccess:(void (^)(id))successBlock
                    onFailure:(void (^)(NSError *))failureBlock {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    
    NSArray *keys = [submission allKeys];
    
    NSString *subkey = @"";
    
    for (NSString *key in keys) {
        
        if ([key rangeOfString:@"_"].location != NSNotFound)
            subkey = [NSString
                      stringWithFormat:
                      @"submission[%@][%@]",
                      [key substringToIndex:[key rangeOfString:@"_"].location],
                      [key substringToIndex:([key rangeOfString:@"_"].location + 1)]];
        else
            subkey = [NSString stringWithFormat:@"submission[%@]", key];
        
        if (submission[key]) {
            [parameters setObject:submission[key] forKey:subkey];
        }
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/form/%lld/submissions?apiKey=%@", baseUrl,apiVersion,formID,apiKey];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    [self debugLog:[NSString stringWithFormat:@"paramstr = %@", parameters]];
    
    [manager POST:urlStr parameters:parameters progress:nil
          success:^(NSURLSessionTask *task, id responseObject) {
              successBlock(responseObject);
          }
          failure:^(NSURLSessionTask *operation, NSError *error) {
              failureBlock(error);
          }];
    
}

- (void)getFormFiles:(long long)formID
           onSuccess:(void (^)(id))successBlock
           onFailure:(void (^)(NSError *))failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/form/%lld/files?apiKey=%@", baseUrl,apiVersion,formID, apiKey];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    
    [manager GET:urlStr parameters:nil progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             successBlock(responseObject);
         }
         failure:^(NSURLSessionTask *operation, NSError *error) {
             failureBlock(error);
         }];
}

- (void)getFormWebhooks:(long long)formID
              onSuccess:(void (^)(id))successBlock
              onFailure:(void (^)(NSError *))failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/form/%lld/webhooks?apiKey=%@", baseUrl,apiVersion,formID, apiKey];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    
    [manager GET:urlStr parameters:nil progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             successBlock(responseObject);
         }
         failure:^(NSURLSessionTask *operation, NSError *error) {
             failureBlock(error);
         }];
}

- (void)createFormWebhooks:(long long)formID hookUrl:(NSString *)webhookURL
                 onSuccess:(void (^)(id))successBlock
                 onFailure:(void (^)(NSError *))failureBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    if (webhookURL && webhookURL.length > 0)
        [params setObject:webhookURL forKey:@"webhookURL"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/form/%lld/webhooks?apiKey=%@", baseUrl,apiVersion,formID,apiKey];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    [self debugLog:[NSString stringWithFormat:@"paramstr = %@", params]];
    
    [manager POST:urlStr parameters:params progress:nil
          success:^(NSURLSessionTask *task, id responseObject) {
              successBlock(responseObject);
          }
          failure:^(NSURLSessionTask *operation, NSError *error) {
              failureBlock(error);
          }];
}

- (void)deleteWebhook:(long long)formID webhookId:(long long)webhookID
            onSuccess:(void (^)(id))successBlock
            onFailure:(void (^)(NSError *))failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/forms/%lld/webhooks/%lld?apiKey=%@", baseUrl,
                        apiVersion,formID,webhookID, apiKey];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    
    [manager DELETE:urlStr parameters:nil
            success:^(NSURLSessionTask *task, id responseObject) {
                successBlock(responseObject);
            }
            failure:^(NSURLSessionTask *operation, NSError *error) {
                failureBlock(error);
            }];
}

- (void)getSubmission:(long long)sid
            onSuccess:(void (^)(id))successBlock
            onFailure:(void (^)(NSError *))failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/submission/%lld?apiKey=%@", baseUrl,apiVersion,sid, apiKey];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    
    [manager GET:urlStr parameters:nil progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             successBlock(responseObject);
         }
         failure:^(NSURLSessionTask *operation, NSError *error) {
             failureBlock(error);
         }];
}

- (void)getReport:(long long)reportID onSuccess:(void (^)(id))successBlock
        onFailure:(void (^)(NSError *))failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/report/%lld?apiKey=%@", baseUrl,apiVersion,reportID, apiKey];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    
    [manager GET:urlStr parameters:nil progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             successBlock(responseObject);
         }
         failure:^(NSURLSessionTask *operation, NSError *error) {
             failureBlock(error);
         }];
}

- (void)createReport:(long long)formID
               title:(NSString *)title
           list_type:(NSString *)list_type
              fields:(NSString *)fields
           onSuccess:(void (^)(id))successBlock
           onFailure:(void (^)(NSError *))failureBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:[NSNumber numberWithLongLong:formID] forKey:@"id"];
    
    if (title)
        [params setObject:title forKey:@"title"];
    
    if (list_type)
        [params setObject:list_type forKey:@"list_type"];
    
    if (fields)
        [params setObject:fields forKey:@"fields"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/form/%lld/reports?apiKey=%@", baseUrl,apiVersion,formID,apiKey];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    [self debugLog:[NSString stringWithFormat:@"paramstr = %@", params]];
    
    [manager POST:urlStr parameters:params progress:nil
          success:^(NSURLSessionTask *task, id responseObject) {
              successBlock(responseObject);
          }
          failure:^(NSURLSessionTask *operation, NSError *error) {
              failureBlock(error);
          }];
}

- (void)getFormProperties:(long long)formID
                onSuccess:(void (^)(id))successBlock
                onFailure:(void (^)(NSError *))failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/form/%lld/properties",baseUrl,formID];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    
    [manager GET:urlStr
      parameters:nil
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             successBlock(responseObject);
         }
         failure:^(NSURLSessionTask *operation, NSError *error) {
             failureBlock(error);
         }];
    
}

- (void)getFormProperty:(long long)formID propertyKey:(NSString *)propertyKey
              onSuccess:(void (^)(id))successBlock
              onFailure:(void (^)(NSError *))failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/form/%lld/properties/%@?apiKey=%@",baseUrl,formID,propertyKey,apiKey];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    
    [manager GET:urlStr
      parameters:nil
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             successBlock(responseObject);
         }
         failure:^(NSURLSessionTask *operation, NSError *error) {
             failureBlock(error);
         }];
}

- (void)checkEUserver:(void (^)(id))successBlock
            onFailure:(void (^)(NSError *))failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/user/settings/euOnly", baseUrl,apiVersion];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    
    [manager GET:urlStr
      parameters:nil
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             successBlock(responseObject);
         }
         failure:^(NSURLSessionTask *operation, NSError *error) {
             failureBlock(error);
         }];
}

- (void)deleteSubmission:(long long)sid
               onSuccess:(void (^)(id))successBlock
               onFailure:(void (^)(NSError *))failureBlock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/submission/%lld?apiKey=%@", baseUrl, apiVersion,sid,apiKey];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    
    [manager DELETE:urlStr parameters:nil
            success:^(NSURLSessionTask *task, id responseObject) {
                successBlock(responseObject);
            }
            failure:^(NSURLSessionTask *operation, NSError *error) {
                failureBlock(error);
            }];
    
}

- (void)editSubmission:(long long)sid
                  name:(NSString *)submissionName
                   new:(NSInteger) new
                  flag:(NSInteger)flag
             onSuccess:(void (^)(id))successBlock
             onFailure:(void (^)(NSError *))failureBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    if (submissionName)
        [params setObject:submissionName forKey:@"submission[1][first]"];
    
    [params setObject:[NSString stringWithFormat:@"%zd", new]
               forKey:@"submission[new]"];
    [params setObject:[NSString stringWithFormat:@"%zd", flag]
               forKey:@"submission[flag]"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/submission/%lld?apiKey=%@", baseUrl,apiVersion,sid,apiKey];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    [self debugLog:[NSString stringWithFormat:@"paramstr = %@", params]];
    
    [manager POST:urlStr parameters:params progress:nil
          success:^(NSURLSessionTask *task, id responseObject) {
              successBlock(responseObject);
          }
          failure:^(NSURLSessionTask *operation, NSError *error) {
              failureBlock(error);
          }];
}

- (void)cloneForm:(long long)formID
        onSuccess:(void (^)(id))successBlock
        onFailure:(void (^)(NSError *))failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/form/%lld/clone?apiKey=%@", baseUrl,apiVersion,formID,apiKey];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    
    [manager POST:urlStr parameters:nil progress:nil
          success:^(NSURLSessionTask *task, id responseObject) {
              successBlock(responseObject);
          }
          failure:^(NSURLSessionTask *operation, NSError *error) {
              failureBlock(error);
          }];
}

- (void)deleteFormQuestion:(long long)formID questionID:(long long)qid
                 onSuccess:(void (^)(id))successBlock
                 onFailure:(void (^)(NSError *))failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/form/%lld/question/%lld?apiKey=%@", baseUrl,apiVersion,formID,qid,apiKey];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    
    [manager DELETE:urlStr parameters:nil
            success:^(NSURLSessionTask *task, id responseObject) {
                successBlock(responseObject);
            }
            failure:^(NSURLSessionTask *operation, NSError *error) {
                failureBlock(error);
            }];
}

- (void)createFormQuestion:(long long)formID
                  question:(NSMutableDictionary *)question
                 onSuccess:(void (^)(id))successBlock
                 onFailure:(void (^)(NSError *))failureBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    NSArray *keys = [question allKeys];
    
    for (NSString *key in keys)
        [params setObject:question[key]
                   forKey:[NSString stringWithFormat:@"question[%@]", key]];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/form/%lld/questions?apiKey=%@", baseUrl,apiVersion,formID,apiKey];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    [self debugLog:[NSString stringWithFormat:@"paramstr = %@", params]];
    
    [manager POST:urlStr parameters:params progress:nil
          success:^(NSURLSessionTask *task, id responseObject) {
              successBlock(responseObject);
          }
          failure:^(NSURLSessionTask *operation, NSError *error) {
              failureBlock(error);
          }];
}

- (void)createFormQuestions:(long long)formID questions:(NSString *)questions
                  onSuccess:(void (^)(id))successBlock
                  onFailure:(void (^)(NSError *))failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/form/%lld/questions?apiKey=%@", baseUrl,
                        apiVersion,formID, apiKey];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    [self debugLog:[NSString stringWithFormat:@"paramstr = %@", questions]];
    
    [manager PUT:urlStr parameters:questions
         success:^(NSURLSessionTask *task, id responseObject) {
             successBlock(responseObject);
         }
         failure:^(NSURLSessionTask *operation, NSError *error) {
             failureBlock(error);
         }];
    
}

- (void)editFormQuestion:(long long)formID
              questionID:(long long)qid
      questionProperties:(NSMutableDictionary *)properties
               onSuccess:(void (^)(id))successBlock
               onFailure:(void (^)(NSError *))failureBlock
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    NSArray *keys = [properties allKeys];
    
    for (NSString *key in keys)
        [params setObject:properties[key]
                   forKey:[NSString stringWithFormat:@"question[%@]", key]];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/form/%lld/question/%lld?apiKey=%@", baseUrl,apiVersion,formID,qid,apiKey];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    [self debugLog:[NSString stringWithFormat:@"paramstr = %@", params]];
    
    [manager POST:urlStr parameters:params progress:nil
          success:^(NSURLSessionTask *task, id responseObject) {
              successBlock(responseObject);
          }
          failure:^(NSURLSessionTask *operation, NSError *error) {
              failureBlock(error);
          }];
}

- (void)setFormProperties:(long long)formID
           formProperties:(NSMutableDictionary *)properties
                onSuccess:(void (^)(id))successBlock
                onFailure:(void (^)(NSError *))failureBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    NSArray *keys = [properties allKeys];
    
    for (NSString *key in keys) {
        [params setObject:properties[key] forKey:[NSString stringWithFormat:@"properties[%@]", key]];
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/form/%lld/properties?apiKey=%@", baseUrl,apiVersion,formID,apiKey];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    [self debugLog:[NSString stringWithFormat:@"paramstr = %@", params]];
    
    [manager POST:urlStr parameters:params progress:nil
          success:^(NSURLSessionTask *task, id responseObject) {
              successBlock(responseObject);
          }
          failure:^(NSURLSessionTask *operation, NSError *error) {
              failureBlock(error);
          }];
}

- (void)setMultipleFormProperties:(long long)formID
                   formProperties:(NSString *)properties
                        onSuccess:(void (^)(id))successBlock
                        onFailure:(void (^)(NSError *))failureBlock {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/form/%lld/properties?apiKey=%@", baseUrl, apiVersion,formID, apiKey];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    [self debugLog:[NSString stringWithFormat:@"paramstr = %@", properties]];
    
    [manager PUT:urlStr parameters:properties
         success:^(NSURLSessionTask *task, id responseObject) {
             successBlock(responseObject);
         }
         failure:^(NSURLSessionTask *operation, NSError *error) {
             failureBlock(error);
         }];
}

- (void)createForm:(NSMutableDictionary *)form
         onSuccess:(void (^)(id))successBlock
         onFailure:(void (^)(NSError *))failureBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    NSArray *formKeys = [form allKeys];
    
    for (NSString *formKey in formKeys) {
        
        if ([formKey isEqualToString:@"properties"]) {
            NSMutableDictionary *properties = form[formKey];
            
            NSArray *propertyKeys = [properties allKeys];
            
            for (NSString *propertyKey in propertyKeys) {
                [params setObject:properties[propertyKey]
                           forKey:[NSString stringWithFormat:@"%@[%@]", formKey,
                                   propertyKey]];
            }
        } else {
            NSMutableDictionary *formItem = form[formKey];
            
            NSArray *formItemKeys = [formItem allKeys];
            
            for (NSString *formItemKey in formItemKeys) {
                NSMutableDictionary *fi = formItem[formItemKey];
                NSArray *fiKeys = [fi allKeys];
                
                for (NSString *fiKey in fiKeys)
                    [params setObject:fi[fiKey]
                               forKey:[NSString stringWithFormat:@"%@[%@][%@]", formKey,
                                       formItemKey, fiKey]];
            }
        }
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/user/forms?apiKey=%@", baseUrl,apiVersion,apiKey];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    [self debugLog:[NSString stringWithFormat:@"paramstr = %@", params]];
    
    [manager POST:urlStr parameters:params progress:nil
          success:^(NSURLSessionTask *task, id responseObject) {
              successBlock(responseObject);
          }
          failure:^(NSURLSessionTask *operation, NSError *error) {
              failureBlock(error);
          }];
}

- (void)createForms:(NSString *)form
          onSuccess:(void (^)(id))successBlock
          onFailure:(void (^)(NSError *))failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/user/forms?apiKey=%@", baseUrl, apiVersion, apiKey];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    [self debugLog:[NSString stringWithFormat:@"paramstr = %@", form]];
    
    [manager PUT:urlStr parameters:form
         success:^(NSURLSessionTask *task, id responseObject) {
             successBlock(responseObject);
         }
         failure:^(NSURLSessionTask *operation, NSError *error) {
             failureBlock(error);
         }];
}

- (void)deleteForm:(long long)formID
         onSuccess:(void (^)(id))successBlock
         onFailure:(void (^)(NSError *))failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/forms/%lld?apiKey=%@", baseUrl, apiVersion,formID, apiKey];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    
    [manager DELETE:urlStr parameters:nil
            success:^(NSURLSessionTask *task, id responseObject) {
                successBlock(responseObject);
            }
            failure:^(NSURLSessionTask *operation, NSError *error) {
                failureBlock(error);
            }];
}

- (void)getSystemPlan:(NSString *)planType
            onSuccess:(void (^)(id))successBlock
            onFailure:(void (^)(NSError *))failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/system/plan/%@", baseUrl,planType];
    
    [self debugLog:[NSString stringWithFormat:@"urlstr = %@", urlStr]];
    
    [manager GET:urlStr
      parameters:nil
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             successBlock(responseObject);
         }
         failure:^(NSURLSessionTask *operation, NSError *error) {
             failureBlock(error);
         }];
}

- (NSMutableDictionary *)createHistoryQuery:(NSString *)action
                                       date:(NSString *)date
                                     sortBy:(NSString *)sortBy
                                  startDate:(NSString *)startDate
                                    endDate:(NSString *)endDate {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    if (action && action.length > 0)
        [params setObject:action forKey:@"action"];
    
    if (date && date.length > 0)
        [params setObject:date forKey:@"date"];
    
    if (sortBy && sortBy.length > 0)
        [params setObject:sortBy forKey:@"sortBy"];
    
    if (startDate && sortBy.length > 0)
        [params setObject:startDate forKey:@"startDate"];
    
    if (endDate && endDate.length > 0)
        [params setObject:endDate forKey:@"endDate"];
    
    return params;
}

- (NSMutableDictionary *)createConditions:(NSInteger)offset
                                    limit:(NSInteger)limit
                                   filter:(NSMutableDictionary *)filter
                                  orderBy:(NSString *)orderBy {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    if (offset != 0)
        [params setObject:[NSNumber numberWithInteger:offset] forKey:@"offset"];
    
    if (limit != 0)
        [params setObject:[NSNumber numberWithInteger:limit] forKey:@"limit"];
    
    if (filter) {
        NSString *filterStr = @"%7B";
        NSInteger count = 0;
        NSArray *keys = [filter allKeys];
        NSCharacterSet *set = [NSCharacterSet URLHostAllowedCharacterSet];
        
        for (NSString *key in keys) {
            if ([filter[key] isKindOfClass:[NSArray class]]) {
                filterStr = [filterStr stringByAppendingString:[NSString stringWithFormat: @"%%22%@%%22%%3A%%5B", key]];
                for (NSString *value in filter[key]) {
                    filterStr = [filterStr stringByAppendingString:[NSString stringWithFormat:@"%%22%@%%22", [value stringByAddingPercentEncodingWithAllowedCharacters:set]]];
                    
                    if ([filter[key] lastObject] != value) {
                         filterStr = [filterStr stringByAppendingString:@"%2C"];
                    }
                }
                 filterStr = [filterStr stringByAppendingString:@"%5D"];
            } else {
                filterStr = [filterStr stringByAppendingString:[NSString stringWithFormat:@"%%22%@%%22%%3A%%22%@%%22",key,[filter[key]stringByAddingPercentEncodingWithAllowedCharacters:set]]];
                
                count++;
                
                if (count < [filter count]) {
                    filterStr = [filterStr stringByAppendingString:@"%2C"];
                }
            }
        }
        
        filterStr = [filterStr stringByAppendingString:@"%7D"];
        [params setObject:filterStr forKey:@"filter"];
    }
    
    if (orderBy)
        [params setObject:orderBy forKey:@"orderby"];
    
    return params;
}

@end
