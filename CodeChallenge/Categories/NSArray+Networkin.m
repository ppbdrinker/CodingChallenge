//
//  NSArray+Networkin.m
//  CodeChallenge
//
//  Created by MAC_A_120413 on 3/31/18.
//

#import "NSArray+Networkin.h"

@implementation NSArray (Networkin)

+ (instancetype)arrayWithData:(NSData *)data{
    NSError* error;
    NSArray* json = [NSJSONSerialization JSONObjectWithData:data
                                                 options:kNilOptions
                                                   error:&error];
    return json;
}

@end
