//
//  MasterViewController.h
//  week2
//
//  Created by Tim Binkley-Jones on 7/11/14.
//  Copyright (c) 2014 msse652. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgramSvcDelegate.h"

@interface MasterViewController : UITableViewController <ProgramSvcDelegate>

- (IBAction)getXmlDataWithNSURL:(id)sender;
- (IBAction)getJsonDataWithNSURL:(id)sender;
@end
