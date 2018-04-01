

#import "ViewController.h"
#import "RepositoryCell.h"

#import "RepositoriesDataProvider.h"
@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak  ) IBOutlet UITableView *table;
@property (nonatomic, strong) id<DataProviderProtocol> provider;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.table registerNib:[RepositoryCell nib] forCellReuseIdentifier:[RepositoryCell identifier]];
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    [refresh addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.table addSubview:refresh];
    self.table.alwaysBounceVertical = YES;
    
    //Need to setup feed here
    self.provider = [[RepositoriesDataProvider alloc] init];
    self.provider.dataConsumer = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refresh:(UIRefreshControl *)sender{
    [self.provider refresh];
    [sender endRefreshing];
}

#pragma mark - DataConsumer

- (void)dataProviderDidChangeData:(id<DataProviderProtocol>)dataProvider{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.table reloadData];
    });
}

- (void)dataProvider:(id<DataProviderProtocol>)dataProvider didChangeImageForRowAtIndex:(NSUInteger)index{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.table reloadData];
    });
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.provider numberOfRows];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RepositoryCell *cell = [tableView dequeueReusableCellWithIdentifier:[RepositoryCell identifier] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    RepositoryCellModel *model = [self.provider cellModelAtRow:indexPath.row];
    if (model){
        cell.repositoryIconImgView.image = [model avatar];
        cell.repositoryNameLabel.text = [model repositoryName];
        cell.descriptionLabel.text = [model repositoryDescription];
        cell.authorLabel.text = [NSString stringWithFormat:@"Author: %@", [model author]];
    }
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RepositoryCellModel *model = [self.provider cellModelAtRow:indexPath.row];
    if (model){
        
    }
}

@end
