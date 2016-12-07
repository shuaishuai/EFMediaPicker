//
//  EFMediaPicker.h
//  modoomed
//
//  Created by Allen on 16/4/27.
//  Copyright © 2016年 ExtantFuture. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
extern NSString * const ErrorMessageUserCancle;
extern NSString * const ErrorMessageCameraUnAvailable;
extern NSString * const ErrorMessagePhotoLibraryUnAvailable;
extern NSString * const ErrorMessageUnavailableMediaType;

#define ShareMediaPicker [EFMediaPicker shareInstance]

typedef NS_ENUM(NSInteger,EFMediaPickerPickerType) {
    EFMediaPickerPickerTypeImage_Photo = 0,   //图库
    EFMediaPickerPickerTypeImage_Camera,      //相机
    EFMediaPickerPickerTypeVideo              //暂不支持获取视频
};
@interface EFMediaPicker : NSObject

@property (nonatomic, strong) UIImagePickerController *imagePickerController;

+(instancetype)shareInstance;

-(void)pickMediaInController:(UIViewController *)controller withPickerType:(EFMediaPickerPickerType)mediaType  andHandlerBlock:(void(^)(id mediaResource,NSString * errorMessage))handlerBlock;

- (void)imagePickCancel;
@end
