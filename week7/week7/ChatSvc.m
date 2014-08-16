//
//  ChatSvc.m
//  week7
//
//  Created by Tim Binkley-Jones on 8/15/14.
//  Copyright (c) 2014 msse652. All rights reserved.
//

#import "ChatSvc.h"

@implementation ChatSvc {
    NSInputStream *inputStream;
    NSOutputStream *outputStream;
}


- (void) connect {
    NSLog(@"Connecting");
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"www.regisscis.net", 8080, &readStream, &writeStream);
    inputStream = (NSInputStream *)CFBridgingRelease(readStream);
    outputStream = (NSOutputStream *)CFBridgingRelease(writeStream);

    [inputStream setDelegate:self];
    [outputStream setDelegate:self];
    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];

    [inputStream open];
    [outputStream open];
}

- (void) send:(NSString *) msg {
    NSLog(@"Sending message: %@", msg);
    NSData *data = [[NSData alloc] initWithData:[msg dataUsingEncoding:NSASCIIStringEncoding]];
    [outputStream write:[data bytes] maxLength:[data length]];
}

- (NSString *) retrieve {
    NSMutableString *msg = [[NSMutableString alloc] init];
    uint8_t buffer[1024];
    int len = 0;
    while ([inputStream hasBytesAvailable]) {
        len = [inputStream read:buffer maxLength: sizeof(buffer)];
        if (len > 0) {
            NSString *output = [[NSString alloc] initWithBytes:buffer length:len encoding:NSASCIIStringEncoding];
            if ( output != nil) {
                [msg appendString:output];
            }
        }
    }
    NSLog(@"Retrieved message: %@", msg);
    return msg;
}

- (void) disconnect {
    [inputStream close];
    [outputStream close];
    [inputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [inputStream setDelegate:nil];
    [outputStream setDelegate:nil];
    inputStream = nil;
    outputStream = nil;
    NSLog(@"Diconnected");
}

#pragma mark - NSStreamDelegate


- (void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent {

	NSLog(@"stream event %u", streamEvent);

	switch (streamEvent) {
		case NSStreamEventOpenCompleted:
			NSLog(@"Stream opened");
			break;
		case NSStreamEventHasBytesAvailable:
            NSLog(@"Bytes available ");
            if (theStream == inputStream) {
				uint8_t buffer[1024];
				int len;

				while ([inputStream hasBytesAvailable]) {
					len = [inputStream read:buffer maxLength:sizeof(buffer)];
					if (len > 0) {

						NSString *output = [[NSString alloc] initWithBytes:buffer length:len encoding:NSASCIIStringEncoding];

						if (nil != output) {

							NSLog(@"server said: %@", output);
							[self messageReceived:output];

						}
					}
				}
			}
			break;
        case NSStreamEventHasSpaceAvailable:
            NSLog(@"Output stream has space available");
            break;
		case NSStreamEventErrorOccurred:
			NSLog(@"Can not connect to the host!");
			break;
		case NSStreamEventEndEncountered:
            NSLog(@"Closing stream");
            [theStream close];
            [theStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
            theStream = nil;
			break;
		default:
			NSLog(@"Unknown event");
	}
    
}

- (void) messageReceived:(NSString *)message {
    NSLog(@"Received message: %@", message);
}



@end
