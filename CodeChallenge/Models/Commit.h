#import "_Commit.h"

@interface Commit : _Commit
    + (instancetype)entityWithPayload:(NSDictionary *)payload
                           branchName:(NSString *)branchName
                            inContext:(NSManagedObjectContext *)context;
@end
