

#import <Foundation/Foundation.h>

@protocol PersistencyManagerProtocol <NSObject>
- (void)startRepositoriesRankWith:(NSInteger)rank;

- (void)createRepositoriesWithPayloads:(NSArray<NSDictionary *> *)payloads;
- (void)createRepositoryWithPayload:(NSDictionary *)payload;

- (void)createCommitWithPayload:(NSDictionary *)payload;
- (void)createCommitsWithPayloads:(NSArray<NSDictionary *> *)payloads;

- (void)createAvatarWithData:(NSData *)data;
- (void)resetStorage;
@end
