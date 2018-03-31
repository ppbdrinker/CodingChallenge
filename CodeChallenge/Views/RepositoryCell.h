//
//  RepositoryCell.h
//  CodeChallenge
//
//  Created by MAC_A_120413 on 3/31/18.
//

#import <UIKit/UIKit.h>

@interface RepositoryCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *repositoryNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, weak) IBOutlet UILabel *authorLabel;
@property (nonatomic, weak) IBOutlet UIImageView *repositoryIconImgView;

+ (UINib *)nib;
+ (NSString *)identifier;

@end
