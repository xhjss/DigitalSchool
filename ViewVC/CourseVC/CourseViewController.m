//
//  CourseViewController.m
//  DigitalScholl
//
//  Created by rachel on 15/1/6.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "CourseViewController.h"
#import "MCourseCell.h"

#import "MScreeningViewController.h"
#import "MSearchViewController.h"
#import "MPlayVideoViewController.h"
#import "ActivitiesInfoViewController.h"

#import "PLCourseProcess.h"
#import "PLCourse.h"
#import "PLWorkProcess.h"
#import "PLWorks.h"
#import "PLDiscussProcess.h"

@interface CourseViewController ()
<MMenuViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    
}
@property(nonatomic,strong)PLCourseProcess *courseProcess;
@property(nonatomic,strong)PLWorkProcess *workProcess;
@property(nonatomic,strong)MMenuView *menuView;
@property(nonatomic,strong)MAdcolumnView *adcolumn;

@end

@implementation CourseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.adcolumn = [[MAdcolumnView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.width / 2)];
    [self.view addSubview:self.adcolumn];
    

    CGRect menuR = CGRectMake(0, self.adcolumn.frame.origin.y+self.adcolumn.frame.size.height, self.view.frame.size.width,
                              self.view.frame.size.height-(self.adcolumn.frame.origin.y+self.adcolumn.frame.size.height)-49);
    
    self.menuView = [[MMenuView alloc]initWithFrame:menuR
                                         itemsArray:@[@"热门课程",@"活动奖励",@"父母教育",@"微课程"]
                                          itemWidth:self.view.frame.size.width/4
                                    itemNormalColor:[UIColor colorWithHexString:KNormalColor alpha:1]
                                    itemSelectColor:[UIColor colorWithHexString:KSelctColor alpha:1]
                                      tableDelegate:self
                                    tableDataSource:self
                                         tableStyle:UITableViewStyleGrouped
                                     separatorStyle:UITableViewCellSeparatorStyleNone];
    self.menuView.delegate =self;
    [self.view addSubview:self.menuView];
    
    datas = [[NSMutableArray alloc]initWithObjects:@[],@[],@[],@[],nil];
    
    self.courseProcess = [[PLCourseProcess alloc]init];
    self.workProcess = [[PLWorkProcess alloc]init];
    
    [self.courseProcess getCourseMainImg:^(NSMutableArray *array)
    {
        [self.adcolumn creatAdcolumn:array];
        
    } didFail:^(NSString *error) {
        
    }];
    
    [self getListData:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark- Action
-(void)ScreenAction:(id)item
{
    [self performSegueWithIdentifier:@"ScreeningIdentifier" sender:nil];
}
-(void)timeAction:(id)item
{
    [self performSegueWithIdentifier:@"ScreeningIdentifier" sender:nil];
}
-(void)seachAction:(id)item
{
    MSearchViewController *screen = [[MSearchViewController alloc]init];
    screen.navigationItem.hidesBackButton = YES;
    [self.navigationController pushViewController:screen animated:NO];
}

#pragma mark-UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger index = tableView.tag-kSubTableViewTag;
    if (datas.count>index)
    {
        return [[datas objectAtIndex:index]count];
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdectifier = @"McourseCell";
    MCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdectifier];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MCourseCell" owner:self options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor colorWithHexString:MListBarkGroundColor alpha:1];
    }
    
    NSInteger index = tableView.tag-kSubTableViewTag;
    NSArray *data = [datas objectAtIndex:index];
   
    if (currentIndex == 0 || currentIndex ==2 || currentIndex ==3)
    {
        PLCourse *course = [data objectAtIndex:indexPath.row];
        [self setCell:cell title:course.courseName content:course.courseContent url:course.courseImgURL];
        
    }else if (currentIndex == 1)
    {
        PLWorks *works = [data objectAtIndex:indexPath.row];
        [self setCell:cell title:works.workTitle content:works.workIntro url:works.workImg];
    }
    return cell;
}
-(void)setCell:(MCourseCell *)cell title:(NSString *)title content:(NSString *)content url:(NSString *)url
{
    cell.titleLabel.text  = title;
    cell.contentLabel.text = content;
    [cell.iconImage setImageWithURL:[NSURL URLWithString:url]
                   placeholderImage:[UIImage imageNamed:@"MAdcolumnView.png"]];
}

#pragma mark -UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 92;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = tableView.tag - kSubTableViewTag;
    if (index == 0)
    {
        [self performSegueWithIdentifier:@"ScreeningIdentifier" sender:indexPath];
    }else
    {
        [self performSegueWithIdentifier:@"PlayIdentifier" sender:indexPath];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PlayIdentifier"])
    {
        NSIndexPath *indexPath = sender;
        
        MPlayVideoViewController *mplay = segue.destinationViewController;
        NSArray *objects = [datas objectAtIndex:currentIndex];
        if (currentIndex == 1)
        {
            mplay.mPlayVideoType = MPlayVideoTypeWorks;
        }
        mplay.objectModel = [objects objectAtIndex:indexPath.row];

    }else if ([segue.identifier isEqualToString:@"ScreeningIdentifier"])
    {
        MScreeningViewController *screening = segue.destinationViewController;
        if (currentIndex == 0)
        {
           screening.courseType = currentIndex;
        }
    }
}

#pragma mark- MMenuViewDelegate
-(void)didMMenuView:(MMenuView *)menuView menuItemTag:(NSInteger)menuItemTag
{
    currentIndex = menuItemTag;
    [self getListData:menuItemTag];
}

#pragma mark- 获取数据

-(void)getListData:(NSInteger)mCurrentIndex
{
    if (datas.count>mCurrentIndex)
    {
        if ([[datas objectAtIndex:mCurrentIndex] count]<=0)
        {
            [self.menuView startAnimationIndicator:mCurrentIndex];
            
            if (mCurrentIndex == 0)
            {//获取热门课程
                
                [self.courseProcess getCourseHostList:^(NSMutableArray *array) {
                    
                    [self reloadTable:mCurrentIndex array:array];
                    
                } didFail:^(NSString *error) {
                    
                    [self setField:mCurrentIndex];
                    
                }];
                
            }else if (mCurrentIndex == 1)
            {//活动奖励
                
                [self.workProcess getMainAwardWorks:^(NSMutableArray *array)
                 {
                     [self reloadTable:mCurrentIndex array:array];
                     
                 } didFail:^(NSString *error) {
                     [self setField:mCurrentIndex];
                 }];
                
                
            }else if (mCurrentIndex == 2)
            {//获取父母教育
                
                [self.courseProcess getCourseMainParents:^(NSMutableArray *array) {
                    
                    [self reloadTable:mCurrentIndex array:array];
                    
                } didFail:^(NSString *error) {
                    
                    [self setField:mCurrentIndex];
                }];
                
            }else if (mCurrentIndex == 3)
            {//获取微课程
                
                [self.courseProcess getCourseMainMicroCourses:^(NSMutableArray *array) {
                    
                    
                    [self reloadTable:mCurrentIndex array:array];
                    
                    
                } didFail:^(NSString *error) {
                    
                    [self setField:mCurrentIndex];
                }];
            }
        }
    }
}

-(void)reloadTable:(NSInteger)mCurrentIndex array:(NSArray*)array
{
    if (array.count==0)
    {
        [self.menuView stopAnimationIndicatorLoadText:@"没有数据!"
                                             withType:NO
                                         mCurentIndex:mCurrentIndex];
    }else
    {
        [self.menuView stopAnimationIndicatorLoadText:@"加载成功!"
                                             withType:YES
                                         mCurentIndex:mCurrentIndex];
        [datas replaceObjectAtIndex:mCurrentIndex withObject:array];
        [self.menuView reloadTableView:mCurrentIndex];
    }
}

-(void)setField:(NSInteger)mCurrentIndex
{
    [self.menuView stopAnimationIndicatorLoadText:@"加载失败!"
                                         withType:NO
                                     mCurentIndex:mCurrentIndex];
}

@end
