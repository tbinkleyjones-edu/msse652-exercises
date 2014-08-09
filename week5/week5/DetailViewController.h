//
//  DetailViewController.h
//  week5
//
//  Created by Tim Binkley-Jones on 7/29/14.
//  Copyright (c) 2014 msse652. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

- (IBAction)sendPost:(id)sender;
- (IBAction)postToTwitter:(id)sender;
- (IBAction)postToFacebook:(id)sender;
- (IBAction)getTwitterFeed:(id)sender;
- (IBAction)getFacebookFeed:(id)sender;


@end
