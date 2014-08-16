//
//  ViewController.m
//  week7
//
//  Created by Tim Binkley-Jones on 8/15/14.
//  Copyright (c) 2014 msse652. All rights reserved.
//

#import "ViewController.h"
#import "ChatSvc.h"

@interface ViewController ()

@end

@implementation ViewController {
    ChatSvc *_service;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _service = [[ChatSvc alloc] init];
    [_service connect];
}

- (void)viewDidDisappear:(BOOL)animated {
    [_service disconnect];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendChat:(id)sender {
    [_service send:@"iam:ipad\n"];
}
@end
