//
//  RepositoryCell.m
//  CodeChallenge
//
//  Created by MAC_A_120413 on 3/31/18.
//

#import "RepositoryCell.h"

@implementation RepositoryCell

+ (UINib *)nib{
    UINib *nib = [UINib nibWithNibName:[RepositoryCell identifier] bundle:[NSBundle mainBundle]];
    return nib;
}

+ (NSString *)identifier{
    NSString *identifier = [[RepositoryCell class] description];
    return identifier;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
