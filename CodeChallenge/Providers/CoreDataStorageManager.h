//
//  CoreDataStorageManager.h
//  CodeChallenge
//
//  Created by MAC_A_120413 on 3/31/18.
//

#import <Foundation/Foundation.h>
#import <MagicalRecord/MagicalRecord.h>
#import "PersistencyManagerProtocol.h"

@interface CoreDataStorageManager : NSObject<PersistencyManagerProtocol>

- (instancetype)initWithContext:(NSManagedObjectContext *)context;

@end
