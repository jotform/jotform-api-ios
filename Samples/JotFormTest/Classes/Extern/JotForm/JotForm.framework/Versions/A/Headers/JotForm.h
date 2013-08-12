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

@protocol JotFormDelegate <NSObject>

@end

@interface JotForm : NSObject<ASIHTTPRequestDelegate>
{
    NSString                *apiKey;
    NSString                *baseUrl;
    NSString                *apiVersion;
    
    BOOL                    debugMode;
    
    SEL                     didFinishSelector;
	SEL                     didFailSelector;
    
	id <JotFormDelegate>    delegate;
}

@property (nonatomic, retain) NSOperationQueue      *operationQueue;

@property (assign) SEL                              didFinishSelector;
@property (assign) SEL                              didFailSelector;

@property (nonatomic, assign) id<JotFormDelegate>   delegate;


- (void) getApiKey : (NSString *) username password : (NSString *) password;
- (id) initWithApiKey : (NSString *) apikey debugMode : (BOOL) debugmode;
- (void) getUser;
- (void) getUsage;
- (void) getForms;
- (void) getForms : (NSInteger) offset limit : (NSInteger) limit orderBy : (NSString *) orderBy filter : (NSMutableDictionary *) filter;
- (void) getSubmissions;
- (void) getSubmissions : (NSInteger) offset limit : (NSInteger) limit orderBy : (NSString *) orderBy filter : (NSMutableDictionary *) filter;
- (void) getSubusers;
- (void) getFolders;
- (void) getReports;
- (void) getSettings;
- (void) getHistory;
- (void) getForm : (long long) formID;
- (void) createForm : (NSString *) form;
- (void) deleteForm : (long long) formID;
- (void) getFormQuestions : (long long) formID;
- (void) getFormQuestion : (long long) formID questionID : (long long) qid;
- (void) createFormQuestion : (long long) formID question : (NSMutableDictionary *) question;
- (void) editFormQuestion : (long long) formID questionID : (long long) qid questionProperties : (NSMutableDictionary *) properties;
- (void) deleteFormQuestion : (long long) formID questionID : (long long) qid;
- (void) getFormProperties : (long long) formID;
- (void) setFormProperties : (long long) formID formProperties : (NSMutableDictionary *) properties;
- (void) setMultipleFormProperties : (long long) formID formProperties : (NSString *) properties;
- (void) getFormProperty : (long long) formID propertyKey : (NSString *) propertyKey;
- (void) getFormSubmissions : (long long) formID;
- (void) getFormSubmissions : (long long) formID offset : (NSInteger) offset limit : (NSInteger) limit orderBy : (NSString *) orderBy filter : (NSMutableDictionary *) filter;
- (void) createFormSubmissions : (long long) formID submission : (NSMutableDictionary *) submission;
- (void) getFormFiles : (long long) formID;
- (void) getFormWebhooks : (long long) formID;
- (void) createFormWebhooks : (long long) formID hookUrl : (NSString *) webhookURL;
- (void) getSubmission : (long long) sid;
- (void) editSubmission : (long long) sid name : (NSString *) submissionName new : (NSInteger) new flag : (NSInteger) flag;
- (void) deleteSubmission : (long long) sid;
- (void) getReport : (long long) reportID;
- (void) getFolder : (long long) folderID;

@end
