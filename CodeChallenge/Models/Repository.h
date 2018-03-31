#import "_Repository.h"

@interface Repository : _Repository
    + (instancetype)entityWithPayload:(NSDictionary *)payload
                                 rank:(NSUInteger)rank
                            inContext:(NSManagedObjectContext *)context;
@end
