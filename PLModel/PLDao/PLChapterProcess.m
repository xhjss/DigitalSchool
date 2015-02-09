//
//  PLChapterProcess.m
//  DigitalSchool
//
//  Created by 刘军林 on 15/2/5.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "PLChapterProcess.h"

@implementation PLChapterProcess

-(void) getChapterCorrelationList:(int)pageSize didCurrentPage:(int)currentPage didGradeId:(NSString *)gradeId didCatalogId:(NSString *)catalogId didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    NSString *code = [BLTool getKeyCode:[NSString stringWithFormat:@"%d%d%@%@",pageSize, currentPage, gradeId, catalogId]];
    NSString *url = [NSString stringWithFormat:@"%d/%d/%@/%@/%@", pageSize, currentPage, gradeId, catalogId, code];
    [PLInterface startRequest:ALL_URL didUrl:CHAPTER_CORRELATION(url) didParam:nil didSuccess:^(id result) {
        
    } didFail:^(NSString *error) {
        
    }];
}

@end
