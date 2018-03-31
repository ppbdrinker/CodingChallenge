//
//  ViewController.m
//  CodeChallenge
//
//  Created by alexey novikov on 30.03.2018.
//

#import "ViewController.h"
#import "RepositoryCell.h"

@interface ViewController () <UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *table;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.table registerNib:[RepositoryCell nib] forCellReuseIdentifier:[RepositoryCell identifier]];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RepositoryCell *cell = [tableView dequeueReusableCellWithIdentifier:[RepositoryCell identifier] forIndexPath:indexPath];
    return cell;
}




#pragma mark - UITableViewDelegate

@end
