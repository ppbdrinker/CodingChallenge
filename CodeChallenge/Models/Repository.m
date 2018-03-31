#import "Repository.h"
#import "NSDictionary+Networking.h"
#import <MagicalRecord/MagicalRecord.h>

@interface Repository ()

// Private interface goes here.

@end

@implementation Repository

+ (instancetype)entityWithPayload:(NSDictionary *)payload
                             rank:(NSUInteger)rank
                        inContext:(NSManagedObjectContext *)context {
    Repository *repository = [Repository MR_createEntityInContext:context];

    repository.repo_id = [payload networkObjectForKey:@"id"];
    repository.repo_name = [payload networkObjectForKey:@"name"];
    repository.owner = [[payload networkObjectForKey:@"owner"] networkObjectForKey:@"login"];
    repository.short_description = [payload networkObjectForKey:@"description"];
    repository.rank = @(rank);
    repository.image_url = @"";

    return repository;
}

@end
