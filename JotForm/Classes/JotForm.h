//
//  JotForm.h
//  JotForm
//
//  Created by Wang YuPing on 7/9/13.
//  Copyright 2013 Interlogy, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "ASIFormDataRequest.h"
#import "SBJsonParser.h"
#import "SBJsonWriter.h"

typedef void (^JorFormBlock)(id);

@interface JotForm : NSObject<ASIHTTPRequestDelegate>
{
    NSString        *apiKey;
    NSString        *baseUrl;
    NSString        *apiVersion;
    
    BOOL             debugMode;
}

@property (nonatomic, retain) NSOperationQueue  *operationQueue;
@property (nonatomic, copy) JorFormBlock        didFinishBlock;
@property (nonatomic, copy) JorFormBlock        didFailBlock;

- (id) initWithApiKey : (NSString *) apikey debugMode : (BOOL) debugmode;
- (void) getUser;
- (void) getUsage;
- (void) getForms;
- (void) getSubmissions;
- (void) getSubusers;
- (void) getFolders;
- (void) getReports;
- (void) getSettings;
- (void) getHistory;
- (void) getForm : (long long) formID;
- (void) getFormQuestions : (long long) formID;
- (void) getFormQuestions : (long long) formID questionID : (long long) qid;
- (void) getFormSubmissions : (long long) formID;
- (void) getFormSubmissions : (long long) formID limit : (NSInteger) limit orderBy : (NSString *) orderBy filter : (NSMutableDictionary *) filter;
- (void) createFormSubmissions : (long long) formID submission : (NSMutableDictionary *) submission;
- (void) getFormFiles : (long long) formID;
- (void) getFormWebhooks : (long long) formID;
- (void) createFormWebhooks : (long long) formID hookUrl : (NSString *) webhookURL;
- (void) getSubmission : (long long) sid;
- (void) getReport : (long long) reportID;
- (void) getFolder : (long long) folderID;
- (void) getFormProperties : (long long) formID;
- (void) getFormProperty : (long long) formID propertyKey : (NSString *) propertyKey;

@end
