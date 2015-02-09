//
//  PLLookCourse.h
//  DigitalSchool
//
//  Created by 刘军林 on 15/1/30.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "PLBaseData.h"
#import "PLCourse.h"

@interface PLLookCourse : PLBaseData

@property (nonatomic, strong) NSString *lookId;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *watchTime;
@property (nonatomic, strong) PLCourse *course;

@end
