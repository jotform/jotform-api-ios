//
//  JotForm.m
//  JotForm
//
//  Created by Wang YuPing on 7/9/13.
//  Copyright (c) 2013 Interlogy, LLC. All rights reserved.
//

#import "JotForm.h"
#import "AFHTTPSessionManager.h"

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
    
    [manager GET:[NSString stringWithFormat:@"%@/%@", baseUrl, path]
      parameters:nil
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             successBlock(responseObject);
         }
         failure:^(NSURLSessionTask *operation, NSError *error) {
             failureBlock(error);
         }];
}
- (void)executeReportHttpRequest:(NSString *)path method:(NSString *)method params:(NSMutableDictionary *)params onSuccess:(void (^)(id))successBlock onFailure:(void (^)(NSError *))failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:[NSString
                   stringWithFormat:@"%@/%@", submitSuggestionUrl, [self urlEncode:path]]
       parameters:params
         progress:nil
          success:^(NSURLSessionTask *task, id responseObject) {
              successBlock(responseObject);
          }
          failure:^(NSURLSessionTask *operation, NSError *error) {
              failureBlock(error);
          }];
}

- (void)executeSuggestionHttpRequest:(NSString *)path
                              method:(NSString *)method
                              params:(NSMutableDictionary *)params
                           onSuccess:(void (^)(id))successBlock
                           onFailure:(void (^)(NSError *))failureBlock

{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:[NSString
                   stringWithFormat:@"%@/%@", submitSuggestionUrl, [self urlEncode:path]]
       parameters:params
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
    
    [manager POST:[NSString stringWithFormat:@"%@/%@/submit/%lld/", submitReportUrl, [self urlEncode:@""],formID]
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
    
    [manager POST:[NSString stringWithFormat:@"%@/%@/submit/%lld/", submitSuggestionUrl, [self urlEncode:@""],formID]
       parameters:suggestionParams
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
                                    endDate:(NSString *)endDate
                                    sortWay:(NSString *)sortWay {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    if (action != nil && action.length > 0)
        [params setObject:action forKey:@"action"];
    
    if (date != nil && date.length > 0)
        [params setObject:date forKey:@"date"];
    
    if (sortBy != nil && sortBy.length > 0)
        [params setObject:sortBy forKey:@"sortBy"];
    
    if (startDate != nil && sortBy.length > 0)
        [params setObject:startDate forKey:@"startDate"];
    
    if (endDate != nil && endDate.length > 0)
        [params setObject:endDate forKey:@"endDate"];
    
    if (sortWay != nil && sortWay.length > 0)
        [params setObject:sortWay forKey:@"sortWay"];
    
    return params;
}

- (void)login:(NSMutableDictionary *)userinfo
    onSuccess:(void (^)(id))successBlock
    onFailure:(void (^)(NSError *))failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:[NSString stringWithFormat:@"%@/%@/user/login?apiKey=%@", baseUrl,apiVersion,apiKey] parameters:userinfo progress:nil
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
    
    [manager POST:[NSString stringWithFormat:@"%@/%@/user/logout?apiKey=%@", baseUrl,apiVersion,apiKey] parameters:userinfo progress:nil
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
    
    [manager POST:[NSString stringWithFormat:@"%@/%@/user/register?apiKey=%@", baseUrl,apiVersion,apiKey] parameters:userinfo progress:nil
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
    
    [manager GET:[NSString stringWithFormat:@"%@/%@/user?apiKey=%@", baseUrl,
                  apiVersion, apiKey]
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
    
    [manager GET:[NSString stringWithFormat:@"%@/%@/user/usage?apiKey=%@", baseUrl,
                  apiVersion, apiKey]
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
    
    [manager GET:[NSString stringWithFormat:@"%@/%@/user/forms?apiKey=%@", baseUrl,
                  apiVersion, apiKey]
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
    
    NSMutableDictionary *params =
    [self createConditions:offset limit:limit filter:filter orderBy:orderBy];
    
    NSMutableArray *paramarray = [[NSMutableArray alloc] init];
    NSArray *keys = [params allKeys];
    
    for (NSString *key in keys)
        [paramarray
         addObject:[NSString stringWithFormat:@"%@=%@", key,
                    [params objectForKey:key]]];
    
    NSString *paramstr = [paramarray componentsJoinedByString:@"&"];
    
    [manager GET:[NSString stringWithFormat:@"%@/%@/user/forms?apiKey=%@&%@", baseUrl,
                  apiVersion, apiKey,paramstr]
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
    
    [manager GET:[NSString stringWithFormat:@"%@/%@/user/submissions?apiKey=%@", baseUrl,
                  apiVersion, apiKey]
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
                    [params objectForKey:key]]];
    
    NSString *paramstr = [paramarray componentsJoinedByString:@"&"];
    
    [manager GET:[NSString stringWithFormat:@"%@/%@/user/submissions?apiKey=%@&%@",baseUrl, apiVersion, apiKey,paramstr]
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
    
    [manager GET:[NSString stringWithFormat:@"%@/%@/user/subusers?apiKey=%@", baseUrl,
                  apiVersion, apiKey]
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
    
    [manager GET:[NSString stringWithFormat:@"%@/%@/users/folders?apiKey=%@", baseUrl,
                  apiVersion, apiKey]
      parameters:nil
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             successBlock(responseObject);
         }
         failure:^(NSURLSessionTask *operation, NSError *error) {
             failureBlock(error);
         }];
}

- (void)getFolder:(long long)folderId
        onSuccess:(void (^)(id))successBlock
        onFailure:(void (^)(NSError *))failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:[NSString stringWithFormat:@"%@/%@/folder/%lld?apiKey=%@", baseUrl,
                  apiVersion,folderId, apiKey]
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
    
    [manager GET:[NSString stringWithFormat:@"%@/%@/user/reports/apiKey=%@", baseUrl, apiVersion, apiKey]
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
    
    [manager DELETE:[NSString stringWithFormat:@"%@/%@/user/reports/%lld?apiKey=%@", baseUrl,
                     apiVersion,reportID, apiKey] parameters:nil
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
    
    [manager GET:[NSString stringWithFormat:@"%@/%@/user/settings?apiKey=%@", baseUrl,
                  apiVersion, apiKey]
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
    
    [manager POST:[NSString stringWithFormat:@"%@/%@/user/settings?apiKey=%@", baseUrl,apiVersion,apiKey] parameters:settings progress:nil
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
    
    [manager GET:[NSString stringWithFormat:@"%@/%@/user/history?apiKey=%@", baseUrl,
                  apiVersion, apiKey]
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
           sortWay:(NSString *)sortWay
         onSuccess:(void (^)(id))successBlock
         onFailure:(void (^)(NSError *))failureBlock {
    NSMutableDictionary *params = [self createHistoryQuery:action
                                                      date:date
                                                    sortBy:sortBy
                                                 startDate:startDate
                                                   endDate:endDate
                                                   sortWay:sortWay];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:[NSString stringWithFormat:@"%@/%@/user/history?apiKey=%@", baseUrl, apiVersion,apiKey]
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
    
    [manager GET:[NSString stringWithFormat:@"%@/%@/form/%lld?apiKey=%@", baseUrl, apiVersion,formID, apiKey]
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
    
    [manager GET:[NSString stringWithFormat:@"%@/%@/form/%lld/questions?apiKey=%@", baseUrl,
                  apiVersion,formID, apiKey]
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
    
    [manager GET:[NSString stringWithFormat:@"%@/%@/form/%lld/question/%lld?apiKey=%@", baseUrl,
                  apiVersion,formID,qid, apiKey]
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
    
    [manager GET:[NSString stringWithFormat:@"%@/%@/form/%lld/submissions?apiKey=%@", baseUrl,apiVersion,formID, apiKey] parameters:params progress:nil
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
    
    [manager GET:[NSString stringWithFormat:@"%@/%@/form/%lld/submissions?apiKey=%@", baseUrl,apiVersion,formID, apiKey] parameters:params progress:nil
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
    
    [manager GET:[NSString stringWithFormat:@"%@/%@/form/%lld/reports?apiKey=%@", baseUrl,apiVersion,formID, apiKey] parameters:nil progress:nil
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
        
        if ([submission objectForKey:key] != nil)
            [parameters setObject:[submission objectForKey:key] forKey:subkey];
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:[NSString stringWithFormat:@"%@/%@/form/%lld/logout?apiKey=%@", baseUrl,apiVersion,formID,apiKey] parameters:parameters progress:nil
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
    
    [manager GET:[NSString stringWithFormat:@"%@/%@/form/%lld/files?apiKey=%@", baseUrl,apiVersion,formID, apiKey] parameters:nil progress:nil
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
    
    [manager GET:[NSString stringWithFormat:@"%@/%@/form/%lld/webhooks?apiKey=%@", baseUrl,apiVersion,formID, apiKey] parameters:nil progress:nil
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
    
    if (webhookURL != nil && webhookURL.length > 0)
        [params setObject:webhookURL forKey:@"webhookURL"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:[NSString stringWithFormat:@"%@/%@/form/%lld/webhooks?apiKey=%@", baseUrl,apiVersion,formID,apiKey] parameters:params progress:nil
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
    
    [manager DELETE:[NSString stringWithFormat:@"%@/%@/forms/%lld/webhooks/%lld?apiKey=%@", baseUrl,
                     apiVersion,formID,webhookID, apiKey] parameters:nil
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
    
    [manager GET:[NSString stringWithFormat:@"%@/%@/submissions/%lld/webhooks?apiKey=%@", baseUrl,apiVersion,sid, apiKey] parameters:nil progress:nil
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
    
    [manager GET:[NSString stringWithFormat:@"%@/%@/report/%lld?apiKey=%@", baseUrl,apiVersion,reportID, apiKey] parameters:nil progress:nil
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
    
    if (title != nil)
        [params setObject:title forKey:@"title"];
    
    if (list_type != nil)
        [params setObject:list_type forKey:@"list_type"];
    
    if (fields != nil)
        [params setObject:fields forKey:@"fields"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:[NSString stringWithFormat:@"%@/%@/form/%lld/reports?apiKey=%@", baseUrl,apiVersion,formID,apiKey] parameters:params progress:nil
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
    
    [manager GET:[NSString stringWithFormat:@"%@/form/%lld/properties",baseUrl,formID]
      parameters:nil
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             successBlock(responseObject);
         }
         failure:^(NSURLSessionTask *operation, NSError *error) {
             failureBlock(error);
         }];
    
}

- (void)getFormEncrypted:(long long)formID
               onSuccess:(void (^)(id))successBlock
               onFailure:(void (^)(NSError *))failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:[NSString stringWithFormat:@"%@/form/%lld/properties/isEncrypted",baseUrl,formID]
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
    
    [manager GET:[NSString stringWithFormat:@"%@/form/%lld/properties/%@",baseUrl,formID,propertyKey]
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
    
    [manager GET:[NSString stringWithFormat:@"%@/%@/user/settings/euOnly", baseUrl,apiVersion]
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
    
    [manager DELETE:[NSString stringWithFormat:@"%@/%@/submission/%lld?apiKey=%@", baseUrl,
                     apiVersion,sid, apiKey] parameters:nil
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
    
    if (submissionName != nil)
        [params setObject:submissionName forKey:@"submission[1][first]"];
    
    [params setObject:[NSString stringWithFormat:@"%zd", new]
               forKey:@"submission[new]"];
    [params setObject:[NSString stringWithFormat:@"%zd", flag]
               forKey:@"submission[flag]"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:[NSString stringWithFormat:@"%@/%@/submission/%lld?apiKey=%@", baseUrl,apiVersion,sid,apiKey] parameters:params progress:nil
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
    
    [manager POST:[NSString stringWithFormat:@"%@/%@/form/%lld/clone?apiKey=%@", baseUrl,apiVersion,formID,apiKey] parameters:nil progress:nil
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
    
    [manager DELETE:[NSString stringWithFormat:@"%@/%@/form/%lld/question/%lld?apiKey=%@", baseUrl,
                     apiVersion,formID,qid,apiKey] parameters:nil
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
        [params setObject:[question objectForKey:key]
                   forKey:[NSString stringWithFormat:@"question[%@]", key]];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:[NSString stringWithFormat:@"%@/%@/form/%lld/questions?apiKey=%@", baseUrl,apiVersion,formID,apiKey] parameters:params progress:nil
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
    
    [manager PUT:[NSString stringWithFormat:@"%@/%@/form/%lld/questions?apiKey=%@", baseUrl,
                  apiVersion,formID, apiKey] parameters:questions
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
        [params setObject:[properties objectForKey:key]
                   forKey:[NSString stringWithFormat:@"question[%@]", key]];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:[NSString stringWithFormat:@"%@/%@/form/%lld/question/%lld?apiKey=%@", baseUrl,apiVersion,formID,qid,apiKey] parameters:params progress:nil
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
    
    for (NSString *key in keys)
        [params setObject:[properties objectForKey:key] forKey:[NSString stringWithFormat:@"properties[%@]", key]];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:[NSString stringWithFormat:@"%@/%@/form/%lld/properties?apiKey=%@", baseUrl,apiVersion,formID,apiKey] parameters:params progress:nil
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
    
    [manager PUT:[NSString stringWithFormat:@"%@/%@/form/%lld/properties?apiKey=%@", baseUrl,
                  apiVersion,formID, apiKey] parameters:properties
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
            
            NSMutableDictionary *properties = [form objectForKey:formKey];
            
            NSArray *propertyKeys = [properties allKeys];
            
            for (NSString *propertyKey in propertyKeys)
                [params setObject:[properties objectForKey:propertyKey]
                           forKey:[NSString stringWithFormat:@"%@[%@]", formKey,
                                   propertyKey]];
            
        } else {
            NSMutableDictionary *formItem = [form objectForKey:formKey];
            
            NSArray *formItemKeys = [formItem allKeys];
            
            for (NSString *formItemKey in formItemKeys) {
                NSMutableDictionary *fi = [formItem objectForKey:formItemKey];
                NSArray *fiKeys = [fi allKeys];
                
                for (NSString *fiKey in fiKeys)
                    [params setObject:[fi objectForKey:fiKey]
                               forKey:[NSString stringWithFormat:@"%@[%@][%@]", formKey,
                                       formItemKey, fiKey]];
            }
        }
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:[NSString stringWithFormat:@"%@/%@/user/forms?apiKey=%@", baseUrl,apiVersion,apiKey] parameters:params progress:nil
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
    
    [manager PUT:[NSString stringWithFormat:@"%@/%@/user/forms?apiKey=%@", baseUrl,
                  apiVersion, apiKey] parameters:form
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
    
    [manager DELETE:[NSString stringWithFormat:@"%@/%@/forms/%lld?apiKey=%@", baseUrl, apiVersion,formID, apiKey] parameters:nil
            success:^(NSURLSessionTask *task, id responseObject) {
                successBlock(responseObject);
            }
            failure:^(NSURLSessionTask *operation, NSError *error) {
                failureBlock(error);
            }];
}

- (void)deleteSubmissionSynchronous:(long long)formID
                          onSuccess:(void (^)(id))successBlock
                          onFailure:(void (^)(NSError *))failureBlock{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager DELETE:[NSString stringWithFormat:@"%@/%@/submission/%lld?apiKey=%@", baseUrl,
                     apiVersion,formID, apiKey] parameters:nil
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
    
    [manager GET:[NSString stringWithFormat:@"%@/system/plan/%@", baseUrl,planType]
      parameters:nil
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             successBlock(responseObject);
         }
         failure:^(NSURLSessionTask *operation, NSError *error) {
             failureBlock(error);
         }];
}

- (NSString *)urlEncode:(NSString *)str {
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)str, NULL, CFSTR("[]"), kCFStringEncodingUTF8));
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
    
    if (filter != nil) {
        NSString *filterStr = @"";
        NSInteger count = 0;
        NSArray *keys = [filter allKeys];
        
        filterStr = @"%7b";
        
        for (NSString *key in keys) {
            
            filterStr = [filterStr
                         stringByAppendingString:
                         [NSString stringWithFormat:
                          @"%%22%@%%22:%%22%@%%22", key,
                          [[filter objectForKey:key]
                           stringByAddingPercentEscapesUsingEncoding:
                           NSUTF8StringEncoding]]];
            
            count++;
            
            if (count < [filter count]) {
                filterStr = [filterStr stringByAppendingString:@"%2c"];
            }
        }
        
        filterStr = [filterStr stringByAppendingString:@"%7d"];
        
        [params setObject:filterStr forKey:@"filter"];
    }
    
    if (orderBy != nil)
        [params setObject:orderBy forKey:@"orderby"];
    
    return params;
}

- (void)dealloc {
}

@end
