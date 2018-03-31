//
//  ViewController.m
//  CodeChallenge
//
//  Created by alexey novikov on 30.03.2018.
//

#import "ViewController.h"
#import "RepositoryCell.h"
#import "FeedProtocol.h"
#import "FetchDelegate.h"
@interface ViewController () <UITableViewDataSource, UITableViewDelegate, FetchDelegate>

@property (nonatomic, weak  ) IBOutlet UITableView *table;
@property (nonatomic, strong) id<FeedDelegate> feed;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.table registerNib:[RepositoryCell nib] forCellReuseIdentifier:[RepositoryCell identifier]];
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    [refresh addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.table addSubview:refresh];
    self.table.alwaysBounceVertical = YES;
    [self.feed addFetchDelegate:self];
    //Need to setup feed here
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refresh:(UIRefreshControl *)sender{
    __weak typeof(sender) _sender = sender;
    [self.feed refreshWithCompletionHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [_sender endRefreshing];
        });
    }];
}

#pragma mark - FetchDelegate

- (void)didUpdateFecthDelegate:(id<FetchDelegate>)delegate{
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.feed count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RepositoryCell *cell = [tableView dequeueReusableCellWithIdentifier:[RepositoryCell identifier] forIndexPath:indexPath];
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    //Ask feed for next chunk
    if (indexPath.row == [self.feed count] - 1){
        //20 should be replaced with some var
        __weak typeof(self) _self = self;
        [self.feed loadNext:20 withCompletionHandler:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [_self.table reloadData];
            });
        }];
    }
}

@end
