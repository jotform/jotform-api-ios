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

@interface JotForm () {
    AFHTTPSessionManager *manager;
    NSString *apiKey;
    NSString *baseUrl;
    BOOL debugMode;
}

@end

@implementation JotForm

- (id)initWithApiKey:(NSString *)apikey debugMode:(BOOL)debugmode euApi:(BOOL)euApi {
    if (self = [super init]) {
        apiKey = apikey;
        baseUrl = (euApi) ? BASE_URL_EU : BASE_URL;
        debugMode = debugmode;
        manager = [AFHTTPSessionManager manager];
    }
    return self;
}

- (void)debugLog:(NSString *)urlStr params:(id)params {
    if (debugMode) {
        NSString *paramsStr = @"";
        
        if ([params isKindOfClass:[NSString class]]) {
            paramsStr = params;
        } else if ([params isKindOfClass:[NSDictionary class]]) {
           paramsStr = [params description];
        }
        
        NSLog(@"urlstr = %@ \n paramstr = %@", urlStr,paramsStr);
    }
}

- (void)executeGetEUapi:(NSString *)path
              onSuccess:(void (^)(id))successBlock
              onFailure:(void (^)(NSError *))failureBlock {
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@", baseUrl, path];
    [self debugLog:urlStr params:nil];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
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
    NSString *urlStr = [NSString stringWithFormat:@"https://submit.jotform.com/submit/%lld/",formID];
     [self debugLog:urlStr params:reportParams];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
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
               onFailure:(void (^)(NSError *))failureBlock {
    NSString *urlStr = [NSString stringWithFormat:@"https://submit.jotform.me/submit/%lld/",formID];
    [self debugLog:urlStr params:suggestionParams];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
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
    NSString *urlStr = [NSString stringWithFormat:@"%@/user/login", baseUrl];
    
    [self debugLog:urlStr params:userinfo];
    
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
    NSString *urlStr = [NSString stringWithFormat:@"%@/user/logout?apiKey=%@", baseUrl,apiKey];
    
    [self debugLog:urlStr params:userinfo];
    
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
    NSString *urlStr = [NSString stringWithFormat:@"%@/user/register?apiKey=%@", baseUrl,apiKey];
    
    [self debugLog:urlStr params:userinfo];
    
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
    NSString *urlStr = [NSString stringWithFormat:@"%@/user?apiKey=%@", baseUrl,apiKey];
    
    [self debugLog:urlStr params:nil];
    
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
    NSString *urlStr = [NSString stringWithFormat:@"%@/user/usage?apiKey=%@", baseUrl,apiKey];
    
    [self debugLog:urlStr params:nil];
    
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
    NSString *urlStr = [NSString stringWithFormat:@"%@/user/forms?apiKey=%@", baseUrl,apiKey];
    
    [self debugLog:urlStr params:nil];
    
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
    NSMutableDictionary *params = [self createConditions:offset limit:limit filter:filter orderBy:orderBy];
    NSMutableArray *paramarray = [[NSMutableArray alloc] init];
    NSArray *keys = [params allKeys];
    
    for (NSString *key in keys) {
        [paramarray addObject:[NSString stringWithFormat:@"%@=%@", key, params[key]]];
    }
    
    NSString *paramstr = [paramarray componentsJoinedByString:@"&"];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/user/forms?apiKey=%@&%@", baseUrl,apiKey,paramstr];
    
    [self debugLog:urlStr params:nil];
    
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
    NSString *urlStr = [NSString stringWithFormat:@"%@/user/submissions?apiKey=%@", baseUrl,apiKey];
    
    [self debugLog:urlStr params:nil];
    
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
    NSMutableDictionary *params = [self createConditions:offset limit:limit filter:filter orderBy:orderBy];
    
    NSMutableArray *paramarray = [[NSMutableArray alloc] init];
    NSArray *keys = [params allKeys];
    
    for (NSString *key in keys) {
        [paramarray addObject:[NSString stringWithFormat:@"%@=%@", key, params[key]]];
    }
    
    NSString *paramstr = [paramarray componentsJoinedByString:@"&"];
    NSString *urlStr = [NSString stringWithFormat:@"%@/user/submissions?apiKey=%@&%@",baseUrl,apiKey,paramstr];
    
    [self debugLog:urlStr params:nil];
    
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
    NSString *urlStr = [NSString stringWithFormat:@"%@/user/subusers?apiKey=%@", baseUrl,apiKey];
    
    [self debugLog:urlStr params:nil];
    
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
    NSString *urlStr = [NSString stringWithFormat:@"%@/users/folders?apiKey=%@", baseUrl,apiKey];
    
    [self debugLog:urlStr params:nil];
    
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
    NSString *urlStr = [NSString stringWithFormat:@"%@/folder/%lld?apiKey=%@", baseUrl,folderID, apiKey];
    
    [self debugLog:urlStr params:nil];
    
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
    NSString *urlStr = [NSString stringWithFormat:@"%@/user/reports/apiKey=%@", baseUrl, apiKey];
    
    [self debugLog:urlStr params:nil];
    
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
    NSString *urlStr = [NSString stringWithFormat:@"%@/user/reports/%lld?apiKey=%@", baseUrl,reportID, apiKey];
    
   [self debugLog:urlStr params:nil];
    
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
    NSString *urlStr = [NSString stringWithFormat:@"%@/user/settings?apiKey=%@", baseUrl,apiKey];
    
    [self debugLog:urlStr params:nil];
    
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
    NSString *urlStr = [NSString stringWithFormat:@"%@/user/settings?apiKey=%@", baseUrl,apiKey];
    
    [self debugLog:urlStr params:settings];
    
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
    NSString *urlStr = [NSString stringWithFormat:@"%@/user/history?apiKey=%@", baseUrl,apiKey];
    
   [self debugLog:urlStr params:nil];
    
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
    
     NSString *urlStr = [NSString stringWithFormat:@"%@/user/history?apiKey=%@", baseUrl,apiKey];
    
     NSMutableDictionary *params = [self createHistoryQuery:action date:date sortBy:sortBy startDate:startDate endDate:endDate];
    
    [self debugLog:urlStr params:params];
    
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
    NSString *urlStr = [NSString stringWithFormat:@"%@/form/%lld?apiKey=%@", baseUrl,formID, apiKey];
    
    [self debugLog:urlStr params:nil];
    
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
               onFailure:(void (^)(NSError *))failureBlock {
    NSString *urlStr = [NSString stringWithFormat:@"%@/form/%lld/questions?apiKey=%@", baseUrl,formID,apiKey];
    
    [self debugLog:urlStr params:nil];
    
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
    NSString *urlStr = [NSString stringWithFormat:@"%@/form/%lld/question/%lld?apiKey=%@", baseUrl,formID,qid, apiKey];
    
    [self debugLog:urlStr params:nil];
    
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
    NSString *urlStr = [NSString stringWithFormat:@"%@/form/%lld/submissions?apiKey=%@", baseUrl,formID,apiKey];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"qid_enabled"] = @"true";
    
    [self debugLog:urlStr params:params];
    
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
    NSString *urlStr = [NSString stringWithFormat:@"%@/form/%lld/submissions?apiKey=%@", baseUrl,formID, apiKey];
    
    NSMutableDictionary *params = [self createConditions:offset limit:limit filter:filter orderBy:orderBy];
    
    [self debugLog:urlStr params:params];
    
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
    NSString *urlStr = [NSString stringWithFormat:@"%@/form/%lld/reports?apiKey=%@", baseUrl,formID,apiKey];
    
    [self debugLog:urlStr params:nil];
    
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
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    NSArray *keys = [submission allKeys];
    
    NSString *subkey = @"";
    
    for (NSString *key in keys) {
        if ([key rangeOfString:@"_"].location != NSNotFound) {
            subkey = [NSString
                      stringWithFormat:
                      @"submission[%@][%@]",
                      [key substringToIndex:[key rangeOfString:@"_"].location],
                      [key substringToIndex:([key rangeOfString:@"_"].location + 1)]];
        } else {
            subkey = [NSString stringWithFormat:@"submission[%@]", key];
        }
        
        if (submission[key]) {
            params[subkey] = submission[key];
        }
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/form/%lld/submissions?apiKey=%@", baseUrl,formID,apiKey];
    
    [self debugLog:urlStr params:params];
    
    [manager POST:urlStr parameters:params progress:nil
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
    NSString *urlStr = [NSString stringWithFormat:@"%@/form/%lld/files?apiKey=%@", baseUrl,formID, apiKey];
    
    [self debugLog:urlStr params:nil];
    
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
  NSString *urlStr = [NSString stringWithFormat:@"%@/form/%lld/webhooks?apiKey=%@", baseUrl,formID,apiKey];
    
   [self debugLog:urlStr params:nil];
    
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
    
    if ([webhookURL length]) {
        params[@"webhookURL"] = webhookURL;
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/form/%lld/webhooks?apiKey=%@", baseUrl,formID,apiKey];
    
    [self debugLog:urlStr params:params];
    
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
    NSString *urlStr = [NSString stringWithFormat:@"%@/forms/%lld/webhooks/%lld?apiKey=%@", baseUrl,formID,webhookID,apiKey];
  
    [self debugLog:urlStr params:nil];
    
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
    NSString *urlStr = [NSString stringWithFormat:@"%@/submission/%lld?apiKey=%@", baseUrl,sid,apiKey];
    
    [self debugLog:urlStr params:nil];
    
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
    NSString *urlStr = [NSString stringWithFormat:@"%@/report/%lld?apiKey=%@",baseUrl,reportID,apiKey];
    
    [self debugLog:urlStr params:nil];
    
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
    NSString *urlStr = [NSString stringWithFormat:@"%@/form/%lld/reports?apiKey=%@", baseUrl,formID,apiKey];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    params[@"id"] = @(formID);
    
    if (title) {
        params[@"title"] = title;
    }
    
    if (list_type) {
        params[@"list_type"] = list_type;
    }
    
    if (fields) {
        params[@"fields"] = fields;
    }

    [self debugLog:urlStr params:params];
    
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
    NSString *urlStr = [NSString stringWithFormat:@"%@/form/%lld/properties?apiKey=%@",baseUrl,formID,apiKey];
    
    [self debugLog:urlStr params:nil];
    
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
    NSString *urlStr = [NSString stringWithFormat:@"%@/form/%lld/properties/%@?apiKey=%@",baseUrl,formID,propertyKey,apiKey];
    
    [self debugLog:urlStr params:nil];
    
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

- (void)checkEUserver:(NSString *)_apiKey
            onSuccess:(void (^)(id))successBlock
            onFailure:(void (^)(NSError *))failureBlock {
    NSString *urlStr = [[NSString stringWithFormat:@"%@/user/settings/euOnly?apiKey=%@", baseUrl,_apiKey] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [self debugLog:urlStr params:nil];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
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
               onFailure:(void (^)(NSError *))failureBlock {
    NSString *urlStr = [NSString stringWithFormat:@"%@/submission/%lld?apiKey=%@", baseUrl,sid,apiKey];
    
    [self debugLog:urlStr params:nil];
    
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
    NSString *urlStr = [NSString stringWithFormat:@"%@/submission/%lld?apiKey=%@", baseUrl,sid,apiKey];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    if (submissionName) {
        params[@"submission[1][first]"] = submissionName;
    }
    
    params[@"submission[new]"] = [@(new) stringValue];
    params[@"submission[flag]"] = [@(flag) stringValue];
    
    [self debugLog:urlStr params:params];
    
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
    NSString *urlStr = [NSString stringWithFormat:@"%@/form/%lld/clone?apiKey=%@", baseUrl,formID,apiKey];
    
    [self debugLog:urlStr params:nil];
    
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
    NSString *urlStr = [NSString stringWithFormat:@"%@/form/%lld/question/%lld?apiKey=%@",baseUrl,formID,qid,apiKey];
    
    [self debugLog:urlStr params:nil];
    
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
    NSString *urlStr = [NSString stringWithFormat:@"%@/form/%lld/questions?apiKey=%@", baseUrl,formID,apiKey];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    NSArray *keys = [question allKeys];
    
    for (NSString *key in keys) {
        [params setObject:question[key] forKey:[NSString stringWithFormat:@"question[%@]", key]];
    }
    
    [self debugLog:urlStr params:params];
    
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
    NSString *urlStr = [NSString stringWithFormat:@"%@/form/%lld/questions?apiKey=%@", baseUrl,formID, apiKey];
    
    [self debugLog:urlStr params:questions];
    
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
               onFailure:(void (^)(NSError *))failureBlock {
    NSString *urlStr = [NSString stringWithFormat:@"%@/form/%lld/question/%lld?apiKey=%@", baseUrl,formID,qid,apiKey];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    NSArray *keys = [properties allKeys];
    
    for (NSString *key in keys) {
        [params setObject:properties[key] forKey:[NSString stringWithFormat:@"question[%@]", key]];
    }
    
    [self debugLog:urlStr params:params];
    
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
    NSString *urlStr = [NSString stringWithFormat:@"%@/form/%lld/properties?apiKey=%@", baseUrl,formID,apiKey];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    NSArray *keys = [properties allKeys];
    
    for (NSString *key in keys) {
        [params setObject:properties[key] forKey:[NSString stringWithFormat:@"properties[%@]", key]];
    }
    
    [self debugLog:urlStr params:params];
    
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
    NSString *urlStr = [NSString stringWithFormat:@"%@/form/%lld/properties?apiKey=%@", baseUrl,formID,apiKey];
    
    [self debugLog:urlStr params:properties];
    
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
                [params setObject:properties[propertyKey] forKey:[NSString stringWithFormat:@"%@[%@]", formKey, propertyKey]];
            }
        } else {
            NSMutableDictionary *formItem = form[formKey];
            
            NSArray *formItemKeys = [formItem allKeys];
            
            for (NSString *formItemKey in formItemKeys) {
                NSMutableDictionary *fi = formItem[formItemKey];
                NSArray *fiKeys = [fi allKeys];
                
                for (NSString *fiKey in fiKeys) {
                    [params setObject:fi[fiKey] forKey:[NSString stringWithFormat:@"%@[%@][%@]", formKey, formItemKey, fiKey]];
                }
            }
        }
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@/user/forms?apiKey=%@", baseUrl,apiKey];
    
    [self debugLog:urlStr params:params];
    
    [manager POST:urlStr parameters:params progress:nil
          success:^(NSURLSessionTask *task, id responseObject) {
              successBlock(responseObject);
          }
          failure:^(NSURLSessionTask *operation, NSError *error) {
              failureBlock(error);
          }];
}

- (void)createForms:(NSDictionary *)form
          onSuccess:(void (^)(id))successBlock
          onFailure:(void (^)(NSError *))failureBlock {
    NSString *urlStr = [NSString stringWithFormat:@"%@/user/forms?apiKey=%@", baseUrl,apiKey];
    [self debugLog:urlStr params:form];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
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
    NSString *urlStr = [NSString stringWithFormat:@"%@/forms/%lld?apiKey=%@", baseUrl,formID, apiKey];
    
    [self debugLog:urlStr params:nil];
    
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
    NSString *urlStr = [NSString stringWithFormat:@"%@/system/plan/%@", baseUrl,planType];
    
    [self debugLog:urlStr params:nil];
    
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

- (void)getSystemTime:(void (^)(id))successBlock
            onFailure:(void (^)(NSError *))failureBlock {
    NSString *urlStr = [NSString stringWithFormat:@"%@/system/time", baseUrl];
    
    [self debugLog:urlStr params:nil];
    
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
    
    if ([action length]) {
         params[@"action"] = action;
    }
    
    if ([date length]) {
        params[@"date"] = date;
    }
    
    if ([sortBy length]) {
        params[@"sortBy"] = sortBy;
    }
    
    if ([startDate length]) {
        params[@"startDate"] = startDate;
    }
    
    if ([endDate length]) {
        params[@"endDate"] = endDate;
    }
    
    return params;
}

- (NSMutableDictionary *)createConditions:(NSInteger)offset
                                    limit:(NSInteger)limit
                                   filter:(NSMutableDictionary *)filter
                                  orderBy:(NSString *)orderBy {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    if (offset != 0) {
        params[@"offset"] = @(offset);
    }
    
    if (limit != 0) {
        params[@"limit"] = @(limit);
    }
    
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
        params[@"filter"] = filterStr;
    }
    
    if ([orderBy length]) {
        params[@"orderyBy"] = orderBy;
    }
    
    return params;
}

@end
