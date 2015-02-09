//
//  MSearchViewController.m
//  DigitalScholl
//
//  Created by rachel on 15/1/15.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MSearchViewController.h"

@interface MSearchViewController ()

@end

@implementation MSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
    searchBar.placeholder = @"搜索课程";
    self.navigationItem.titleView = searchBar;
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelAction)];
    self.navigationItem.rightBarButtonItem = cancelItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark- 取消
-(void)cancelAction
{
    UISearchBar *searchBar = (UISearchBar *)self.navigationItem.titleView;
    [searchBar resignFirstResponder];
    
    [self.navigationController popViewControllerAnimated:NO];
}
@end
