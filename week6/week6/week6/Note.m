//
//  Note.m
//  week6
//
//  Created by Tim Binkley-Jones on 8/8/14.
//  Copyright (c) 2014 msse652. All rights reserved.
//

#import "Note.h"

static NSString *const NOTES = @"notes";
static NSString *const DATE = @"date";

@implementation Note

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        _notes = [coder decodeObjectForKey:NOTES];
        _date = [coder decodeObjectForKey:DATE];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.notes forKey:NOTES];
    [coder encodeObject:self.date forKey:DATE];
}

//- (BOOL)isEqual:(id)other
//{
//    if (other == self) {
//        return YES;
//    } else if (![super isEqual:other]) {
//        return NO;
//    } else {
//        if ([other isKindOfClass:[Note class]]) {
//            Note *otherNote = other;
//            return [self.date isEqual:otherNote.date];
//        }
//        return NO;
//    }
//}
//
//- (NSUInteger)hash
//{
//    return [self.date hash];
//}

@end
