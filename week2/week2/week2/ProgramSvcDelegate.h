//
//  ProgramSvcDelegate.h
//  week2
//
//  Created by Tim Binkley-Jones on 7/12/14.
//  Copyright (c) 2014 msse652. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProgramSvcDelegate <NSObject>

- (void)didFinishRetrievingPrograms:(NSMutableArray *)programs;

@end
