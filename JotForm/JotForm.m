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
    AFHTTPSessionManager *manager;
    BOOL debugMode;
}

@end

@implementation JotForm

- (instancetype)initWithApiKey:(NSString *)apikey debugMode:(BOOL)debugmode baseUrlType:(BaseUrlType)baseUrlType {
    if (self = [super init]) {
        
        switch(baseUrlType) {
            case USBaseUrl:
                self.baseUrl = @"https://api.jotform.com";
                break;
            case EUBaseUrl:
                self.baseUrl = @"https://eu-api.jotform.com";
                break;
            case HIPAABaseUrl:
                self.baseUrl = @"https://hipaa-api.jotform.com";
                break;
            default:
                [NSException raise:NSGenericException format:@"Unexpected BaseUrlType."];
        }
        
        debugMode = debugmode;
        
        manager = [AFHTTPSessionManager manager];
     
        if (apikey.length > 0) {
            [manager.requestSerializer setValue:apikey forHTTPHeaderField:@"apiKey"];
        }
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
        
        NSLog(@"urlstr = %@", urlStr);
        
        if (paramsStr.length > 0) {
            NSLog(@"paramstr = %@",paramsStr);
        }
    }
}

- (void)createReport:(long long)formID reportParams:(NSMutableDictionary *)reportParams
           onSuccess:(SuccessCompletionBlock)successBlock
           onFailure:(FailureCompletionBlock)failureBlock {
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
               onSuccess:(SuccessCompletionBlock)successBlock
               onFailure:(FailureCompletionBlock)failureBlock {
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
    onSuccess:(SuccessCompletionBlock)successBlock
    onFailure:(FailureCompletionBlock)failureBlock {
    NSString *urlStr = [NSString stringWithFormat:@"%@/user/login", self.baseUrl];
    
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
     onSuccess:(SuccessCompletionBlock)successBlock
     onFailure:(FailureCompletionBlock)failureBlock {
    NSString *urlStr = [NSString stringWithFormat:@"%@/user/logout", self.baseUrl];
    
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
           onSuccess:(SuccessCompletionBlock)successBlock
           onFailure:(FailureCompletionBlock)failureBlock {
    NSString *urlStr = [NSString stringWithFormat:@"%@/user/register", self.baseUrl];
    
    [self debugLog:urlStr params:userinfo];
    
    [manager POST:urlStr parameters:userinfo progress:nil
          success:^(NSURLSessionTask *task, id responseObject) {
              successBlock(responseObject);
          }
          failure:^(NSURLSessionTask *operation, NSError *error) {
              failureBlock(error);
          }];
}

- (void)getUser:(SuccessCompletionBlock)successBlock
      onFailure:(FailureCompletionBlock)failureBlock  {
    NSString *urlString = [NSString stringWithFormat:@"%@/user", self.baseUrl];
   
    [self debugLog:urlString params:nil];
    [self getRequestWithURLString:urlString onSuccess:successBlock onFailure:failureBlock];
}

- (void)getUsage:(SuccessCompletionBlock)successBlock
       onFailure:(FailureCompletionBlock)failureBlock {
    NSString *urlString = [NSString stringWithFormat:@"%@/user/usage", self.baseUrl];
    
    [self debugLog:urlString params:nil];
    [self getRequestWithURLString:urlString onSuccess:successBlock onFailure:failureBlock];
}

- (void)getForms:(SuccessCompletionBlock)successBlock
       onFailure:(FailureCompletionBlock)failureBlock {
    NSString *urlString = [NSString stringWithFormat:@"%@/user/forms", self.baseUrl];
    
    [self debugLog:urlString params:nil];
    [self getRequestWithURLString:urlString onSuccess:successBlock onFailure:failureBlock];
}

- (void)getForms:(NSInteger)offset
           limit:(NSInteger)limit
         orderBy:(NSString *)orderBy
          filter:(NSMutableDictionary *)filter
       onSuccess:(SuccessCompletionBlock)successBlock
       onFailure:(FailureCompletionBlock)failureBlock {
    
    NSMutableDictionary *params = [self createConditions:offset limit:limit filter:filter orderBy:orderBy];
    NSMutableArray *paramarray = [[NSMutableArray alloc] init];
    NSArray *keys = params.allKeys;
    
    for (NSString *key in keys) {
        [paramarray addObject:[NSString stringWithFormat:@"%@=%@", key, params[key]]];
    }
    
    NSString *paramstring = [paramarray componentsJoinedByString:@"&"];
    
    NSString *urlString = [NSString stringWithFormat:@"%@/user/forms?%@", self.baseUrl, paramstring];
    
    [self debugLog:urlString params:nil];
    [self getRequestWithURLString:urlString onSuccess:successBlock onFailure:failureBlock];
}

- (void)getSubmissions:(SuccessCompletionBlock)successBlock
             onFailure:(FailureCompletionBlock)failureBlock {
    NSString *urlString = [NSString stringWithFormat:@"%@/user/submissions", self.baseUrl];
    
    [self debugLog:urlString params:nil];
    [self getRequestWithURLString:urlString onSuccess:successBlock onFailure:failureBlock];
}

- (void)getSubmissions:(NSInteger)offset
                 limit:(NSInteger)limit
               orderBy:(NSString *)orderBy
                filter:(NSDictionary *)filter
             onSuccess:(SuccessCompletionBlock)successBlock
             onFailure:(FailureCompletionBlock)failureBlock
{
    NSMutableDictionary *params = [self createConditions:offset limit:limit filter:filter orderBy:orderBy];
    
    NSMutableArray *paramarray = [[NSMutableArray alloc] init];
    NSArray *keys = params.allKeys;
    
    for (NSString *key in keys) {
        [paramarray addObject:[NSString stringWithFormat:@"%@=%@", key, params[key]]];
    }
    
    NSString *paramstring = [paramarray componentsJoinedByString:@"&"];
    NSString *urlString = [NSString stringWithFormat:@"%@/user/submissions?%@",self.baseUrl,paramstring];
    
    [self debugLog:urlString params:nil];
    [self getRequestWithURLString:urlString onSuccess:successBlock onFailure:failureBlock];
}

- (void)getSubusers:(SuccessCompletionBlock)successBlock
          onFailure:(FailureCompletionBlock)failureBlock  {
    NSString *urlString = [NSString stringWithFormat:@"%@/user/subusers", self.baseUrl];
    
    [self debugLog:urlString params:nil];
    [self getRequestWithURLString:urlString onSuccess:successBlock onFailure:failureBlock];
}

- (void)getFolders:(SuccessCompletionBlock)successBlock
         onFailure:(FailureCompletionBlock)failureBlock {
    NSString *urlString = [NSString stringWithFormat:@"%@/users/folders", self.baseUrl];
    
    [self debugLog:urlString params:nil];
    [self getRequestWithURLString:urlString onSuccess:successBlock onFailure:failureBlock];
}

- (void)getFolder:(long long)folderID
        onSuccess:(SuccessCompletionBlock)successBlock
        onFailure:(FailureCompletionBlock)failureBlock {
    NSString *urlString = [NSString stringWithFormat:@"%@/folder/%lld", self.baseUrl, folderID];
    
    [self debugLog:urlString params:nil];
    [self getRequestWithURLString:urlString onSuccess:successBlock onFailure:failureBlock];
}

- (void)getReports:(SuccessCompletionBlock)successBlock
         onFailure:(FailureCompletionBlock)failureBlock {
    NSString *urlString = [NSString stringWithFormat:@"%@/user/reports/", self.baseUrl];
    
    [self debugLog:urlString params:nil];
    [self getRequestWithURLString:urlString onSuccess:successBlock onFailure:failureBlock];
}

- (void)deleteReport:(long long)reportID
           onSuccess:(SuccessCompletionBlock)successBlock
           onFailure:(FailureCompletionBlock)failureBlock {
    NSString *urlStr = [NSString stringWithFormat:@"%@/user/reports/%lld", self.baseUrl,reportID];
    
    [self debugLog:urlStr params:nil];
    
    [manager DELETE:urlStr parameters:nil
            success:^(NSURLSessionTask *task, id responseObject) {
                successBlock(responseObject);
            }
            failure:^(NSURLSessionTask *operation, NSError *error) {
                failureBlock(error);
            }];
}

- (void)getSettings:(SuccessCompletionBlock)successBlock
          onFailure:(FailureCompletionBlock)failureBlock {
    NSString *urlString = [NSString stringWithFormat:@"%@/user/settings", self.baseUrl];
    
    [self debugLog:urlString params:nil];
    [self getRequestWithURLString:urlString onSuccess:successBlock onFailure:failureBlock];
}

- (void)updateSettings:(NSDictionary *)settings
             onSuccess:(SuccessCompletionBlock)successBlock
             onFailure:(FailureCompletionBlock)failureBlock {
    NSString *urlStr = [NSString stringWithFormat:@"%@/user/settings", self.baseUrl];
    
    [self debugLog:urlStr params:settings];
    
    [manager POST:urlStr parameters:settings progress:nil
          success:^(NSURLSessionTask *task, id responseObject) {
              successBlock(responseObject);
          }
          failure:^(NSURLSessionTask *operation, NSError *error) {
              failureBlock(error);
          }];
}

- (void)getHistory:(SuccessCompletionBlock)successBlock
         onFailure:(FailureCompletionBlock)failureBlock {
    NSString *urlString = [NSString stringWithFormat:@"%@/user/history", self.baseUrl];
    
    [self debugLog:urlString params:nil];
    [self getRequestWithURLString:urlString onSuccess:successBlock onFailure:failureBlock];
}

- (void)getHistory:(NSString *)action
              date:(NSString *)date
            sortBy:(NSString *)sortBy
         startDate:(NSString *)startDate
           endDate:(NSString *)endDate
         onSuccess:(SuccessCompletionBlock)successBlock
         onFailure:(FailureCompletionBlock)failureBlock {
    
    NSString *urlString = [NSString stringWithFormat:@"%@/user/history", self.baseUrl];
    NSMutableDictionary *params = [self createHistoryQuery:action date:date sortBy:sortBy startDate:startDate endDate:endDate];
    
    [self debugLog:urlString params:params];
    
    [manager GET:urlString
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
      onSuccess:(SuccessCompletionBlock)successBlock
      onFailure:(FailureCompletionBlock)failureBlock {
    NSString *urlString = [NSString stringWithFormat:@"%@/form/%lld", self.baseUrl,formID];
    
    [self debugLog:urlString params:nil];
    [self getRequestWithURLString:urlString onSuccess:successBlock onFailure:failureBlock];
}

- (void)getFormQuestions:(long long)formID
               onSuccess:(SuccessCompletionBlock)successBlock
               onFailure:(FailureCompletionBlock)failureBlock {
    NSString *urlString = [NSString stringWithFormat:@"%@/form/%lld/questions", self.baseUrl, formID];
   
    [self debugLog:urlString params:nil];
    [self getRequestWithURLString:urlString onSuccess:successBlock onFailure:failureBlock];
}

- (void)getFormQuestion:(long long)formID questionID:(long long)qid
              onSuccess:(SuccessCompletionBlock)successBlock
              onFailure:(FailureCompletionBlock)failureBlock {
    NSString *urlString = [NSString stringWithFormat:@"%@/form/%lld/question/%lld", self.baseUrl, formID, qid];
    
    [self debugLog:urlString params:nil];
    [self getRequestWithURLString:urlString onSuccess:successBlock onFailure:failureBlock];
}

- (void)getFormSubmissions:(long long)formID
                 onSuccess:(SuccessCompletionBlock)successBlock
                 onFailure:(FailureCompletionBlock)failureBlock {
    NSString *urlStr = [NSString stringWithFormat:@"%@/form/%lld/submissions", self.baseUrl, formID];
    
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
                    filter:(NSDictionary *)filter
                 onSuccess:(SuccessCompletionBlock)successBlock
                 onFailure:(FailureCompletionBlock)failureBlock {
    NSString *urlStr = [NSString stringWithFormat:@"%@/form/%lld/submissions", self.baseUrl, formID];
    
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
             onSuccess:(SuccessCompletionBlock)successBlock
             onFailure:(FailureCompletionBlock)failureBlock {
    NSString *urlString = [NSString stringWithFormat:@"%@/form/%lld/reports", self.baseUrl, formID];
    
    [self debugLog:urlString params:nil];
    [self getRequestWithURLString:urlString onSuccess:successBlock onFailure:failureBlock];
}

- (void)createFormSubmissions:(long long)formID
                   submission:(NSDictionary *)submission
                    onSuccess:(SuccessCompletionBlock)successBlock
                    onFailure:(FailureCompletionBlock)failureBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    NSArray *keys = submission.allKeys;
    
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
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/form/%lld/submissions", self.baseUrl,formID];
    
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
           onSuccess:(SuccessCompletionBlock)successBlock
           onFailure:(FailureCompletionBlock)failureBlock {
    NSString *urlString = [NSString stringWithFormat:@"%@/form/%lld/files", self.baseUrl,formID];
    
    [self debugLog:urlString params:nil];
    [self getRequestWithURLString:urlString onSuccess:successBlock onFailure:failureBlock];
}

- (void)getFormWebhooks:(long long)formID
              onSuccess:(SuccessCompletionBlock)successBlock
              onFailure:(FailureCompletionBlock)failureBlock {
    NSString *urlString = [NSString stringWithFormat:@"%@/form/%lld/webhooks", self.baseUrl,formID];
    
    [self debugLog:urlString params:nil];
    [self getRequestWithURLString:urlString onSuccess:successBlock onFailure:failureBlock];
}

- (void)createFormWebhooks:(long long)formID hookUrl:(NSString *)webhookURL
                 onSuccess:(SuccessCompletionBlock)successBlock
                 onFailure:(FailureCompletionBlock)failureBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    if (webhookURL.length) {
        params[@"webhookURL"] = webhookURL;
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/form/%lld/webhooks", self.baseUrl,formID];
    
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
            onSuccess:(SuccessCompletionBlock)successBlock
            onFailure:(FailureCompletionBlock)failureBlock {
    NSString *urlStr = [NSString stringWithFormat:@"%@/forms/%lld/webhooks/%lld", self.baseUrl,formID,webhookID];
    
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
            onSuccess:(SuccessCompletionBlock)successBlock
            onFailure:(FailureCompletionBlock)failureBlock {
    NSString *urlString = [NSString stringWithFormat:@"%@/submission/%lld", self.baseUrl, sid];
    
    [self debugLog:urlString params:nil];
    [self getRequestWithURLString:urlString onSuccess:successBlock onFailure:failureBlock];
}

- (void)getReport:(long long)reportID onSuccess:(SuccessCompletionBlock)successBlock
        onFailure:(FailureCompletionBlock)failureBlock {
    NSString *urlString = [NSString stringWithFormat:@"%@/report/%lld",self.baseUrl,reportID];
    
    [self debugLog:urlString params:nil];
    [self getRequestWithURLString:urlString onSuccess:successBlock onFailure:failureBlock];
}

- (void)createReport:(long long)formID
               title:(NSString *)title
           list_type:(NSString *)list_type
              fields:(NSString *)fields
           onSuccess:(SuccessCompletionBlock)successBlock
           onFailure:(FailureCompletionBlock)failureBlock {
    NSString *urlStr = [NSString stringWithFormat:@"%@/form/%lld/reports", self.baseUrl,formID];
    
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
                onSuccess:(SuccessCompletionBlock)successBlock
                onFailure:(FailureCompletionBlock)failureBlock {
    NSString *urlString = [NSString stringWithFormat:@"%@/form/%lld/properties",self.baseUrl,formID];
    
    [self debugLog:urlString params:nil];
    [self getRequestWithURLString:urlString onSuccess:successBlock onFailure:failureBlock];
}

- (void)getFormProperty:(long long)formID propertyKey:(NSString *)propertyKey
              onSuccess:(SuccessCompletionBlock)successBlock
              onFailure:(FailureCompletionBlock)failureBlock {
    NSString *urlString = [NSString stringWithFormat:@"%@/form/%lld/properties/%@",self.baseUrl,formID,propertyKey];
    
    [self debugLog:urlString params:nil];
    [self getRequestWithURLString:urlString onSuccess:successBlock onFailure:failureBlock];
}

- (void)deleteSubmission:(long long)sid
               onSuccess:(SuccessCompletionBlock)successBlock
               onFailure:(FailureCompletionBlock)failureBlock {
    NSString *urlStr = [NSString stringWithFormat:@"%@/submission/%lld", self.baseUrl,sid];
    
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
             onSuccess:(SuccessCompletionBlock)successBlock
             onFailure:(FailureCompletionBlock)failureBlock {
    NSString *urlStr = [NSString stringWithFormat:@"%@/submission/%lld", self.baseUrl,sid];
    
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
        onSuccess:(SuccessCompletionBlock)successBlock
        onFailure:(FailureCompletionBlock)failureBlock {
    NSString *urlStr = [NSString stringWithFormat:@"%@/form/%lld/clone", self.baseUrl,formID];
    
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
                 onSuccess:(SuccessCompletionBlock)successBlock
                 onFailure:(FailureCompletionBlock)failureBlock {
    NSString *urlStr = [NSString stringWithFormat:@"%@/form/%lld/question/%lld",self.baseUrl,formID,qid];
    
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
                  question:(NSDictionary *)question
                 onSuccess:(SuccessCompletionBlock)successBlock
                 onFailure:(FailureCompletionBlock)failureBlock {
    NSString *urlStr = [NSString stringWithFormat:@"%@/form/%lld/questions", self.baseUrl,formID];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    NSArray *keys = question.allKeys;
    
    for (NSString *key in keys) {
        params[[NSString stringWithFormat:@"question[%@]", key]] = question[key];
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
                  onSuccess:(SuccessCompletionBlock)successBlock
                  onFailure:(FailureCompletionBlock)failureBlock {
    NSString *urlStr = [NSString stringWithFormat:@"%@/form/%lld/questions", self.baseUrl,formID];
    
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
      questionProperties:(NSDictionary *)properties
               onSuccess:(SuccessCompletionBlock)successBlock
               onFailure:(FailureCompletionBlock)failureBlock {
    NSString *urlStr = [NSString stringWithFormat:@"%@/form/%lld/question/%lld", self.baseUrl,formID,qid];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    NSArray *keys = properties.allKeys;
    
    for (NSString *key in keys) {
        params[[NSString stringWithFormat:@"question[%@]", key]] = properties[key];
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
           formProperties:(NSDictionary *)properties
                onSuccess:(SuccessCompletionBlock)successBlock
                onFailure:(FailureCompletionBlock)failureBlock {
    NSString *urlStr = [NSString stringWithFormat:@"%@/form/%lld/properties", self.baseUrl,formID];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    NSArray *keys = properties.allKeys;
    
    for (NSString *key in keys) {
        params[[NSString stringWithFormat:@"properties[%@]", key]] = properties[key];
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
                        onSuccess:(SuccessCompletionBlock)successBlock
                        onFailure:(FailureCompletionBlock)failureBlock {
    NSString *urlStr = [NSString stringWithFormat:@"%@/form/%lld/properties", self.baseUrl,formID];
    
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
         onSuccess:(SuccessCompletionBlock)successBlock
         onFailure:(FailureCompletionBlock)failureBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    NSArray *formKeys = form.allKeys;
    
    for (NSString *formKey in formKeys) {
        if ([formKey isEqualToString:@"properties"]) {
            NSMutableDictionary *properties = form[formKey];
            
            NSArray *propertyKeys = properties.allKeys;
            
            for (NSString *propertyKey in propertyKeys) {
                params[[NSString stringWithFormat:@"%@[%@]", formKey, propertyKey]] = properties[propertyKey];
            }
        } else {
            NSMutableDictionary *formItem = form[formKey];
            
            NSArray *formItemKeys = formItem.allKeys;
            
            for (NSString *formItemKey in formItemKeys) {
                NSMutableDictionary *fi = formItem[formItemKey];
                NSArray *fiKeys = fi.allKeys;
                
                for (NSString *fiKey in fiKeys) {
                    params[[NSString stringWithFormat:@"%@[%@][%@]", formKey, formItemKey, fiKey]] = fi[fiKey];
                }
            }
        }
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@/user/forms", self.baseUrl];
    
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
          onSuccess:(SuccessCompletionBlock)successBlock
          onFailure:(FailureCompletionBlock)failureBlock {
    NSString *urlStr = [NSString stringWithFormat:@"%@/user/forms", self.baseUrl];
    [self debugLog:urlStr params:form];
    
    [manager PUT:urlStr parameters:form
         success:^(NSURLSessionTask *task, id responseObject) {
             successBlock(responseObject);
         }
         failure:^(NSURLSessionTask *operation, NSError *error) {
             failureBlock(error);
         }];
}

- (void)deleteForm:(long long)formID
         onSuccess:(SuccessCompletionBlock)successBlock
         onFailure:(FailureCompletionBlock)failureBlock {
    NSString *urlStr = [NSString stringWithFormat:@"%@/forms/%lld", self.baseUrl,formID];
    
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
            onSuccess:(SuccessCompletionBlock)successBlock
            onFailure:(FailureCompletionBlock)failureBlock {
    NSString *urlString = [NSString stringWithFormat:@"%@/system/plan/%@", self.baseUrl,planType];
    
    [self debugLog:urlString params:nil];
    [self getRequestWithURLString:urlString onSuccess:successBlock onFailure:failureBlock];
}

- (void)getSystemTime:(SuccessCompletionBlock)successBlock
            onFailure:(FailureCompletionBlock)failureBlock {
    NSString *urlString = [NSString stringWithFormat:@"%@/system/time", self.baseUrl];
    
    [self debugLog:urlString params:nil];
    [self getRequestWithURLString:urlString onSuccess:successBlock onFailure:failureBlock];
}

- (void)getAccountSettings:(SuccessCompletionBlock)successBlock
                 onFailure:(FailureCompletionBlock)failureBlock {
    NSString *urlString = [NSString stringWithFormat:@"%@/user/settings", self.baseUrl];
    
    [self debugLog:urlString params:nil];
    [self getRequestWithURLString:urlString onSuccess:successBlock onFailure:failureBlock];
}

- (void)getRequestWithURLString:(NSString *)urlString
                      onSuccess:(SuccessCompletionBlock)successBlock
                      onFailure:(FailureCompletionBlock)failureBlock {
    
    [manager GET:urlString
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
    
    if (action.length) {
        params[@"action"] = action;
    }
    
    if (date.length) {
        params[@"date"] = date;
    }
    
    if (sortBy.length) {
        params[@"sortBy"] = sortBy;
    }
    
    if (startDate.length) {
        params[@"startDate"] = startDate;
    }
    
    if (endDate.length) {
        params[@"endDate"] = endDate;
    }
    
    return params;
}

- (NSMutableDictionary *)createConditions:(NSInteger)offset
                                    limit:(NSInteger)limit
                                   filter:(NSDictionary *)filter
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
        NSArray *keys = filter.allKeys;
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
                
                if (count < filter.count) {
                    filterStr = [filterStr stringByAppendingString:@"%2C"];
                }
            }
        }
        
        filterStr = [filterStr stringByAppendingString:@"%7D"];
        params[@"filter"] = filterStr;
    }
    
    if (orderBy.length) {
        params[@"orderyBy"] = orderBy;
    }
    
    return params;
}

- (void)cancelAllTasks {
    for (NSURLSessionTask *task in manager.tasks) {
        [task cancel];
    }
}

@end
