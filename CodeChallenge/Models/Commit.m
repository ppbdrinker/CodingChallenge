#import "Commit.h"
#import "NSDictionary+Networking.h"
#import <MagicalRecord/MagicalRecord.h>

@interface Commit ()

// Private interface goes here.

@end

@implementation Commit

+ (instancetype)entityWithPayload:(NSDictionary *)payload branchName:(NSString *)branchName inContext:(NSManagedObjectContext *)context {
    Commit *commit = [Commit MR_createEntityInContext:context];

    commit.commit_hash = [payload networkObjectForKey:@"hash"];
    commit.author_name = [[payload networkObjectForKey:@"author"] networkObjectForKey:@"email"];
    commit.commit_message = [payload networkObjectForKey:@"message"];
    commit.branch_name = branchName;
    commit.author_avatar_url = [[payload networkObjectForKey:@"author"] networkObjectForKey:@"avatar_url"];


    return commit;
}

@end
