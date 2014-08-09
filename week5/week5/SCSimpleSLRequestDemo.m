// SCSimpleSLRequestDemo.m
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import "SCSimpleSLRequestDemo.h"

@interface SCSimpleSLRequestDemo()

@property (nonatomic) ACAccountStore *accountStore;

@end

@implementation SCSimpleSLRequestDemo

- (id)init
{
    self = [super init];
    if (self) {
        _accountStore = [[ACAccountStore alloc] init];
    }
    return self;
}

- (BOOL)userHasAccessToTwitter
{
    return [SLComposeViewController
            isAvailableForServiceType:SLServiceTypeTwitter];
}

- (void)fetchTwitterFeed
{
    //  Step 0: Check that the user has local Twitter accounts
    if ([self userHasAccessToTwitter]) {

        //  Step 1:  Obtain access to the user's Twitter accounts
        ACAccountType *twitterAccountType =
        [self.accountStore accountTypeWithAccountTypeIdentifier:
         ACAccountTypeIdentifierTwitter];

        [self.accountStore
         requestAccessToAccountsWithType:twitterAccountType
         options:NULL
         completion:^(BOOL granted, NSError *error) {
             if (granted) {
                 //  Step 2:  Create a request
                 NSArray *twitterAccounts =
                 [self.accountStore accountsWithAccountType:twitterAccountType];
                 NSURL *url = [NSURL URLWithString:@"https://api.twitter.com"
                               @"/1.1/search/tweets.json"];


                 NSDictionary *params = @{ @"count" : @"10",
                                          @"q" : @"%23thisisregis%20OR%20%40RegisUniversity%20OR%20%40regisunivcps",
                                          @"resultl_type": @"recent"};
                 SLRequest *request =
                 [SLRequest requestForServiceType:SLServiceTypeTwitter
                                    requestMethod:SLRequestMethodGET
                                              URL:url
                                       parameters:params];

                 //  Attach an account to the request
                 [request setAccount:[twitterAccounts lastObject]];

                 //  Step 3:  Execute the request
                 [request performRequestWithHandler:
                  ^(NSData *responseData,
                    NSHTTPURLResponse *urlResponse,
                    NSError *error) {

                      if (responseData) {
                          if (urlResponse.statusCode >= 200 &&
                              urlResponse.statusCode < 300) {

                              //NSLog(@"%@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);

                              NSError *jsonError;
                              NSDictionary *timelineData = [NSJSONSerialization JSONObjectWithData:responseData
                                                                                           options:kNilOptions
                                                                                             error:&jsonError];
                              if (timelineData) {
                                  //NSLog(@"Timeline Response: %@\n", timelineData);
                                  NSArray *statuses = [timelineData objectForKey:@"statuses"];
                                  for ( id status in statuses) {
                                      NSString *text = [status objectForKey:@"text"];
                                      NSString *user = [[status objectForKey:@"user"] objectForKey:@"name"];
                                      NSLog(@"%@ - %@", user, text);
                                  }
                              }
                              else {
                                  // Our JSON deserialization went awry
                                  NSLog(@"JSON Error: %@", [jsonError localizedDescription]);
                              }
                          }
                          else {
                              // The server did not respond ... were we rate-limited?
                              NSLog(@"The response status code is %d",
                                    urlResponse.statusCode);
                          }
                      }
                  }];
             }
             else {
                 // Access was not granted, or an error occurred
                 NSLog(@"%@", [error localizedDescription]);
             }
         }];
    }
}

@end
