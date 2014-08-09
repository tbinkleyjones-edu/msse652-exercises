//
//  DetailViewController.h
//  week6
//
//  Created by Tim Binkley-Jones on 8/5/14.
//  Copyright (c) 2014 msse652. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) id service;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet UITextView *detailNotes;


@end
