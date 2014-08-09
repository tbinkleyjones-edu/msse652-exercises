//
//  NoteSvc.h
//  week6
//
//  Created by Tim Binkley-Jones on 8/8/14.
//  Copyright (c) 2014 msse652. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Note.h"

@interface NoteSvc : NSObject

- (instancetype)initWithHandler:(void(^)())handler;

- (NSArray *)retrieveAllNotes;

- (void)addNote:(Note *)note;

- (void)updateNote:(Note *)note;

- (void)deleteNote:(Note *)note;

@end
