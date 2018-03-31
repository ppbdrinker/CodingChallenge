//
//  RepositoriesDataProvider.m
//  CodeChallenge
//
//  Created by alexey novikov on 31.03.2018.
//



#import <CoreData/CoreData.h>
#import <MagicalRecord/MagicalRecord.h>

#import "RepositoriesDataProvider.h"
#import "RepositoryCellModel.h"

#import "NetworkService.h"
#import "CoreDataStorageManager.h"

@interface RepositoriesDataProvider ()<NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchController;
@property (strong, nonatomic) id<NetworkManagerProtocol> network;
@property (strong, nonatomic) id<PersistencyManagerProtocol> storage;

@end

@implementation RepositoriesDataProvider

- (instancetype)init {
    self = [super init];

    if (self != nil) {
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
    [self.network fetchRepositoriesWithOffset:offset
                                        limit:limit
                                 successBlock:^(NSDictionary *payload) {
                                     NSArray *items = payload[@"items"];
                                     [_self.storage startRepositoriesRankWith:offset];
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
    
    Repository *r = [self.fetchController.fetchedObjects objectAtIndex:row];
    RepositoryCellModel *cellModel = [[RepositoryCellModel alloc] initWithRepository:r];
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
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"objectID != null"];
    NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
    self.fetchController = [Repository MR_fetchAllSortedBy:@"rank"
                                                 ascending:YES
                                             withPredicate:predicate
                                                   groupBy:nil
                                                  delegate:self
                                                 inContext:context];
    NSError *error;
    [self.fetchController performFetch:&error];

    if (error != nil) {
//        DLog(@"Atata, error: %@", error.localizedDescription);
    }
}

@end
