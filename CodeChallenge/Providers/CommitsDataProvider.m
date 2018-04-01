

#import "CommitsDataProvider.h"

#import "NetworkService.h"
#import "CoreDataStorageManager.h"
#import "Repository.h"

@interface CommitsDataProvider ()<NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchController;
@property (strong, nonatomic) id<NetworkManagerProtocol> network;
@property (strong, nonatomic) id<PersistencyManagerProtocol> storage;
@property (strong, nonatomic) NSString *repoID;


@end

@implementation CommitsDataProvider

- (instancetype)initWithRepositoryID:(NSString *)repoID{
    self = [super init];
    if (self != nil) {
        self.repoID = repoID;
        [self initNetworkManager];
        [self initCoreDataStorage];
        [self initFetchedResultsController];
    }
    return self;
}


- (void)fetchRepositories{
    NSInteger limit = 20;
    __block NSUInteger offset = [self numberOfRows]/limit + 1;
    __weak typeof(self) _self = self;
    [self.network fetchCommitsForRepository:self.repoID
                                      limit:limit
                               successBlock:^(NSDictionary *payload) {
        NSArray *items = payload[@"items"];
        [_self.storage createRepositoriesWithPayloads:items];
    }
                               failureBlock:^(NSError *error) {
        
    }];
}


#pragma mark - DataProviderProtocol
- (void)refresh{
    [self.storage resetStorage];
    [self fetchRepositories];
}

- (NSUInteger)numberOfRows {
    return self.fetchController.fetchedObjects.count;
}

- (id)cellModelAtRow:(NSUInteger)row {
    if (row >= self.fetchController.fetchedObjects.count) {
        return nil;
    }
    
    if ([self numberOfRows] - 1 == row ){
        [self fetchRepositories];
    }
    
    __weak Commit *c = [self.fetchController.fetchedObjects objectAtIndex:row];
//    if (r.image_url != nil && r.image == nil){
//        [self.network fetchAvatarForURL:r.image_url
//                           successBlock:^(NSData *imageData) {
//                               r.image = imageData;
//                           }
//                           failureBlock:^(NSError *error) {
//
//                           }];
//    }
    CommitCellModel *cellModel = [[CommitCellModel alloc] initWithCommit:c];
    return cellModel;
}

#pragma mark - NSFRC delegate methods
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self notifyDataConsumerAboutDataChange];
}

#pragma mark - private subroutines
- (void)notifyDataConsumerAboutDataChange {
    if (self.dataConsumer != nil && [self.dataConsumer respondsToSelector:@selector(dataProviderDidChangeData:)]) {
        [self.dataConsumer dataProviderDidChangeData:self];
    }
}

- (void)notifyDataConsumerAboutImageDownload {
    
}

#pragma mark - init subroutines

- (void)initCoreDataStorage{
    NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
    self.storage = [[CoreDataStorageManager alloc] initWithContext:[NSManagedObjectContext MR_contextWithParent:context]];
    
}

- (void)initNetworkManager {
    self.network = [[NetworkService alloc] init];
}

- (void)initFetchedResultsController {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"objectID != null "];
    NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
    self.fetchController = [Commit MR_fetchAllSortedBy:@"commit_timestamp"
                                                 ascending:NO
                                             withPredicate:predicate
                                                   groupBy:nil
                                                  delegate:self
                                                 inContext:context];
    NSError *error;
    [self.fetchController performFetch:&error];
    
    if (error != nil) {
        NSLog(@"Atata, error: %@", error.localizedDescription);
    }
}


@end
