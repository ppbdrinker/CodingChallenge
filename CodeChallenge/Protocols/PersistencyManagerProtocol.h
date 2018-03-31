//
//  PersistencyManagerProtocol.h
//  CodeChallenge
//
//  Created by alexey novikov on 31.03.2018.
//

#import <Foundation/Foundation.h>

// this interface describes the serializer.
// object implementing it will hide the details of how exactly the JSON is turned into model objects and persisted (=created and/or updated),
// be it CoreData or plain text files on the disk, thus providing abstraction on this layer.

@protocol PersistencyManagerProtocol <NSObject>
- (void)startRepositoriesRankWith:(NSInteger)rank;

- (void)createRepositoriesWithPayloads:(NSArray<NSDictionary *> *)payloads;
- (void)createRepositoryWithPayload:(NSDictionary *)payload;

- (void)createCommitWithPayload:(NSDictionary *)payload;
- (void)createAvatarWithData:(NSData *)data;
- (void)resetStorage;
@end
