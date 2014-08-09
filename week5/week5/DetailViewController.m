//
//  DetailViewController.m
//  week5
//
//  Created by Tim Binkley-Jones on 7/29/14.
//  Copyright (c) 2014 msse652. All rights reserved.
//

#import "DetailViewController.h"
#import "SCSimpleSLRequestDemo.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendPost:(id)sender {

    NSString *postText = [self.detailItem description];

    //UIImage *postImage = [UIImage imageNamed:@”myImage.png”];

    NSArray *activityItems = @[postText]; //, postImage];

    UIActivityViewController *activityController =
    [[UIActivityViewController alloc]
     initWithActivityItems:activityItems applicationActivities:nil];

    [self presentViewController:activityController
                       animated:YES completion:nil];
}

- (IBAction)postToTwitter:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        // Device is able to send a Twitter message
        SLComposeViewController *composeController = [SLComposeViewController
                                                      composeViewControllerForServiceType:SLServiceTypeTwitter];

        [composeController setInitialText:[self.detailItem description]];
        //[composeController addImage:postImage.image];
        [composeController addURL: [NSURL URLWithString:
                                    @"http://www.regis.edu"]];
        
        [self presentViewController:composeController 
                           animated:YES completion:nil];
    }
}


- (IBAction)postToFacebook:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        // Device is able to send a Twitter message
        SLComposeViewController *composeController = [SLComposeViewController
                                                      composeViewControllerForServiceType:SLServiceTypeFacebook];

        [composeController setInitialText:[self.detailItem description]];
        //[composeController addImage:postImage.image];
        [composeController addURL: [NSURL URLWithString:
                                    @"http://www.regis.edu"]];

        [self presentViewController:composeController
                           animated:YES completion:nil];
    }
}

- (IBAction)getTwitterFeed:(id)sender {
    SCSimpleSLRequestDemo *requestDemo = [[SCSimpleSLRequestDemo alloc] init];
    [requestDemo fetchTwitterFeed];
}

- (IBAction)getFacebookFeed:(id)sender {
    SCSimpleSLRequestDemo *requestDemo = [[SCSimpleSLRequestDemo alloc] init];
    [requestDemo fetchFacebookFeed];
}

@end
