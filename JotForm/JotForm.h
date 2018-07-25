//
//  JotForm.h
//  JotForm
//
//  Created by Wang YuPing on 7/9/13.
//  Copyright 2013 Interlogy, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JotForm : NSObject

typedef NS_ENUM(NSInteger, BaseUrlType) {
    USBaseUrl,
    EUBaseUrl,
    HIPAABaseUrl
};

@property (nonatomic, copy) NSString *baseUrl;

- (instancetype)initWithApiKey:(NSString *)apikey debugMode:(BOOL)debugmode baseUrlType:(BaseUrlType)baseUrlType;


/**
 * Login user with given credentials.
 * @param userinfo username, password, application name and access type of user
 * Return logged in user's settings and the appkey.
 */

- (void)login:(NSDictionary *)userinfo
    onSuccess:(void (^)(id))successBlock
    onFailure:(void (^)(NSError *))failureBlock;

/**
 * Returns whether or not an account is EU account.
 * @param apiKey is the account's api key.
 */

- (void)isAccountEU:(NSString *)apiKey
          onSuccess:(void (^)(id))successBlock
          onFailure:(void (^)(NSError *))failureBlock;


/**
 * Returns an account's settings.
 */

- (void)getAccountSettings:(void (^)(id))successBlock
                 onFailure:(void (^)(NSError *))failureBlock;

/**
 * Register with username, password and email.
 * @param userinfo needs username, password and email to register a new user
 * Create a new user.
 */

- (void)registerUser:(NSDictionary *)userinfo
           onSuccess:(void (^)(id))successBlock
           onFailure:(void (^)(NSError *))failureBlock;

/**
 * Get user's account details for this JotForm user.
 * Return user account type, avatar URL, name, email, website URL and account limits.
 */

- (void)getUser:(void (^)(id))successBlock
      onFailure:(void (^)(NSError *))failureBlock;

/**
 * Get Monthly User Usage.
 * Return number of form submissions received this month. Also, get number of SSL form submissions,
 * payment form submissions and upload space used by user.
 */

- (void)getUsage:(void (^)(id))successBlock
       onFailure:(void (^)(NSError *))failureBlock;

/**
 * Get User Forms.
 * Return a list of forms for this account. Includes basic details such as title of the form,
 * when it was created, number of new and total submissions.
 */

- (void)getForms:(void (^)(id))successBlock
       onFailure:(void (^)(NSError *))failureBlock;

/**
 * Get User Forms.
 * Get a list of forms for this account.
 * @param offset start of each result set for form list.
 * @param limit number of results in each result set for form list.
 * @param filter filters the query results to fetch a specific form range.
 * @param orderBy order results by a form field name.
 * Return a list of forms for this account. Includes basic details such as title of the form,
 * when it was created, number of new and total submissions.
 */

- (void)getForms:(NSInteger)offset
           limit:(NSInteger)limit
         orderBy:(NSString *)orderBy
          filter:(NSDictionary *)filter
       onSuccess:(void (^)(id))successBlock
       onFailure:(void (^)(NSError *))failureBlock;

/**
 * Get User Submissions.
 * Return a list of all submissions for all forms on this account.
 * The answers array has the submission data. Created_at is the date of the submission.
 */

- (void)getSubmissions:(void (^)(id))successBlock
             onFailure:(void (^)(NSError *))failureBlock;

/**
 * Get User Submissions.
 * @param offset Start of each result set for form list.
 * @param limit Number of results in each result set for form list.
 * @param filter Filters the query results to fetch a specific form range.
 * @param orderBy Order results by a form field name.
 * Return a list of all submissions for all forms on this account.
 * The answers array has the submission data. Created_at is the date of the submission.
 */

- (void)getSubmissions:(NSInteger)offset
                 limit:(NSInteger)limit
               orderBy:(NSString *)orderBy
                filter:(NSDictionary *)filter
             onSuccess:(void (^)(id))successBlock
             onFailure:(void (^)(NSError *))failureBlock;

/**
 * Get Sub-User Account List.
 * Return a list of sub users for this accounts and list of forms
 * and form folders with access privileges.
 */

- (void)getSubusers:(void (^)(id))successBlock
          onFailure:(void (^)(NSError *))failureBlock;

/**
 * Get User Folders.
 * Return a list of form folders for this account. Returns name of the folder and owner of
 * the folder for shared folders.
 */

- (void)getFolders:(void (^)(id))successBlock
         onFailure:(void (^)(NSError *))failureBlock;

/**
 * Get Folder Details.
 * Return a list of forms in a folder, and other details.
 * about the form such as folder color.
 */

- (void)getFolder:(long long)folderID
        onSuccess:(void (^)(id))successBlock
        onFailure:(void (^)(NSError *))failureBlock;

/**
 * Get User Reports.
 * Return list of URLS for reports in this account. Includes reports for all of the forms.
 * ie. Excel, CSV, printable charts, embeddable HTML tables.
 */

- (void)getReports:(void (^)(id))successBlock
         onFailure:(void (^)(NSError *))failureBlock;

/**
 * Get User Settings.
 * Return user's time zone and language.
 */

- (void)getSettings:(void (^)(id))successBlock
          onFailure:(void (^)(NSError *))failureBlock;

/**
 * Update User Settings.
 * @param settings New user setting values with setting keys.
 * Update user's settings like time zone and language.
 */

- (void)updateSettings:(NSDictionary *)settings
             onSuccess:(void (^)(id))successBlock
             onFailure:(void (^)(NSError *))failureBlock;

/**
 * Get History.
 * Return User activity log about things like forms created/modified/deleted,
 * account logins and other operations.
 */

- (void)getHistory:(void (^)(id))successBlock
         onFailure:(void (^)(NSError *))failureBlock;

/**
 * Get History.
 * @param action Filter results by activity performed. Default is 'all'.
 * @param date Limit results by a date range. If you'd like to limit results by
 * specific dates you can use startDate and endDate fields instead.
 * @param sortBy Lists results by ascending and descending order.
 * @param startDate Limit results to only after a specific date. Format:
 * MM/DD/YYYY.
 * @param endDate Limit results to only before a specific date. Format:
 * MM/DD/YYYY.
 * Return user activity log about things like forms created/modified/deleted,
 * account logins and other operations.
 */

- (void)getHistory:(NSString *)action
              date:(NSString *)date
            sortBy:(NSString *)sortBy
         startDate:(NSString *)startDate
           endDate:(NSString *)endDate
         onSuccess:(void (^)(id))successBlock
         onFailure:(void (^)(NSError *))failureBlock;

/**
 * Get Form Details.
 * @param formID is the number you see on a form URL. You can get formIDs when you call /user/forms.
 * Return basic information about a form. Use /form/{id}/questions to get the list of questions.
 */

- (void)getForm:(long long)formID
      onSuccess:(void (^)(id))successBlock
      onFailure:(void (^)(NSError *))failureBlock;

/**
 * Get Form Questions.
 * @param formID is the number you see on a form URL. You can get formIDs when you call /user/forms.
 * Return question properties of a form.
 */

- (void)getFormQuestions:(long long)formID
               onSuccess:(void (^)(id))successBlock
               onFailure:(void (^)(NSError *))failureBlock;

/**
 * Get details about a question.
 * @param formID is the number you see on a form URL. You can get formIDs when you call /user/forms.
 * @param qid Identifier for each question on a form. You can get a list of
 * question IDs from /form/{id}/questions.
 * Return question properties of a form.
 */

- (void)getFormQuestion:(long long)formID questionID:(long long)qid
              onSuccess:(void (^)(id))successBlock
              onFailure:(void (^)(NSError *))failureBlock;

/**
 * Get Form Submissions.
 * @param formID is the number you see on a form URL. You can get formIDs when you call /user/forms.
 * Return List of form reponses. Fields array has the submitted data.
 * Created_at is the date of the submission.
 */

- (void)getFormSubmissions:(long long)formID
                 onSuccess:(void (^)(id))successBlock
                 onFailure:(void (^)(NSError *))failureBlock;

/**
 * List of a form submissions.
 * @param formID is the number you see on a form URL. You can get formIDs when you call /user/forms.
 * @param offset Start of each result set for form list.
 * @param limit Number of results in each result set for form list.
 * @param filter Filters the query results to fetch a specific form range.
 * @param orderBy Order results by a form field name.
 * Return list of form reponses. Fields array has the submitted data.
 * Created_at is the date of the submission.
 */

- (void)getFormSubmissions:(long long)formID
                    offset:(NSInteger)offset
                     limit:(NSInteger)limit
                   orderBy:(NSString *)orderBy
                    filter:(NSDictionary *)filter
                 onSuccess:(void (^)(id))successBlock
                 onFailure:(void (^)(NSError *))failureBlock;

/**
 * Get form reports.
 * @param formID is the number you see on a form URL. You can get formIDs when you call /user/forms.
 * Return all the reports of a specific form.
 */

- (void)getFormReports:(long long)formID
             onSuccess:(void (^)(id))successBlock
             onFailure:(void (^)(NSError *))failureBlock;

/**
 * Add a Submissions to the Form.
 * @param formID is the number you see on a form URL. You can get formIDs when you
 * call /user/forms.
 * @param submission containing a dictionary with question IDs. You should get a
 * list of question IDs from form/{id}/questions and send the submission data with qid
 * Create submit data to this form using the API.
 */

- (void)createFormSubmissions:(long long)formID
                   submission:(NSDictionary *)submission
                    onSuccess:(void (^)(id))successBlock
                    onFailure:(void (^)(NSError *))failureBlock;

/**
 * Get Form Uploads.
 * @param formID is the number you see on a form URL. You can get formIDs when you call /user/forms.
 * Return list of files uploaded on a form. Here is how you can access a particular file.
 * Size and file type is also included.
 */

- (void)getFormFiles:(long long)formID
           onSuccess:(void (^)(id))successBlock
           onFailure:(void (^)(NSError *))failureBlock;

/**
 * List of Webhooks for a Form.
 * @param formID is the number you see on a form URL. You can get formIDs when you call /user/forms.
 * Webhooks can be used to send form submission data as an instant notification. Returns list of webhooks for this form.
 */

- (void)getFormWebhooks:(long long)formID
              onSuccess:(void (^)(id))successBlock
              onFailure:(void (^)(NSError *))failureBlock;

/**
 * Add a new webhook.
 * @param formID is the number you see on a form URL. You can get formIDs when you call /user/forms.
 * @param webhookURL Webhook URL is where form data will be posted when form is
 * submitted.
 * Create webhooks that can be used to send form submission data as an instant notification.
 */

- (void)createFormWebhooks:(long long)formID hookUrl:(NSString *)webhookURL
                 onSuccess:(void (^)(id))successBlock
                 onFailure:(void (^)(NSError *))failureBlock;

/**
 * Delete a webhook of a specific form.
 * @param formID is the number you see on a form URL. You can get formIDs when you call /user/forms.
 * @param webhookID You can get webhook IDs when you call
 * /form/{formID}/webhooks.
 * Delete a webhook of a specific form.
 */

- (void)deleteWebhook:(long long)formID webhookId:(long long)webhookID
            onSuccess:(void (^)(id))successBlock
            onFailure:(void (^)(NSError *))failureBlock;

/**
 * Get submission data
 * @param sid You can get submission IDs when you call /form/{id}/submissions.
 * Returns information and answers of a specific submission.
 */

- (void)getSubmission:(long long)sid
            onSuccess:(void (^)(id))successBlock
            onFailure:(void (^)(NSError *))failureBlock;

/**
 * Get report details
 * @param reportID You can get a list of reports from /user/reports.
 * Returns properties of a specific report like fields and status.
 */

- (void)getReport:(long long)reportID
        onSuccess:(void (^)(id))successBlock
        onFailure:(void (^)(NSError *))failureBlock;

/**
 * Delete report details
 * @param reportID You can Delete an existing report.
 * Deletes the existing report.
 */

- (void)deleteReport:(long long)reportID
           onSuccess:(void (^)(id))successBlock
           onFailure:(void (^)(NSError *))failureBlock;

/**
 
 * Create new report of a form with intended fields, type and title.
 * @param formID is the number you see on a form URL. You can get formIDs when you call /user/forms.
 * @title title is report title.
 * @list_type You can specify report type. 'csv', 'excel', 'grid', 'table',
 'rss'
 * @fields you can specify fields, User IP, submission date(dt) and question IDs
 * Report details and URL.
 */

- (void)createReport:(long long)formID
               title:(NSString *)title
           list_type:(NSString *)list_type
              fields:(NSString *)fields
           onSuccess:(void (^)(id))successBlock
           onFailure:(void (^)(NSError *))failureBlock;

/**
 * Get Form Properties.
 * @param formID is the number you see on a form URL. You can get formIDs when you call /user/forms.
 * Return a list of all properties on a form.
 */

- (void)getFormProperties:(long long)formID
                onSuccess:(void (^)(id))successBlock
                onFailure:(void (^)(NSError *))failureBlock;

/**
 * Get a Form Property.
 * @param formID is the number you see on a form URL. You can get formIDs when you call /user/forms.
 * @param propertyKey You can get property keys when you call
 * /form/{id}/properties.
 * Return a specific property of the form.
 */

- (void)getFormProperty:(long long)formID propertyKey:(NSString *)propertyKey
              onSuccess:(void (^)(id))successBlock
              onFailure:(void (^)(NSError *))failureBlock;

/**
 * Delete Submission Data.
 * @param sid You can get submission IDs when you call /user/submissions.
 * Delete a single submission.
 */

- (void)deleteSubmission:(long long)sid
               onSuccess:(void (^)(id))successBlock
               onFailure:(void (^)(NSError *))failureBlock;

/**
 * Edit a single submission.
 * @param sid is the submission ID. You can get the submission IDs when you call /form/{id}/submissions.
 * @param submissionName New submission data with question IDs.
 * Edit a submission.
 */

- (void)editSubmission:(long long)sid
                  name:(NSString *)submissionName
                   new:(NSInteger) new
flag:(NSInteger)flag
onSuccess:(void (^)(id))successBlock
onFailure:(void (^)(NSError *))failureBlock;

/**
 * Clone a single form.
 * @param formID is the number you see on a form URL. You can get formIDs when you call /user/forms.
 * Create a clone of a form.
 */

- (void)cloneForm:(long long)formID
        onSuccess:(void (^)(id))successBlock
        onFailure:(void (^)(NSError *))failureBlock;

/**
 * Delete a single form question.
 * @param formID is the number you see on a form URL. You can get formIDs when you call /user/forms.
 * @param qid Identifier for each question on a form. You can get a list of
 * question IDs from /form/{id}/questions.
 * Delete a form question.
 */

- (void)deleteFormQuestion:(long long)formID questionID:(long long)qid
                 onSuccess:(void (^)(id))successBlock
                 onFailure:(void (^)(NSError *))failureBlock;

/**
 * Add new question to specified form.
 * @param formID is the number you see on a form URL. You can get formIDs when you call /user/forms.
 * @param question New question properties like type and text.
 * Add new question.
 */

- (void)createFormQuestion:(long long)formID
                  question:(NSDictionary *)question
                 onSuccess:(void (^)(id))successBlock
                 onFailure:(void (^)(NSError *))failureBlock;

/**
 * Add new question to specified form.
 * @param formID is the number you see on a form URL. You can get formIDs when you call /user/forms.
 * @param questions New question properties like type and text.
 * Add new question to specified form. Form questions might have various properties.
 */

- (void)createFormQuestions:(long long)formID questions:(NSString *)questions
                  onSuccess:(void (^)(id))successBlock
                  onFailure:(void (^)(NSError *))failureBlock;

/**
 * Edit a single question properties.
 * @param formID is the number you see on a form URL. You can get formIDs when you call /user/forms.
 * @param qid Identifier for each question on a form. You can get a list of
 * question IDs from /form/{id}/questions.
 * @param questionProperties New question properties like text and order.
 * Edit a question property or add a new one. Form questions might have various properties. Examples: Is it required? Are there any validations such as 'numeric only'?
 */

- (void)editFormQuestion:(long long)formID
              questionID:(long long)qid
      questionProperties:(NSDictionary *)questionProperties
               onSuccess:(void (^)(id))successBlock
               onFailure:(void (^)(NSError *))failureBlock;

/**
 * Add or edit properties of a specific form
 * @param formID is the number you see on a form URL. You can get formIDs when you call /user/forms.
 * @param formProperties New properties like label width.
 * Edit a form property or add a new one.
 */

- (void)setFormProperties:(long long)formID
           formProperties:(NSDictionary *)formProperties
                onSuccess:(void (^)(id))successBlock
                onFailure:(void (^)(NSError *))failureBlock;


/**
 * Add or edit properties of a specific form
 * @param formID Form ID is the numbers you see on a form URL. You can get form IDs when you call /user/forms.
 * @param formProperties New properties like label width.
 * Edit a form property or add a new one.
 */

- (void)setMultipleFormProperties:(long long)formID
                   formProperties:(NSString *)formProperties
                        onSuccess:(void (^)(id))successBlock
                        onFailure:(void (^)(NSError *))failureBlock;

/**
 * Create a new form
 * @param form questions, properties and emails for new form.
 * Create new form.
 */

- (void)createForm:(NSDictionary *)form
         onSuccess:(void (^)(id))successBlock
         onFailure:(void (^)(NSError *))failureBlock;

/**
 * Create a new form
 * @param form questions, properties and emails for new form.
 * Creates new forms with questions, properties and email settings.
 */

- (void)createForms:(NSDictionary *)form
          onSuccess:(void (^)(id))successBlock
          onFailure:(void (^)(NSError *))failureBlock;

/**
 * Delete a single form
 * @param formID is the number you see on a form URL. You can get formIDs when you call /user/forms.
 * Delete properties of a form.
 */

- (void)deleteForm:(long long)formID
         onSuccess:(void (^)(id))successBlock
         onFailure:(void (^)(NSError *))failureBlock;

/**
 * Get details of a plan
 * @param plan is the name of the requested plan. FREE, PREMIUM etc.
 * Return details regarding systems plan
 */

- (void)getSystemPlan:(NSString *)plan
            onSuccess:(void (^)(id))successBlock
            onFailure:(void (^)(NSError *))failureBlock;

/**
 * Get system time.
 */

- (void)getSystemTime:(void (^)(id))successBlock
            onFailure:(void (^)(NSError *))failureBlock;

/**
 * Sends out a report to Jotform.
 */

- (void)createReport:(long long)formID reportParams:(NSDictionary *)reportParams
           onSuccess:(void (^)(id))successBlock
           onFailure:(void (^)(NSError *))failureBlock;

/**
 * Sends out a suggestion to Jotform.
 */

- (void)createSuggestion:(long long)formID suggestionParams:(NSDictionary *)suggestionParams
               onSuccess:(void (^)(id))successBlock
               onFailure:(void (^)(NSError *))failureBlock;


/**
 * Cancels all NSURLSessionTask requests.
 */

- (void)cancelAllTasks;

@end

