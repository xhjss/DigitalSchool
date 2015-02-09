//
//  LiveViewController.m
//  DigitalScholl
//
//  Created by rachel on 15/1/6.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "LiveViewController.h"
#import "MScreeningMenu.h"

#import "MScreeningViewController.h"
#import "MPlayVideoViewController.h"

@interface LiveViewController ()

@end

@implementation LiveViewController

- (void)viewDidLoad {
    
//    NSString *urlStr = [NSString stringWithFormat:@"<html><head>\
//                        <meta name = \"viewport\" content = \"initial-scale = 1.0, user-scalable = no, width = 320\"/></head>\
//                        <body style=\"background:#000;margin-top:0px;margin-left:0px\">\
//                        <iframe id=\"ytplayer\" type=\"text/html\" width=\"320\" height=\"200\"\
//                        src=\"%@?autoplay=0\"\
//                        frameborder=\"0\"/>\
//                        </body></html>",  @"http://edu.360fis.com/edu/xsyy/xsyy1.mp4"];
//    self.webView.allowsInlineMediaPlayback = YES;
//    self.webView.mediaPlaybackRequiresUserAction = NO;
//    [self.webView loadHTMLString:urlStr baseURL:nil];
    [super viewDidLoad];

    
//    UIButton *butt = [UIButton buttonWithType:UIButtonTypeContactAdd];
//    butt.frame = CGRectMake(10, 80, 40, 40);
//    [butt addTarget:self action:@selector(adction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:butt];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.baseTableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.baseTableView setContentOffset:CGPointMake(0, 0)];
}

-(void) viewDidAppear:(BOOL)animated
{
    [self.baseTableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.baseTableView setContentOffset:CGPointMake(0, 0)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)adction
{
    MScreeningViewController *view = [[MScreeningViewController alloc]init];
    [self.navigationController pushViewController:view animated:YES];
}

#pragma mark-
#pragma mark UITableViewDelegate
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.baseRect.size.width/2;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ActivitiesCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MPlayVideoViewController *play = [[MPlayVideoViewController alloc] init];
    [self presentViewController:play animated:YES completion:nil];
//    [self performSegueWithIdentifier:@"Download" sender:nil];
}



@end
