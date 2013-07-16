jotform-api-ios 
===============
[JotForm API](http://api.jotform.com/docs/) - iOS 


### Installation

 * Download the zipped project from downloads page or clone the git repository to your computer.
      $ git clone git://github.com/jotform/jotform-api-ios.git
      $ cd jotform-api-ios
 * Please open the project and build it and select "Products/libJotForm.a" and click mouse-right button and click "Show in Finder"
 * Please look all the files in "Release-iphoneuniversal" directory and copy all the files and add them to you project.


### Documentation

You can find the docs for the API of this client at [http://api.jotform.com/docs/](http://api.jotform.com/docs)

### Authentication

JotForm API requires API key for all user related calls. You can create your API Keys at  [API section](http://www.jotform.com/myaccount/api) of My Account page.

### Examples

Print all forms of the user

    #import <JotForm/JotForm.h>

    JotForm *jotform;

    jotform = [[JotForm alloc] initWithApiKey:"Your API KEY" debugMode:NO];

    // get successfully forms
    jotform.didFinishBlock = ^(id result) {
        NSLog(@"response = %@", result);
    };
    
    // there was an error getting forms
    jotform.didFailBlock = ^(id error) {
        NSLog(@"error = %@", error);        
    };

    [jotform getForms];


Get latest submissions of the user

    #import <JotForm/JotForm.h>

    JotForm *jotform;

    jotform = [[JotForm alloc] initWithApiKey:"Your API KEY" debugMode:NO];

    // get successfully submissions
    jotform.didFinishBlock = ^(id result) {
        NSLog(@"response = %@", result);
    };
    
    // there was an error getting forms
    jotform.didFailBlock = ^(id error) {
        NSLog(@"error = %@", error);        
    };

    [jotform getSubmissions];
