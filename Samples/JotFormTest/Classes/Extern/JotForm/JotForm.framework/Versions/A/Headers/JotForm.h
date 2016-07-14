//
//  JotForm.h
//  JotForm
//
//  Created by Wang YuPing on 7/9/13.
//  Copyright 2013 Interlogy, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"

@interface JotForm : NSObject

- (id)initWithApiKey:(NSString *)apikey debugMode:(BOOL)debugmode euApi:(BOOL)euApi;

/**
 * Login user with given credentials
 * @param userinfo Username, password, application name and access type of user
 * @return Returns logged in user's settings and app key
 */

- (void)login:(NSMutableDictionary *)userinfo
    onSuccess:(void (^)(id))successBlock
    onFailure:(void (^)(NSError *))failureBlock;

/**
 * Register with username, password and email
 * @param userinfo Username, password and email to register a new user
 * @return Returns new user's details
 */

- (void)registerUser:(NSMutableDictionary *)userinfo
           onSuccess:(void (^)(id))successBlock
           onFailure:(void (^)(NSError *))failureBlock;

/**
 * Get user account details for a JotForm user.
 * @return Returns user account type, avatar URL, name, email, website URL and
 * account limits.
 */
- (void)getUser:(void (^)(id))successBlock
               onFailure:(void (^)(NSError *))failureBlock;

/**
 * Get number of form submissions received this month.
 * @return Returns number of submissions, number of SSL form submissions,
 * payment form submissions and upload space used by user.
 */
- (void)getUsage:(void (^)(id))successBlock
       onFailure:(void (^)(NSError *))failureBlock;

/**
 * Get a list of forms for this account
 * @return Returns basic details such as title of the form, when it was created,
 * number of new and total submissions.
 */
- (void)getForms:(void (^)(id))successBlock
       onFailure:(void (^)(NSError *))failureBlock;

/**
 * Get a list of forms for this account
 * @param offset Start of each result set for form list.
 * @param limit Number of results in each result set for form list.
 * @param filter Filters the query results to fetch a specific form range.
 * @param orderBy Order results by a form field name.
 * @return Returns basic details such as title of the form, when it was created,
 * number of new and total submissions.
 */
- (void)getForms:(NSInteger)offset
           limit:(NSInteger)limit
           orderBy:(NSString *)orderBy
          filter:(NSMutableDictionary *)filter
         onSuccess:(void (^)(id))successBlock
         onFailure:(void (^)(NSError *))failureBlock;

/**
 * Get a list of submissions for this account.
 * @return Returns basic details such as title of the form, when it was created,
 * number of new and total submissions.
 */
- (void)getSubmissions:(void (^)(id))successBlock
                      onFailure:(void (^)(NSError *))failureBlock;

/**
 * Get a list of submissions for this account.
 * @param offset Start of each result set for form list.
 * @param limit Number of results in each result set for form list.
 * @param filter Filters the query results to fetch a specific form range.
 * @param orderBy Order results by a form field name.
 * @return Returns basic details such as title of the form, when it was created,
 * number of new and total submissions.
 */
- (void)getSubmissions:(NSInteger)offset
                 limit:(NSInteger)limit
               orderBy:(NSString *)orderBy
                filter:(NSMutableDictionary *)filter
             onSuccess:(void (^)(id))successBlock
             onFailure:(void (^)(NSError *))failureBlock;

/**
 * Get a list of sub users for this account.
 * @return Returns list of forms and form folders with access privileges.
 */
- (void)getSubusers:(void (^)(id))successBlock
                   onFailure:(void (^)(NSError *))failureBlock;

/**
 * Get a list of form folders for this account.
 * @return Returns name of the folder and owner of the folder for shared
 * folders.
 */
- (void)getFolders:(void (^)(id))successBlock
                  onFailure:(void (^)(NSError *))failureBlock;

/**
 * Get folder details
 * @param folderId You can get a list of folders from /user/folders.
 * @return Returns a list of forms in a folder, and other details about the form
 * such as folder color.
 */
- (void)getFolder:(long long)folderId
        onSuccess:(void (^)(id))successBlock
        onFailure:(void (^)(NSError *))failureBlock;

/**
 * List of URLS for reports in this account.
 * @return Returns reports for all of the forms. ie. Excel, CSV, printable
 * charts, embeddable HTML tables.
 */
- (void)getReports:(void (^)(id))successBlock
                  onFailure:(void (^)(NSError *))failureBlock;

/**
 * Get user's settings for this account.
 * @return Returns user's time zone and language.
 */
- (void)getSettings:(void (^)(id))successBlock
                   onFailure:(void (^)(NSError *))failureBlock;

/**
 * Update user's settings
 * @param settings New user setting values with setting keys
 * @return Return changes on user settings
 */

- (void)updateSettings:(NSMutableDictionary *)settings
             onSuccess:(void (^)(id))successBlock
             onFailure:(void (^)(NSError *))failureBlock;

/**
 * Get user activity log.
 * @return Returns activity log about things like forms
 * created/modified/deleted, account logins and other operations.
 */
- (void)getHistory:(void (^)(id))successBlock
                  onFailure:(void (^)(NSError *))failureBlock;

/**
 * Get user activity log.
 * @param action Filter results by activity performed. Default is 'all'.
 * @param date Limit results by a date range. If you'd like to limit results by
 * specific dates you can use startDate and endDate fields instead.
 * @param sortBy Lists results by ascending and descending order.
 * @param startDate Limit results to only after a specific date. Format:
 * MM/DD/YYYY.
 * @param endDate Limit results to only before a specific date. Format:
 * MM/DD/YYYY.
 * @return Returns activity log about things like forms
 * created/modified/deleted, account logins and other operations.
 */
- (void)getHistory:(NSString *)action
              date:(NSString *)date
            sortBy:(NSString *)sortBy
         startDate:(NSString *)startDate
           endDate:(NSString *)endDate
           sortWay:(NSString *)sortWay
         onSuccess:(void (^)(id))successBlock
         onFailure:(void (^)(NSError *))failureBlock;

/**
 * Get basic information about a form.
 * @param formID Form ID is the numbers you see on a form URL. You can get form
 * IDs when you call /user/forms.
 * @return Returns form ID, status, update and creation dates, submission count
 * etc.
 */
- (void)getForm:(long long)formID
      onSuccess:(void (^)(id))successBlock
      onFailure:(void (^)(NSError *))failureBlock;

/**
 * Get a list of all questions on a form.
 * @param formID Form ID is the numbers you see on a form URL. You can get form
 * IDs when you call /user/forms.
 * @return Returns question properties of a form.
 */
- (void)getFormQuestions:(long long)formID
               onSuccess:(void (^)(id))successBlock
               onFailure:(void (^)(NSError *))failureBlock;

/**
 * Check wether or not the form is encrypted
 * @param formID Form ID is the numbers you see on a form URL. You can get form
 * IDs when you call /user/forms.
 * @return Returns Yes or No.
 */
- (void)getFormEncrypted:(long long)formID
               onSuccess:(void (^)(id))successBlock
               onFailure:(void (^)(NSError *))failureBlock;

/**
 * Get details about a question
 * @param formID Form ID is the numbers you see on a form URL. You can get form
 * IDs when you call /user/forms.
 * @param qid Identifier for each question on a form. You can get a list of
 * question IDs from /form/{id}/questions.
 * @return Returns question properties like required and validation.
 */
- (void)getFormQuestion:(long long)formID questionID:(long long)qid
              onSuccess:(void (^)(id))successBlock
              onFailure:(void (^)(NSError *))failureBlock;

/**
 * List of a form submissions.
 * @param formID Form ID is the numbers you see on a form URL. You can get form
 * IDs when you call /user/forms.
 * @return Returns submissions of a specific form.
 */
- (void)getFormSubmissions:(long long)formID
                 onSuccess:(void (^)(id))successBlock
                 onFailure:(void (^)(NSError *))failureBlock;

/**
 * List of a form submissions.
 * @param formID Form ID is the numbers you see on a form URL. You can get form
 * IDs when you call /user/forms.
 * @param offset Start of each result set for form list.
 * @param limit Number of results in each result set for form list.
 * @param filter Filters the query results to fetch a specific form range.
 * @param orderBy Order results by a form field name.
 * @return Returns submissions of a specific form.
 */
- (void)getFormSubmissions:(long long)formID
                    offset:(NSInteger)offset
                     limit:(NSInteger)limit
                   orderBy:(NSString *)orderBy
                    filter:(NSMutableDictionary *)filter
                 onSuccess:(void (^)(id))successBlock
                 onFailure:(void (^)(NSError *))failureBlock;

/**
 * @param formID Form ID is the numbers you see on a form URL. You can get form
 * IDs when you call /user/forms.
 */
- (void)getFormReports:(long long)formID
             onSuccess:(void (^)(id))successBlock
             onFailure:(void (^)(NSError *))failureBlock;

/**
 * Submit data to this form using the API.
 * @param formID Form ID is the numbers you see on a form URL. You can get form
 * IDs when you call /user/forms.
 * @param submission Submission data with question IDs.
 * @return Returns posted submission ID and URL.
 */
- (void)createFormSubmissions:(long long)formID
                   submission:(NSMutableDictionary *)submission
                    onSuccess:(void (^)(id))successBlock
                    onFailure:(void (^)(NSError *))failureBlock;

/**
 * List of files uploaded on a form.
 * @param formID Form ID is the numbers you see on a form URL. You can get form
 * IDs when you call /user/forms.
 * @return Returns uploaded file information and URLs on a specific form.
 */
- (void)getFormFiles:(long long)formID
           onSuccess:(void (^)(id))successBlock
           onFailure:(void (^)(NSError *))failureBlock;

/**
 * Get list of webhooks for a form
 * @param formID Form ID is the numbers you see on a form URL. You can get form
 * IDs when you call /user/forms.
 * @return Returns list of webhooks for a specific form.
 */
- (void)getFormWebhooks:(long long)formID
              onSuccess:(void (^)(id))successBlock
              onFailure:(void (^)(NSError *))failureBlock;

/**
 * Add a new webhook
 * @param formID Form ID is the numbers you see on a form URL. You can get form
 * IDs when you call /user/forms.
 * @param webhookURL Webhook URL is where form data will be posted when form is
 * submitted.
 * @return Returns list of webhooks for a specific form.
 */
- (void)createFormWebhooks:(long long)formID hookUrl:(NSString *)webhookURL
                 onSuccess:(void (^)(id))successBlock
                 onFailure:(void (^)(NSError *))failureBlock;

/**
* Delete a specific webhook of a form.
* @param formID Form ID is the numbers you see on a form URL. You can get form
* IDs when you call /user/forms.
* @param webhookID You can get webhook IDs when you call
* /form/{formID}/webhooks.
* @return Returns remaining webhook URLs of form.
*/
- (void)deleteWebhook:(long long)formID webhookId:(long long)webhookID
            onSuccess:(void (^)(id))successBlock
            onFailure:(void (^)(NSError *))failureBlock;

/**
 * Get submission data
 * @param sid You can get submission IDs when you call /form/{id}/submissions.
 * @return Returns information and answers of a specific submission.
 */
- (void)getSubmission:(long long)sid
            onSuccess:(void (^)(id))successBlock
            onFailure:(void (^)(NSError *))failureBlock;

/**
 * Get report details
 * @param reportID You can get a list of reports from /user/reports.
 * @return Returns properties of a specific report like fields and status.
 */
- (void)getReport:(long long)reportID
        onSuccess:(void (^)(id))successBlock
        onFailure:(void (^)(NSError *))failureBlock;

/**
 * Get report details
 * @param reportID You can Delete an existing report.
 * @return Deletes the existing report.
 */
- (void)deleteReport:(long long)reportID
           onSuccess:(void (^)(id))successBlock
           onFailure:(void (^)(NSError *))failureBlock;

/**

 * Create new report of a form with intended fields, type and title.
 * @param formID Form ID is the numbers you see on a form URL. You can get form
 IDs when you call /user/forms.
 * @title title is report title.
 * @list_type You can specify report type. 'csv', 'excel', 'grid', 'table',
 'rss'
 * @fields you can specify fields, User IP, submission date(dt) and question IDs
 * @return Report details and URL.
 */
- (void)createReport:(long long)formID
               title:(NSString *)title
           list_type:(NSString *)list_type
              fields:(NSString *)fields
           onSuccess:(void (^)(id))successBlock
           onFailure:(void (^)(NSError *))failureBlock;

/**
 * Get a list of all properties on a form.
 * @param formID Form ID is the numbers you see on a form URL. You can get form
 * IDs when you call /user/forms.
 * @return Returns form properties like width, expiration date, style etc.
 */
- (void)getFormProperties:(long long)formID
                onSuccess:(void (^)(id))successBlock
                onFailure:(void (^)(NSError *))failureBlock;

/**
 * Get a specific property of the form.
 * @param formID Form ID is the numbers you see on a form URL. You can get form
 * IDs when you call /user/forms.
 * @param propertyKey You can get property keys when you call
 * /form/{id}/properties.
 * @return Returns given property key value.
 */
- (void)getFormProperty:(long long)formID propertyKey:(NSString *)propertyKey
              onSuccess:(void (^)(id))successBlock
              onFailure:(void (^)(NSError *))failureBlock;

/**
 * Delete a single submission.
 * @param sid You can get submission IDs when you call /user/submissions.
 * @return Returns status of request.
 */
- (void)deleteSubmission:(long long)sid
               onSuccess:(void (^)(id))successBlock
               onFailure:(void (^)(NSError *))failureBlock;

/**
 * Edit a single submission.
 * @param sid You can get submission IDs when you call /form/{id}/submissions.
 * @param submission New submission data with question IDs.
 * @return Returns status of request.
 */
- (void)editSubmission:(long long)sid
                  name:(NSString *)submissionName
                   new:(NSInteger) new
                  flag:(NSInteger)flag
                 onSuccess:(void (^)(id))successBlock
                  onFailure:(void (^)(NSError *))failureBlock;

/**
 * Clone a single form.
 * @param formID Form ID is the numbers you see on a form URL. You can get form
 * IDs when you call /user/forms.
 * @return Returns status of request.
 */
- (void)cloneForm:(long long)formID
        onSuccess:(void (^)(id))successBlock
        onFailure:(void (^)(NSError *))failureBlock;

/**
 * Delete a single form question.
 * @param formID Form ID is the numbers you see on a form URL. You can get form
 * IDs when you call /user/forms.
 * @param qid Identifier for each question on a form. You can get a list of
 * question IDs from /form/{id}/questions.
 * @return Returns status of request.
 */
- (void)deleteFormQuestion:(long long)formID questionID:(long long)qid
                 onSuccess:(void (^)(id))successBlock
                 onFailure:(void (^)(NSError *))failureBlock;

/**
 * Add new question to specified form.
 * @param formID Form ID is the numbers you see on a form URL. You can get form
 * IDs when you call /user/forms.
 * @param question New question properties like type and text.
 * @return Returns properties of new question.
 */
- (void)createFormQuestion:(long long)formID
                  question:(NSMutableDictionary *)question
                 onSuccess:(void (^)(id))successBlock
                 onFailure:(void (^)(NSError *))failureBlock;

/**
 *  Add new questions to specified form.
 * @param formID Form ID is the numbers you see on a form URL. You can get form
 * IDs when you call /user/forms.
 * @param questions New question properties like type and text.
 * @return Returns properties of new questions.
 */
- (void)createFormQuestions:(long long)formID questions:(NSString *)questions
                  onSuccess:(void (^)(id))successBlock
                  onFailure:(void (^)(NSError *))failureBlock;

/**
 * Edit a single question properties.
 * @param formID Form ID is the numbers you see on a form URL. You can get form
 * IDs when you call /user/forms.
 * @param qid Identifier for each question on a form. You can get a list of
 * question IDs from /form/{id}/questions.
 * @param questionProperties New question properties like text and order.
 * @return Returns edited property and type of question.
 */
- (void)editFormQuestion:(long long)formID
              questionID:(long long)qid
      questionProperties:(NSMutableDictionary *)properties
               onSuccess:(void (^)(id))successBlock
               onFailure:(void (^)(NSError *))failureBlock;

/**
 * Add or edit properties of a specific form
 * @param formID Form ID is the numbers you see on a form URL. You can get form
 * IDs when you call /user/forms.
 * @param formProperties New properties like label width.
 * @return Returns edited properties.
 */
- (void)setFormProperties:(long long)formID
           formProperties:(NSMutableDictionary *)properties
                onSuccess:(void (^)(id))successBlock
                onFailure:(void (^)(NSError *))failureBlock;

/**
* @return Returns wether or not a account is running on a EU server.
*/

- (void)checkEUserver:(void (^)(id))successBlock
                     onFailure:(void (^)(NSError *))failureBlock;

/**
 * Add or edit properties of a specific form
 * @param formID Form ID is the numbers you see on a form URL. You can get form
 * IDs when you call /user/forms.
 * @param formProperties New properties like label width.
 * @return Returns edited properties.
 */
- (void)setMultipleFormProperties:(long long)formID
                   formProperties:(NSString *)properties
                        onSuccess:(void (^)(id))successBlock
                        onFailure:(void (^)(NSError *))failureBlock;

/**
 * Create a new form
 * @param form Questions, properties and emails of new form.
 * @return Returns new form.
 */
- (void)createForm:(NSMutableDictionary *)form
         onSuccess:(void (^)(id))successBlock
         onFailure:(void (^)(NSError *))failureBlock;

/**
 * Create a new form
 * @param form Questions, properties and emails of new form.
 * @return Returns new form.
 */
- (void)createForms:(NSString *)form
          onSuccess:(void (^)(id))successBlock
          onFailure:(void (^)(NSError *))failureBlock;

/**
 * Delete a single form
 * @param formID Form ID is the numbers you see on a form URL. You can get form
 * IDs when you call /user/forms.
 * @return Properties of deleted form.
 */
- (void)deleteForm:(long long)formID
         onSuccess:(void (^)(id))successBlock
         onFailure:(void (^)(NSError *))failureBlock;

- (void)deleteSubmissionSynchronous:(long long)formID
                        onSuccess:(void (^)(id))successBlock
                        onFailure:(void (^)(NSError *))failureBlock;

/**
* Get details of a plan
* @param plan is the name of the requested plan. FREE, PREMIUM etc.
* @return Get details regarding systems plan
*/
- (void)getSystemPlan:(NSString *)plan
            onSuccess:(void (^)(id))successBlock
            onFailure:(void (^)(NSError *))failureBlock;

/**
 * Sends out a report to Jotform.
 */

- (void)createReport:(long long)formID reportParams:(NSMutableDictionary *)reportParams
           onSuccess:(void (^)(id))successBlock
           onFailure:(void (^)(NSError *))failureBlock;

/**
 * Sends out a suggestion to Jotform.
 */

- (void)createSuggestion:(long long)formID suggestionParams:(NSMutableDictionary *)suggestionParams
               onSuccess:(void (^)(id))successBlock
               onFailure:(void (^)(NSError *))failureBlock;

@end
