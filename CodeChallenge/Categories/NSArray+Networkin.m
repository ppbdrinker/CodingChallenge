

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
