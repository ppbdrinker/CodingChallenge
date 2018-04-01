

#import "CoreDataStorageManager.h"
#import "Repository.h"
#import "Commit.h"
#import "Avatar.h"

@interface CoreDataStorageManager()

@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, assign) NSInteger rank;

@end


@implementation CoreDataStorageManager

- (instancetype)initWithContext:(NSManagedObjectContext *)context{
    self = [super init];
    if (self != nil) {
        self.context = context;
    }
    return self;
}

- (void)startRepositoriesRankWith:(NSInteger)rank{
    self.rank = rank;
}

- (void)createRepositoriesWithPayloads:(NSArray<NSDictionary *> *)payloads{
    for (NSDictionary *payload in payloads){
        [Repository entityWithPayload:payload rank:self.rank inContext:self.context];
        self.rank ++;
    }
    [self.context MR_saveOnlySelfAndWait];
}

- (void)createRepositoryWithPayload:(NSDictionary *)payload {
    [Repository entityWithPayload:payload rank:0 inContext:self.context];
    [self.context MR_saveOnlySelfAndWait];
}

- (void)createCommitWithPayload:(NSDictionary *)payload {
    
}

- (void)createCommitsWithPayloads:(NSArray<NSDictionary *> *)payloads{
    for (NSDictionary *payload in payloads){
        [Commit entityWithPayload:payload branchName:@"" inContext:self.context];
    }
    [self.context MR_saveOnlySelfAndWait];
}

- (void)createAvatarWithData:(NSData *)data {
    
}

- (void)resetStorage {
    NSFetchRequest *request = [Repository fetchRequest];
    request.predicate = [NSPredicate predicateWithFormat:@"repo_id != null"];
    NSArray *result = [Repository MR_executeFetchRequest:request inContext:self.context];
    for (Repository *repo in result){
        [repo MR_deleteEntityInContext:self.context];
    }
    [self.context MR_saveOnlySelfAndWait];
}

@end
