//
//  BusinessLogicControllerProtocol.h
//  CodeChallenge
//
//  Created by alexey novikov on 31.03.2018.
//

#import <Foundation/Foundation.h>
#import "Repository.h"

// This is the top-level abstraction protocol
// Will be implemented by a business logic controller, which will be accessible from the view controllers.
// Implementation of such BL controller will incorporate the logic for making network requests (JSON+image data)
// and persistency.

@protocol BusinessLogicControllerProtocol <NSObject>
@optional
    - (void)loadRepositoriesWithOffset:(NSUInteger)offset limit:(NSUInteger)limit;
    - (void)loadCommitsForRepository:(Repository *)repository limit:(NSUInteger)limit;
@end
