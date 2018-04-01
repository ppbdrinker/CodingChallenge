

#import <Foundation/Foundation.h>
#import "Repository.h"


@protocol BusinessLogicControllerProtocol <NSObject>

@optional
- (void)loadRepositoriesWithOffset:(NSUInteger)offset limit:(NSUInteger)limit;
- (void)loadCommitsForRepository:(Repository *)repository limit:(NSUInteger)limit;

@end
