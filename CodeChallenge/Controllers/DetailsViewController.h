

#import <UIKit/UIKit.h>
#import "DataProviderProtocol.h"

@interface DetailsViewController : UIViewController<DataConsumer>

- (void)loadRepositoryWithID:(NSString *)repoID;

@end
