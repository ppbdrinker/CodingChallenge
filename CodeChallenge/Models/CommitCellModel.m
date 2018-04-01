//
//  CommitCellModel.m
//  CodeChallenge
//
//  Created by MAC_A_120413 on 4/1/18.
//

#import "CommitCellModel.h"

@interface CommitCellModel ()

@property (weak, nonatomic) Commit *commit;

@end

@implementation CommitCellModel

- (instancetype)initWithCommit:(Commit *)commit{
    self = [super init];
    if (self){
        self.commit = commit;
    }
    return self;
}

- (NSString *)commitName{
    return self.commit.commit_message;
}

- (NSString *)commitHash{
    return self.commit.commit_hash;
}

- (NSString *)author{
    return self.commit.author_name;
}

- (UIImage *)avatar{
    return self.commit.author_avatar_url;
}

@end
