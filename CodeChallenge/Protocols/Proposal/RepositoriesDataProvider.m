//
//  RepositoriesDataProvider.m
//  CodeChallenge
//
//  Created by alexey novikov on 31.03.2018.
//

@class RepositoriesCellModel;

#import <CoreData/CoreData.h>
#import <MagicalRecord/MagicalRecord.h>

#import "Repository.h"
#import "RepositoriesDataProvider.h"

@interface RepositoriesDataProvider ()<NSFetchedResultsControllerDelegate>
    @property (strong, nonatomic) NSFetchedResultsController *fetchController;
@end

@implementation RepositoriesDataProvider

- (instancetype)init {
    self = [super init];

    if (self != nil) {

    }

    return self;
}

#pragma mark - DataProviderProtocol
- (NSUInteger)numberOfRows {
    return self.fetchController.fetchedObjects.count;
}

- (id)cellModelAtRow:(NSUInteger)row {
    if (row >= self.fetchController.fetchedObjects.count) {
        return nil;
    }

    Repository *r = [self.fetchController.fetchedObjects objectAtIndex:row];

    RepositoriesCellModel *cellModel = [[RepositoriesCellModel alloc] initWithRepository:r];
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
- (void)initFetchedResultsController {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@""];

    self.fetchController = [Repository MR_fetchAllSortedBy:@"rank"
                                                 ascending:YES
                                             withPredicate:predicate
                                                   groupBy:nil
                                                  delegate:self];
    NSError *error;
    [self.fetchController performFetch:&error];

    if (error != nil) {
        DLog(@"Atata, error: %@", error.localizedDescription);
    }
}

@end
