//
//  week2Tests.m
//  week2Tests
//
//  Created by Tim Binkley-Jones on 7/11/14.
//  Copyright (c) 2014 msse652. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ProgramSvcXml.h"
#import "ProgramSvcJson.h"

@interface week2Tests : XCTestCase

@end

@implementation week2Tests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testProgramSvcXml
{
    ProgramSvcXml *service = [[ProgramSvcXml alloc] init];
    NSArray *programs = [service retrievePrograms];
    XCTAssert(programs.count > 0, @"Unexpected empty list");

}

- (void)testProgramSvcJson
{
    ProgramSvcJson *service = [[ProgramSvcJson alloc] init];
    NSArray *programs = [service retrievePrograms];
    XCTAssert(programs.count > 0, @"Unexpected empty list");

}

@end
