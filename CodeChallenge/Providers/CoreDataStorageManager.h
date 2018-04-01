

#import <Foundation/Foundation.h>
#import <MagicalRecord/MagicalRecord.h>
#import "PersistencyManagerProtocol.h"

@interface CoreDataStorageManager : NSObject<PersistencyManagerProtocol>

- (instancetype)initWithContext:(NSManagedObjectContext *)context;

@end
