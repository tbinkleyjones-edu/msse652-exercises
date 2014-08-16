//
//  ChatSvc.h
//  week7
//
//  Created by Tim Binkley-Jones on 8/15/14.
//  Copyright (c) 2014 msse652. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatSvc : NSObject <NSStreamDelegate>

- (void) connect;
- (void) send:(NSString *) msg;
- (NSString *) retrieve;
- (void) disconnect;

@end
