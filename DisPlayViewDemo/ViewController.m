//
//  ViewController.m
//  DisPlayViewDemo
//
//  Created by MS on 4/1/15.
//  Copyright (c) 2015 MS. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>{
    NSArray *data;
    NSArray *filterData;
    UISearchDisplayController *searchDisplayController;
}
@property (nonatomic,strong)UITableView * tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"DisPlayVC";
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, 320, 568-44)];
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    [self.view addSubview:self.tableView];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    data = @[@"3131",@"da2d",@"da4d",@"dafad",@"dagad",@"dcvxad",@"dabxd",@"dancd",@"damcd",@"dcad",@"dadad",@"davzd",@"daxbd",@"danvd",@"damvd",@"d,bad",@"d,mbnad",@"dazd",@"ddsad",@"xdad"];
    
    
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 44)];
    searchBar.delegate = self;
    searchBar.placeholder = @"搜索";
    
    // 添加 searchbar 到 headerview
//    self.tableView.tableHeaderView = searchBar;
    [self.view addSubview:searchBar];
    
    
    // 用 searchbar 初始化 SearchDisplayController
    // 并把 searchDisplayController 和当前 controller 关联起来
    searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    
    // searchResultsDataSource 就是 UITableViewDataSource
    searchDisplayController.searchResultsDataSource = self;
    // searchResultsDelegate 就是 UITableViewDelegate
    searchDisplayController.searchResultsDelegate = self;
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [UIView animateWithDuration:0.35 animations:^{
        searchDisplayController.searchBar.frame = CGRectMake(0, 20, self.view.frame.size.width, 44);

    }];
    return YES;
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    [UIView animateWithDuration:0.35 animations:^{
        searchDisplayController.searchBar.frame = CGRectMake(0, 64, self.view.frame.size.width, 44);
        
    }];
    return YES;
}
/*
 * 如果原 TableView 和 SearchDisplayController 中的 TableView 的 delete 指向同一个对象
 * 需要在回调中区分出当前是哪个 TableView
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        return data.count;
    }else{
        // 谓词搜索
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains [cd] %@",searchDisplayController.searchBar.text];
        filterData =  [[NSArray alloc] initWithArray:[data filteredArrayUsingPredicate:predicate]];
        return filterData.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"mycell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    if (tableView == self.tableView) {
        cell.textLabel.text = data[indexPath.row];
    }else{
        cell.textLabel.text = filterData[indexPath.row];
    }
    
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
