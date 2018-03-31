//
//  RepositoryCellModel.m
//  CodeChallenge
//
//  Created by MAC_A_120413 on 3/31/18.
//

#import "RepositoryCellModel.h"


@interface RepositoryCellModel ()

@property (weak, nonatomic) Repository *repository;

@end

@implementation RepositoryCellModel

- (instancetype)initWithRepository:(Repository *)repository{
    self = [super init];
    if (self != nil) {
        self.repository = repository;
    }
    return self;
}

- (NSString *)repositoryName{
    return self.repository.repo_name;
}

- (NSString *)repositoryDescription{
    return self.repository.short_description;
}

- (NSString *)author{
    return self.repository.owner;
}


@end
