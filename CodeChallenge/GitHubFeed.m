//
//  GitHubFeed.m
//  CodeChallenge
//
//  Created by MAC_A_120413 on 3/31/18.
//

#import "GitHubFeed.h"
#import <MagicalRecord/MagicalRecord.h>
#import "FetchDelegate.h"

@interface GitHubFeed ()

@property (nonatomic, strong) NSFetchedResultsController *fetchResultController;

@end


@implementation GitHubFeed


#pragma mark - FetchDelegate



#pragma mark - FeedDelegate

- (void)refreshWithCompletionHandler:(FeedResultBlock)callback{
    
}

- (void)loadNext:(NSInteger)offset withCompletionHandler:(FeedResultBlock)callback{
    
}

- (NSInteger)count{
    return [self.fetchResultController fetchedObjects].count;
}

- (id)objectAtIndexPath:(NSIndexPath *)path{
    return [self.fetchResultController objectAtIndexPath:path];
}

- (void)addFetchDelegate:(id<FetchDelegate>)delegate{
    
}

@end
