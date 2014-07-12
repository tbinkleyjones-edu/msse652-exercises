//
//  ProgramXMLParser.m
//  week2
//
//  Created by Tim Binkley-Jones on 7/11/14.
//  Copyright (c) 2014 msse652. All rights reserved.
//

#import "ProgramSvcXml.h"
#import "Program.h"
#import "ProgramSvcDelegate.h"

@implementation ProgramSvcXml{
    NSMutableArray *programs;
    NSInteger programId;
    NSString *programName;
    NSMutableString *currentValue;
    id _delegate;
}

- (void) setDelegate:(id <ProgramSvcDelegate>)delegate {
    _delegate = delegate;
}


- (void) retrieveProgramsAsync {
    dispatch_async(dispatch_get_global_queue (DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //background processing goes here
        programs = [self retrievePrograms];

        dispatch_async(dispatch_get_main_queue(), ^{
            //update UI here
            [_delegate didFinishRetrievingPrograms:programs];
        });
    });
}

- (NSMutableArray *) retrievePrograms {
    NSError *error;
    NSURL *url = [NSURL URLWithString:@"http://regisscis.net/Regis2/webresources/regis2.program"];
    NSString *response = [NSString stringWithContentsOfURL:url encoding:NSASCIIStringEncoding error:&error];
    NSData *data = [response dataUsingEncoding:NSASCIIStringEncoding];

    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:YES];
    [parser parse];

    return programs;
}

-(void)parserDidStartDocument:(NSXMLParser *)parser {
    //NSLog(@"didStartDocument");
    programs = [[NSMutableArray alloc] init];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (!currentValue) {
        // currentStringValue is an NSMutableString instance variable
        currentValue = [[NSMutableString alloc] initWithCapacity:50];
    }
    [currentValue appendString:string];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    //NSLog(@"didEndElement: %@", elementName);

    if ([elementName isEqualToString:@"program"]) {
        // gather up properties and add a new program to the array.
        Program *program = [[Program alloc] init];
        program.id = programId;
        program.name = programName;
        [programs addObject:program];
        programId = 0;
        programName = nil;
    } else if ([elementName isEqualToString:@"id"]) {
        programId = [currentValue integerValue];
    } else if ([elementName isEqualToString:@"name"]) {
        programName = currentValue;
    }

    currentValue = nil;
}

@end
