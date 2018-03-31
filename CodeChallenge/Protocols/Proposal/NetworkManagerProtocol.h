//
//  NetworkManagerProtocol.h
//  CodeChallenge
//
//  Created by alexey novikov on 31.03.2018.
//

#import <Foundation/Foundation.h>

// this protocol describes the low-level network interaction interface that is never exposed to view controllers,
// but only to the business logic controller.
// object implementing it will know how to create NSURLSessionTasks, will be aware of the base URL, and will form the request parameters.

typedef void(^DataSuccessBlock)(NSData *imageData)
typedef void(^SuccessBlock)(NSDictionary *payload);
typedef void(^FailureBlock)(NSError *error);

@protocol NetworkManagerProtocol <NSObject>
    - (void)fetchRepositoriesWithOffset:(NSUInteger)offset
                                  limit:(NSUInteger)limit
                           successBlock:(SuccessBlock)success
                           failureBlock:(FailureBlock)failure;

    - (void)fetchCommitsForRepository:(NSString *)repository
                                limit:(NSUInteger)limit
                         successBlock:(SuccessBlock)success
                         failureBlock:(FailureBlock)failure;

    - (void)fetchAvatarForAuthor:(NSString *)author
                    successBlock:(DataSuccessBlock)success
                    failureBlock:(FailureBlock)failure;

    - (void)cancelAllRequests;
@end
