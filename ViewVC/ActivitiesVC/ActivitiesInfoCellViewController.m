//
//  ActivitiesInfoCellViewController.m
//  DigitalSchool
//
//  Created by 刘军林 on 15/1/19.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "ActivitiesInfoCellViewController.h"
#import "PLWorkProcess.h"
#import "PLDiscussProcess.h"
#import "ActivityWorksCell.h"
#import "ActivityDiscussCell.h"
#import "MCommentViewController.h"
//#import "MWorksCell.h"
//#import "MCommentCell.h"

@interface ActivitiesInfoCellViewController ()

@end

@implementation ActivitiesInfoCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _discussProcess = [[PLDiscussProcess alloc] init];
    _workProcess = [[PLWorkProcess alloc] init];
    if (_cellStyle ==  ALLCOMMENT) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ActivitiesInfoEdit.png"] style:UIBarButtonItemStyleDone target:self action:@selector(commentActivityAction:)];
        self.navigationItem.rightBarButtonItem = item;
    }
    // Do any additional setup after loading the view.
}



-(void) viewWillAppear:(BOOL)animated
{
    if (_cellStyle == WINNERWORKS) {
        self.title = @"获奖作品";
        
        [_workProcess getActivityWorksList:10 didCurrentPage:1 didActivityId:_styleId didType:1 didSuccess:^(NSMutableArray *array){
            _array = array;
            [self.baseTableView reloadData];
        }didFail:^(NSString *error) {
            
        }];
    }else if (_cellStyle == ALLWORKS) {
        self.title = @"全部作品";
        
        [_workProcess getActivityWorksList:10 didCurrentPage:1 didActivityId:_styleId didType:0 didSuccess:^(NSMutableArray *array){
            _array = array;
            [self.baseTableView reloadData];
        }didFail:^(NSString *error) {
            
        }];
    }else if (_cellStyle ==  ALLCOMMENT) {
        self.title = @"全部评论";
        [_discussProcess getActivityDiscussList:10 didCurrentPage:1 didActivityId:_styleId didSuccess:^(NSMutableArray *array) {
            _array = array;
            [self.baseTableView reloadData];
        } didFail:^(NSString *error) {
            
        }];
    }
}

-(void) commentActivityAction:(id)sender
{
    [self performSegueWithIdentifier:@"commentActivity" sender:nil];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"commentActivity"]) {
        UINavigationController *nav = segue.destinationViewController;
        MCommentViewController *commentView = [nav.viewControllers objectAtIndex:0];
        commentView.title = @"发评论";
        commentView.playVideoType = MPlayVideoTypeActivities;
        commentView.courseId = _styleId;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITableViewDelegate
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_array count];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 99.f;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_cellStyle == WINNERWORKS) {
        static NSString *cellIdentifier = @"WorksCellIndentifier";
        ActivityWorksCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        
        PLWorks *works = [_array objectAtIndex:indexPath.row];
        cell.works = works;
        
        return cell;
    }else if (_cellStyle == ALLWORKS) {
        static NSString *cellIdentifier = @"WorksCellIndentifier";
        ActivityWorksCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        
        PLWorks *works = [_array objectAtIndex:indexPath.row];
        cell.works = works;
        return cell;
    }else{
        static NSString *cellIdentifier = @"CommentCellIndentifier";
        ActivityDiscussCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        
        PLDiscuss *discuss = [_array objectAtIndex:indexPath.row];
        cell.discuss = discuss;
        
        return cell;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
