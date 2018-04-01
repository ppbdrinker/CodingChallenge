#import "Avatar.h"
#import "NSDictionary+Networking.h"
#import <MagicalRecord/MagicalRecord.h>

@interface Avatar ()

// Private interface goes here.

@end

@implementation Avatar

+ (instancetype)entityWithPayload:(NSData *)payload url:(NSString *)url inContext:(NSManagedObjectContext *)context{
    Avatar *avatar = [Avatar MR_createEntityInContext:context];
    avatar.avatar_data = payload;
    return avatar;
}

@end
