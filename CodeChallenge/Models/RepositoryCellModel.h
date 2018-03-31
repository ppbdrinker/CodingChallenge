//
//  RepositoryCellModel.h
//  CodeChallenge
//
//  Created by MAC_A_120413 on 3/31/18.
//

#import <Foundation/Foundation.h>
#import "Repository.h"

@interface RepositoryCellModel : NSObject

- (instancetype)initWithRepository:(Repository *)repository;

- (NSString *)repositoryName;
- (NSString *)repositoryDescription;
- (NSString *)author;

@end
