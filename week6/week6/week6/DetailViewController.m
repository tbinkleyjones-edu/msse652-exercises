//
//  DetailViewController.m
//  week6
//
//  Created by Tim Binkley-Jones on 8/5/14.
//  Copyright (c) 2014 msse652. All rights reserved.
//

#import "DetailViewController.h"
#import "Note.h"
#import "NoteSvc.h"

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
        Note *note = self.detailItem;
        self.detailDescriptionLabel.text = [note.date description];
        self.detailNotes.text = note.notes;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    [self configureView];
}

- (void)viewWillDisappear:(BOOL)animated {
    Note *note = self.detailItem;
    if (! [note.notes isEqualToString:self.detailNotes.text]) {
        note.notes = self.detailNotes.text;
        [self.service updateNote:note];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"D prepareForSeque %@", [segue identifier]);
}

- (BOOL)canPerformUnwindSegueAction:(SEL)action fromViewController:(UIViewController*) fromViewController withSender:(id)sender {
    NSLog(@"D canPerformUnwindSegueAction");
    return [super canPerformUnwindSegueAction:action fromViewController:fromViewController withSender:sender];
}

- (UIStoryboardSegue *)segueForUnwindingToViewController:(UIViewController *)toViewController fromViewController:(UIViewController *)fromViewController identifier:(NSString *)identifier {
    NSLog(@"D segueForUnwindingToViewController");
    return [super segueForUnwindingToViewController:toViewController fromViewController:fromViewController identifier:identifier];
}




@end
