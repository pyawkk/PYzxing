//
//  ViewController.m
//  PYzxing
//
//  Created by panyong on 15/3/26.
//  Copyright (c) 2015年 mobileNowGroup. All rights reserved.
//

#import "ViewController.h"
#import <ZXingObjC/ZXingObjC.h>
#import <AVFoundation/AVFoundation.h> 

//#import "ZXQRCodeReader.h"


@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    NSMutableSet *qrReader;
    BOOL scanningQR;
}

@property (weak, nonatomic) IBOutlet UIImageView *myPIC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button3 setTitle:@"从相册选择" forState:UIControlStateNormal];
    [button3 setFrame:CGRectMake(100, 270, 140, 50)];
    [button3 addTarget:self action:@selector(pressButton3:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
}

-(void)getURLWithImage:(UIImage *)img{
    
    UIImage *loadImage= img;
    CGImageRef imageToDecode = loadImage.CGImage;
    
    ZXLuminanceSource *source = [[ZXCGImageLuminanceSource alloc] initWithCGImage:imageToDecode];
    ZXBinaryBitmap *bitmap = [ZXBinaryBitmap binaryBitmapWithBinarizer:[ZXHybridBinarizer binarizerWithSource:source]];
    
    NSError *error = nil;
    
    ZXDecodeHints *hints = [ZXDecodeHints hints];
    
    ZXMultiFormatReader *reader = [ZXMultiFormatReader reader];
    ZXResult *result = [reader decode:bitmap
                                hints:hints
                                error:&error];
    if (result) {
        // The coded result as a string. The raw data can be accessed with
        // result.rawBytes and result.length.
        NSString *contents = result.text;
        NSLog(@"contents =%@",contents);
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"解析成功" message:contents delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alter show];

    } else {
        UIAlertView *alter1 = [[UIAlertView alloc] initWithTitle:@"解析失败" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alter1 show];
    }
}




- (IBAction)encode:(id)sender {
    
     UIImage *loadImage= self.myPIC.image;
    CGImageRef imageToDecode = loadImage.CGImage;
    
    ZXLuminanceSource *source = [[ZXCGImageLuminanceSource alloc] initWithCGImage:imageToDecode];
    ZXBinaryBitmap *bitmap = [ZXBinaryBitmap binaryBitmapWithBinarizer:[ZXHybridBinarizer binarizerWithSource:source]];
    
    NSError *error = nil;
    
    ZXDecodeHints *hints = [ZXDecodeHints hints];
    
    ZXMultiFormatReader *reader = [ZXMultiFormatReader reader];
    ZXResult *result = [reader decode:bitmap
                                hints:hints
                                error:&error];
    if (result) {
        NSString *contents = result.text;
        NSLog(@"contents =%@",contents);
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"解析地址" message:contents delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alter show];
    } else {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"解析失败" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alter show];
    }
}


- (void)pressButton3:(UIButton *)button
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.allowsEditing = YES;
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:^{}];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    [self dismissViewControllerAnimated:YES completion:^{
        [self getURLWithImage:image];
    }
    ];

}

- (IBAction)writePIC:(id)sender {
    
    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"11.jpg" ofType:nil];
    
    UIImage *image = [UIImage imageWithContentsOfFile:strPath];
    
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    UIAlertView *alter =  [[UIAlertView alloc] initWithTitle:@"写入成功" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alter show];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
