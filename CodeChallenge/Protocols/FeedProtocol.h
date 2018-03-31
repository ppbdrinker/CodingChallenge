//
//  FeedProtocol.h
//  CodeChallenge
//
//  Created by MAC_A_120413 on 3/31/18.
//

#ifndef FeedProtocol_h
#define FeedProtocol_h

#import <Foundation/Foundation.h>
#import "FetchDelegate.h"

typedef void(^FeedResultBlock)();

@protocol FeedDelegate

- (void)refreshWithCompletionHandler:(FeedResultBlock)callback;
- (void)loadNext:(NSInteger)offset withCompletionHandler:(FeedResultBlock)callback;
- (NSInteger)count;
- (id)objectAtIndexPath:(NSIndexPath *)path;
- (void)addFetchDelegate:(id<FetchDelegate>)delegate;

@end

#endif 
