//
//  ProgramSvc.h
//  week2
//
//  Created by Tim Binkley-Jones on 7/12/14.
//  Copyright (c) 2014 msse652. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProgramSvcDelegate.h"

@protocol ProgramSvc <NSObject>

- (NSMutableArray *) retrievePrograms;
- (void) retrieveProgramsAsync;
- (void) setDelegate:(id <ProgramSvcDelegate>)delegate;

@end
