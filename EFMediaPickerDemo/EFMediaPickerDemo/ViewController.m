//
//  ViewController.m
//  EFMediaPickerDemo
//
//  Created by Allen on 2016/12/7.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import "ViewController.h"
#import "EFMediaPicker.h"
@interface ViewController ()
@property (nonatomic, strong)UIImageView *mediaImage;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mediaImage];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)buttonClick:(id)sender {
    [ShareMediaPicker pickMediaInController:self withPickerType:EFMediaPickerPickerTypeImage_Photo andHandlerBlock:^(id mediaResource, NSString *errorMessage) {
        if (errorMessage) {
            NSLog(@"%@",errorMessage);
        }else{
            self.mediaImage.image = (UIImage *)mediaResource;
        }
    }];
}

- (UIImageView *)mediaImage{
    if (_mediaImage == nil) {
        _mediaImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 200)];
    }
    return _mediaImage;
}

@end
