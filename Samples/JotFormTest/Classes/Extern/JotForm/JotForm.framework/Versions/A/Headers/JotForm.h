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

/**
 * Get user account details for a JotForm user.
 * @return Returns user account type, avatar URL, name, email, website URL and account limits.
 */
- (void) getUser;

/**
 * Get number of form submissions received this month.
 * @return Returns number of submissions, number of SSL form submissions, payment form submissions and upload space used by user.
 */
- (void) getUsage;

/**
 * Get a list of forms for this account
 * @return Returns basic details such as title of the form, when it was created, number of new and total submissions.
 */
- (void) getForms;

/**
 * Get a list of forms for this account
 * @param offset Start of each result set for form list.
 * @param limit Number of results in each result set for form list.
 * @param filter Filters the query results to fetch a specific form range.
 * @param orderBy Order results by a form field name.
 * @return Returns basic details such as title of the form, when it was created, number of new and total submissions.
 */
- (void) getForms : (NSInteger) offset limit : (NSInteger) limit orderBy : (NSString *) orderBy filter : (NSMutableDictionary *) filter;

/**
 * Get a list of submissions for this account.
 * @return Returns basic details such as title of the form, when it was created, number of new and total submissions.
 */
- (void) getSubmissions;

/**
 * Get a list of submissions for this account.
 * @param offset Start of each result set for form list.
 * @param limit Number of results in each result set for form list.
 * @param filter Filters the query results to fetch a specific form range.
 * @param orderBy Order results by a form field name.
 * @return Returns basic details such as title of the form, when it was created, number of new and total submissions.
 */
- (void) getSubmissions : (NSInteger) offset limit : (NSInteger) limit orderBy : (NSString *) orderBy filter : (NSMutableDictionary *) filter;

/**
 * Get a list of sub users for this account.
 * @return Returns list of forms and form folders with access privileges.
 */
- (void) getSubusers;

/**
 * Get a list of form folders for this account.
 * @return Returns name of the folder and owner of the folder for shared folders.
 */
- (void) getFolders;

/**
 * List of URLS for reports in this account.
 * @return Returns reports for all of the forms. ie. Excel, CSV, printable charts, embeddable HTML tables.
 */
- (void) getReports;

/**
 * Get user's settings for this account.
 * @return Returns user's time zone and language.
 */
- (void) getSettings;

/**
 * Get user activity log.
 * @return Returns activity log about things like forms created/modified/deleted, account logins and other operations.
 */
- (void) getHistory;

/**
 * Get user activity log.
 * @param action Filter results by activity performed. Default is 'all'.
 * @param date Limit results by a date range. If you'd like to limit results by specific dates you can use startDate and endDate fields instead.
 * @param sortBy Lists results by ascending and descending order.
 * @param startDate Limit results to only after a specific date. Format: MM/DD/YYYY.
 * @param endDate Limit results to only before a specific date. Format: MM/DD/YYYY.
 * @return Returns activity log about things like forms created/modified/deleted, account logins and other operations.
 */
- (void) getHistory : (NSString *) action date : (NSString *) date sortBy : (NSString *) sortBy startDate : (NSString *) startDate endDate : (NSString *) endDate;

/**
 * Get basic information about a form.
 * @param formID Form ID is the numbers you see on a form URL. You can get form IDs when you call /user/forms.
 * @return Returns form ID, status, update and creation dates, submission count etc.
 */
- (void) getForm : (long long) formID;

/**
 * Get a list of all questions on a form.
 * @param formID Form ID is the numbers you see on a form URL. You can get form IDs when you call /user/forms.
 * @return Returns question properties of a form.
 */
- (void) getFormQuestions : (long long) formID;

/**
 * Get details about a question
 * @param formID Form ID is the numbers you see on a form URL. You can get form IDs when you call /user/forms.
 * @param qid Identifier for each question on a form. You can get a list of question IDs from /form/{id}/questions.
 * @return Returns question properties like required and validation.
 */
- (void) getFormQuestion : (long long) formID questionID : (long long) qid;

/**
 * List of a form submissions.
 * @param formID Form ID is the numbers you see on a form URL. You can get form IDs when you call /user/forms.
 * @return Returns submissions of a specific form.
 */
- (void) getFormSubmissions : (long long) formID;

/**
 * List of a form submissions.
 * @param formID Form ID is the numbers you see on a form URL. You can get form IDs when you call /user/forms.
 * @param offset Start of each result set for form list.
 * @param limit Number of results in each result set for form list.
 * @param filter Filters the query results to fetch a specific form range.
 * @param orderBy Order results by a form field name.
 * @return Returns submissions of a specific form.
 */
- (void) getFormSubmissions : (long long) formID offset : (NSInteger) offset limit : (NSInteger) limit orderBy : (NSString *) orderBy filter : (NSMutableDictionary *) filter;

/**
 * Submit data to this form using the API.
 * @param formID Form ID is the numbers you see on a form URL. You can get form IDs when you call /user/forms.
 * @param submission Submission data with question IDs.
 * @return Returns posted submission ID and URL.
 */
- (void) createFormSubmissions : (long long) formID submission : (NSMutableDictionary *) submission;

/**
 * List of files uploaded on a form.
 * @param formID Form ID is the numbers you see on a form URL. You can get form IDs when you call /user/forms.
 * @return Returns uploaded file information and URLs on a specific form.
 */
- (void) getFormFiles : (long long) formID;

/**
 * Get list of webhooks for a form
 * @param formID Form ID is the numbers you see on a form URL. You can get form IDs when you call /user/forms.
 * @return Returns list of webhooks for a specific form.
 */
- (void) getFormWebhooks : (long long) formID;

/**
 * Add a new webhook
 * @param formID Form ID is the numbers you see on a form URL. You can get form IDs when you call /user/forms.
 * @param webhookURL Webhook URL is where form data will be posted when form is submitted.
 * @return Returns list of webhooks for a specific form.
 */
- (void) createFormWebhooks : (long long) formID hookUrl : (NSString *) webhookURL;

/**
 * Get submission data
 * @param sid You can get submission IDs when you call /form/{id}/submissions.
 * @return Returns information and answers of a specific submission.
 */
- (void) getSubmission : (long long) sid;

/**
 * Get report details
 * @param reportID You can get a list of reports from /user/reports.
 * @return Returns properties of a specific report like fields and status.
 */
- (void) getReport : (long long) reportID;

/**
 * Get a list of all properties on a form.
 * @param formID Form ID is the numbers you see on a form URL. You can get form IDs when you call /user/forms.
 * @return Returns form properties like width, expiration date, style etc.
 */
- (void) getFormProperties : (long long) formID;

/**
 * Get a specific property of the form.
 * @param formID Form ID is the numbers you see on a form URL. You can get form IDs when you call /user/forms.
 * @param propertyKey You can get property keys when you call /form/{id}/properties.
 * @return Returns given property key value.
 */
- (void) getFormProperty : (long long) formID propertyKey : (NSString *) propertyKey;

/**
 * Delete a single submission.
 * @param sid You can get submission IDs when you call /user/submissions.
 * @return Returns status of request.
 */
- (void) deleteSubmission : (long long) sid;

/**
 * Edit a single submission.
 * @param sid You can get submission IDs when you call /form/{id}/submissions.
 * @param submission New submission data with question IDs.
 * @return Returns status of request.
 */
- (void) editSubmission : (long long) sid name : (NSString *) submissionName new : (NSInteger) new flag : (NSInteger) flag;

/**
 * Clone a single form.
 * @param formID Form ID is the numbers you see on a form URL. You can get form IDs when you call /user/forms.
 * @return Returns status of request.
 */
- (void) cloneForm : (long long) formID;

/**
 * Delete a single form question.
 * @param formID Form ID is the numbers you see on a form URL. You can get form IDs when you call /user/forms.
 * @param qid Identifier for each question on a form. You can get a list of question IDs from /form/{id}/questions.
 * @return Returns status of request.
 */
- (void) deleteFormQuestion : (long long) formID questionID : (long long) qid;

/**
 * Add new question to specified form.
 * @param formID Form ID is the numbers you see on a form URL. You can get form IDs when you call /user/forms.
 * @param question New question properties like type and text.
 * @return Returns properties of new question.
 */
- (void) createFormQuestion : (long long) formID question : (NSMutableDictionary *) question;

/**
 *  Add new questions to specified form.
 * @param formID Form ID is the numbers you see on a form URL. You can get form IDs when you call /user/forms.
 * @param questions New question properties like type and text.
 * @return Returns properties of new questions.
 */
- (void) createFormQuestions : (long long) formID questions : (NSString *) questions;

/**
 * Edit a single question properties.
 * @param formID Form ID is the numbers you see on a form URL. You can get form IDs when you call /user/forms.
 * @param qid Identifier for each question on a form. You can get a list of question IDs from /form/{id}/questions.
 * @param questionProperties New question properties like text and order.
 * @return Returns edited property and type of question.
 */
- (void) editFormQuestion : (long long) formID questionID : (long long) qid questionProperties : (NSMutableDictionary *) properties;

/**
 * Add or edit properties of a specific form
 * @param formID Form ID is the numbers you see on a form URL. You can get form IDs when you call /user/forms.
 * @param formProperties New properties like label width.
 * @return Returns edited properties.
 */
- (void) setFormProperties : (long long) formID formProperties : (NSMutableDictionary *) properties;

/**
 * Add or edit properties of a specific form
 * @param formID Form ID is the numbers you see on a form URL. You can get form IDs when you call /user/forms.
 * @param formProperties New properties like label width.
 * @return Returns edited properties.
 */
- (void) setMultipleFormProperties : (long long) formID formProperties : (NSString *) properties;

/**
 * Create a new form
 * @param form Questions, properties and emails of new form.
 * @return Returns new form.
 */
- (void) createForm : (NSString *) form;

/**
 * Delete a single form
 * @param formID Form ID is the numbers you see on a form URL. You can get form IDs when you call /user/forms.
 * @return Properties of deleted form.
 */
- (void) deleteForm : (long long) formID;

@end
