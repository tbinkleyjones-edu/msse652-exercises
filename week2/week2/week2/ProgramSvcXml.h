//
//  ProgramXMLParser.h
//  week2
//
//  Created by Tim Binkley-Jones on 7/11/14.
//  Copyright (c) 2014 msse652. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProgramSvcXml : NSObject <NSXMLParserDelegate>

- (NSMutableArray *) retrievePrograms;

@end
