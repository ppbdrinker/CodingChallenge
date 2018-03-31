//
//  NSDictionary+Networking.m
//  CodeChallenge
//
//  Created by alexey novikov on 31.03.2018.
//

#import "NSDictionary+Networking.h"

@implementation NSDictionary (Networking)

- (id)networkObjectForKey:(NSString *)key {
    if (key == nil) {
        return nil;
    }

    id value = [self objectForKey:key];

    if([value isKindOfClass:[NSNull class]] || [value isMemberOfClass:[NSNull class]]) {
        return nil;
    } else {
        return value;
    }
}

@end
