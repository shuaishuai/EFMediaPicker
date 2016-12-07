//
//  EFMediaPicker.m
//  modoomed
//
//  Created by Allen on 16/4/27.
//  Copyright © 2016年 ExtantFuture. All rights reserved.
//

#import "EFMediaPicker.h"
#import <MobileCoreServices/UTCoreTypes.h>

@interface EFMediaPicker ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    void(^_pickerHandlerBlock)(id mediaResource,NSString * errorMessage);
}
@end

@implementation EFMediaPicker

+(instancetype)shareInstance{
    static EFMediaPicker *picker = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        picker = [[EFMediaPicker alloc]init];
    });
    return picker;
}

-(void)pickMediaInController:(UIViewController *)controller withPickerType:(EFMediaPickerPickerType)mediaType andHandlerBlock:(void (^)(id, NSString *))handlerBlock{
    _pickerHandlerBlock = handlerBlock;
    if ([self isPickerAvailableWithType:mediaType]){
        self.imagePickerController = [[UIImagePickerController alloc] init];
        [self.imagePickerController setSourceType:(UIImagePickerControllerSourceType)mediaType];// 设置类型
        NSString *requiredMediaType = (NSString *)kUTTypeImage;
        NSArray *arrMediaTypes=[NSArray arrayWithObjects:requiredMediaType,nil];
        [self.imagePickerController setMediaTypes:arrMediaTypes];
        [self.imagePickerController setAllowsEditing:NO];
        [self.imagePickerController setDelegate:self];// 设置代理
        [controller presentViewController:self.imagePickerController animated:YES completion:^{}];
    } else {
        if (_pickerHandlerBlock) {
            _pickerHandlerBlock(nil,ErrorMessageUnavailableMediaType);
            _pickerHandlerBlock = nil;
        }
    }
}

- (void)imagePickCancel
{
    [self.imagePickerController dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark - imagePicker delegate
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{
        if (_pickerHandlerBlock) {
            _pickerHandlerBlock(nil,ErrorMessageUserCancle);
            _pickerHandlerBlock = nil;
        }
    }];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *theImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:^{
        if (_pickerHandlerBlock) {
            _pickerHandlerBlock(theImage,nil);
            _pickerHandlerBlock = nil;
        }
    }];
}
// 媒体类型是否可用
- (BOOL) isPickerAvailableWithType:(EFMediaPickerPickerType)mediaType{
    return [UIImagePickerController isSourceTypeAvailable: (UIImagePickerControllerSourceType)mediaType];
}


@end

NSString * const ErrorMessageUserCancle = @"ErrorMessageUserCancle";
NSString * const ErrorMessageCameraUnAvailable = @"ErrorMessageCameraUnAvailable";
NSString * const ErrorMessagePhotoLibraryUnAvailable = @"ErrorMessagePhotoLibraryUnAvailable";
NSString * const ErrorMessageUnavailableMediaType = @"ErrorMessageUnavailableMediaType";
