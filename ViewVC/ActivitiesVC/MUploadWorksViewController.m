//
//  MUploadWorksViewController.m
//  DigitalSchool
//
//  Created by 刘军林 on 15/1/19.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MUploadWorksViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>

@interface MUploadWorksViewController ()
<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation MUploadWorksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.worksName becomeFirstResponder];
    _keyboard = [[UIKeyboardViewController alloc] initWithControllerDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -Action
-(IBAction)uploadComplete:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)uploadImage:(id)sender
{
    [self presentImagePicke:NO];
}
-(IBAction)uploadVido:(id)sender
{
    [self presentImagePicke:YES];
}

-(void)presentImagePicke:(BOOL)isVideo
{
    UIImagePickerController *imagePicke = [[UIImagePickerController alloc]init];
    if (isVideo)
    {
        imagePicke.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        imagePicke.mediaTypes = @[(NSString *)kUTTypeMovie];
    }else
    {
        imagePicke.allowsEditing = YES;
    }
    imagePicke.delegate = self;
    [self presentViewController:imagePicke animated:YES completion:nil];
}

#pragma mark- UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"1:=%@",picker.mediaTypes);
    if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary)
    {
        //照片选取
        
        
    }else
    {
        //视频选取
        
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
