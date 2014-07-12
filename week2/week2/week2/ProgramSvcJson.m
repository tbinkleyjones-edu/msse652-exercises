//
//  ProgrmasJsonParser.m
//  week2
//
//  Created by Tim Binkley-Jones on 7/12/14.
//  Copyright (c) 2014 msse652. All rights reserved.
//

#import "ProgramSvcJson.h"
#import "Program.h"

@implementation ProgramSvcJson {
    NSMutableData *_responseData;
    id _delegate;
}

- (NSMutableArray *)parseData:(NSData *)data {
    NSError *error;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];

    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (int i=0; i<array.count; i++) {
        //NSLog(@"string: %@", array[i]);
        Program *program = [[Program alloc]init];
        NSDictionary *pgm = array[i];
        for (id key in pgm) {
            //Get an object and iterate thru its keys
            id value = [pgm objectForKey:key];
            //NSLog(@"key: %@, value: %@", key, value);

            if ([key isEqualToString:@"id"]) {
                program.id = [value integerValue];
            } else {
                program.name = value;
            }
        }
        [result addObject:program];
    }
    return result;
}

#pragma mark - ProgramSvc

- (void) setDelegate:(id <ProgramSvcDelegate>)delegate {
    _delegate = delegate;
}


- (void) retrieveProgramsAsync {
    NSURL *url = [NSURL URLWithString:@"http://regisscis.net/Regis2/webresources/regis2.program"];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];

    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (NSMutableArray *) retrievePrograms {
    NSError *error;

    NSURL *url = [NSURL URLWithString:@"http://regisscis.net/Regis2/webresources/regis2.program"];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];

    NSURLResponse *response = nil;

    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];

    NSMutableArray *result = [self parseData:data];

    return result;
}

#pragma mark - NSURLConnectionDelegate

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    _responseData = [[NSMutableData alloc] init];
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_responseData appendData:data];
}

- (NSCachedURLResponse *) connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
    return nil;
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
    NSMutableArray *results = [self parseData:_responseData];
    _responseData = nil;
    [_delegate didFinishRetrievingPrograms:results];
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {

}

@end
