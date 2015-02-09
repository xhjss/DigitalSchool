//
//  PLCourseProcess.m
//  DigitalSchool
//
//  Created by 刘军林 on 15/1/27.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "PLCourseProcess.h"
#import "PLInterface.h"
#import "BLTool.h"
#import "PLCourse.h"
#import "PLLookCourse.h"

@implementation PLCourseProcess

-(void) getCourseMainImg:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    [PLInterface startRequest:ALL_URL didUrl:COURSE_MAIN([BLTool getKeyCode:@""]) didParam:nil didSuccess:^(id result){
        [self dataFormat:result didClass:NSStringFromClass([PLCourse class]) didSuccess:success didFail:fail];
    }didFail:^(NSString *error){
        fail(REQUEST_ERROR);
    }];
}

-(void) getCourseHostList:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    [PLInterface startRequest:ALL_URL didUrl:COURSE_HOTS([BLTool getKeyCode:@""]) didParam:nil didSuccess:^(id result){
        [self dataFormat:result didClass:NSStringFromClass([PLCourse class]) didSuccess:success didFail:fail];
    }didFail:^(NSString *error){
        fail(REQUEST_ERROR);
    }];
}

-(void) getCourseMainParents:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    NSString *url = [NSString stringWithFormat:@"2/%@",[BLTool getKeyCode:@"2"]];
    
    [PLInterface startRequest:ALL_URL didUrl:COURSE_TYPE(url) didParam:nil didSuccess:^(id result){
        [self dataFormat:result didClass:NSStringFromClass([PLCourse class]) didSuccess:success didFail:fail];
    }didFail:^(NSString *error){
        fail(REQUEST_ERROR);
    }];
}

-(void) getCourseMainMicroCourses:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    NSString *url = [NSString stringWithFormat:@"3/%@",[BLTool getKeyCode:@"3"]];
    
    [PLInterface startRequest:ALL_URL didUrl:COURSE_TYPE(url) didParam:nil didSuccess:^(id result){
        [self dataFormat:result didClass:NSStringFromClass([PLCourse class]) didSuccess:success didFail:fail];
    }didFail:^(NSString *error){
        fail(REQUEST_ERROR);
    }];
}

-(void) getCourseFilter:(int)pageSize didCurrentPage:(int)currentPage didGrade:(int)grade didSubject:(int)subject didTeacher:(int)teacher didType:(int)type didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    NSString *code = [NSString stringWithFormat:@"%d%d%d%d%d%d",pageSize, currentPage, grade, subject, teacher, type];
    NSString *url = [NSString stringWithFormat:@"%d/%d/%d/%d/%d/%d/%@",pageSize, currentPage, grade, subject, teacher, type, [BLTool getKeyCode:code]];
    
    [PLInterface startRequest:ALL_URL didUrl:COURSE_FILTER(url)  didParam:nil didSuccess:^(id result){
        [self dataFormat:result didClass:NSStringFromClass([PLCourse class]) didSuccess:success didFail:fail];
    }didFail:^(NSString *error){
        fail(REQUEST_ERROR);
    }];
}

-(void) getCourseSearch:(int)pageSize didCurrentPage:(int)currentPage didSearch:(NSString *)searchStr didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    NSString *code = [NSString stringWithFormat:@"%d%d%@",pageSize, currentPage, [BLTool getEncoding:searchStr]];
    NSString *url = [NSString stringWithFormat:@"%d/%d/%@/%@",pageSize, currentPage, [BLTool getEncoding:searchStr], [BLTool getKeyCode:code]];
    
    [PLInterface startRequest:ALL_URL didUrl:COURSE_SEARCH(url) didParam:nil didSuccess:^(id result){
        [self dataFormat:result didClass:NSStringFromClass([PLCourse class]) didSuccess:success didFail:fail];
    }didFail:^(NSString *error){
        fail(REQUEST_ERROR);
    }];
}

-(void) getCourseConditionList:(CallBackBlockSuccess )success didFail:(CallBackBlockFail)fail
{
    [PLInterface startRequest:ALL_URL didUrl:COURSE_CONDITION([BLTool getKeyCode:@""]) didParam:nil didSuccess:^(id result){
        
        NSMutableArray *list = [[NSMutableArray alloc] init];
        if ([[result objectForKey:@"ret"] isEqualToNumber:[NSNumber numberWithInt:0]]) {
            NSMutableArray *gradeList = [NSMutableArray arrayWithArray:[[[result objectForKey:@"data"] objectAtIndex:0] objectForKey:@"gradeList"]];
            if (gradeList) {
                [gradeList insertObject:@{@"id":@"0", @"name":@"全部"} atIndex:0];
            }
            
            NSMutableArray *subjectList = [NSMutableArray arrayWithArray:[[[result objectForKey:@"data"] objectAtIndex:1] objectForKey:@"subjectList"]];
            if (subjectList) {
                [subjectList insertObject:@{@"id":@"0", @"name":@"全部"} atIndex:0];
            }
            
            NSMutableArray *teacherList = [NSMutableArray arrayWithArray:[[[result objectForKey:@"data"] objectAtIndex:2] objectForKey:@"teacherList"]];
            if (teacherList) {
                [teacherList insertObject:@{@"id":@"0", @"name":@"全部"} atIndex:0];
            }
            
            [list addObject:gradeList];
            [list addObject:subjectList];
            [list addObject:teacherList];
        }
        success(list);
    }didFail:^(NSString *error){
        fail(REQUEST_ERROR);
    }];
}

-(void) submitCourseLookRecord:(NSString *)courseId didUser:(NSString *)userId didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    NSString *code = [BLTool getKeyCode:[NSString stringWithFormat:@"%@%@%@",courseId, userId,@"0"]];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:courseId forKey:@"courseId"];
    [dic setObject:userId forKey:@"userId"];
    [dic setObject:code forKey:@"code"];
    [dic setObject:@"0" forKey:@"type"];
    [PLInterface startRequest:ALL_URL didUrl:COURSE_SAVE_WATCH didParam:dic didSuccess:^(id result){
        [self dataFormatPost:result didSuccess:success didFail:fail];
    }didFail:^(NSString *error){
        fail(REQUEST_ERROR);
    }];
}

-(void) getCourseLookRecord:(NSString *)userId didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    NSString *code = [BLTool getKeyCode:[NSString stringWithFormat:@"%@%@",userId,@"0"]];
    NSString *url = [NSString stringWithFormat:@"%@/%@/%@",userId,@"0",code];
    [PLInterface startRequest:ALL_URL didUrl:COURSE_GET_WATCH(url) didParam:nil didSuccess:^(id result){
        [self dataFormat:result didClass:NSStringFromClass([PLLookCourse class]) didSuccess:success didFail:fail];
    }didFail:^(NSString *error){
        fail(REQUEST_ERROR);
    }];
}

-(void) attentionCourse:(NSString *)courseId didUser:(NSString *)userId didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    NSString *code = [BLTool getKeyCode:[NSString stringWithFormat:@"%@%@",courseId, userId]];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:courseId forKey:@"courseId"];
    [dic setObject:userId forKey:@"userId"];
    [dic setObject:code forKey:@"code"];
    [PLInterface startRequest:ALL_URL didUrl:COURSE_ATTENTION didParam:dic didSuccess:^(id result){
        [self dataFormatPost:result didSuccess:success didFail:fail];
    }didFail:^(NSString *error){
        fail(REQUEST_ERROR);
    }];
}

-(void) cancelAttentionCourse:(NSString *)courseId didUser:(NSString *)userId didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    NSString *code = [BLTool getKeyCode:[NSString stringWithFormat:@"%@%@",courseId, userId]];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:courseId forKey:@"courseId"];
    [dic setObject:userId forKey:@"userId"];
    [dic setObject:code forKey:@"code"];
    [PLInterface startRequest:ALL_URL didUrl:COURSE_CANCEL_ATTENTION didParam:dic didSuccess:^(id result){
        [self dataFormatPost:result didSuccess:success didFail:fail];
    }didFail:^(NSString *error){
        fail(REQUEST_ERROR);
    }];
}

-(void) getAttentionCourse:(int)pageSize didCurrentPage:(int)currentPage diduserId:(NSString *)userId didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    NSString *code = [BLTool getKeyCode:[NSString stringWithFormat:@"%d%d%@",pageSize, currentPage, userId]];
    NSString *url = [NSString stringWithFormat:@"%d/%d/%@/%@",pageSize, currentPage, userId, code];
    [PLInterface startRequest:ALL_URL didUrl:COURSE_GET_ATTENTIONS(url) didParam:nil didSuccess:^(id result){
        [self dataFormat:result didClass:NSStringFromClass([PLCourse class]) didSuccess:success didFail:fail];
    }didFail:^(NSString *error){
        fail(REQUEST_ERROR);
    }];
}

@end
