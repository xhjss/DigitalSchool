//
//  MUploadWorksViewController.h
//  DigitalSchool
//
//  Created by 刘军林 on 15/1/19.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MBaseViewController.h"
#import "UIKeyboardViewController.h"

@interface MUploadWorksViewController : MBaseViewController
@property (nonatomic, strong) IBOutlet UITextField *worksName;

@property (nonatomic, strong) UIKeyboardViewController *keyboard;

-(IBAction)uploadComplete:(id)sender;
-(IBAction)uploadImage:(id)sender;
-(IBAction)uploadVido:(id)sender;

@end
