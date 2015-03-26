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
    [button3 setFrame:CGRectMake(50, 300, 140, 50)];
    [button3 addTarget:self action:@selector(pressButton3:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
//    qrReader = [[NSMutableSet alloc ] init];
//    ZXQRCodeReader* qrcodeReader = [[ZXQRCodeReader alloc] init];
//    [qrReader addObject:qrcodeReader];
//    scanningQR = NO;

//    self.step = STEP_QR;

}

// AVFoundation的回调函数
//- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
//    // 第一步，将sampleBuffer转成UIImage
//    UIImage *image= [self getCaptureImage:sampleBuffer];
//    // 第二步，用Decoder识别图象
//    Decoder *d = [[Decoder alloc] init];
//    d.readers = self.qrReader;
//    d.delegate = self;
//    self.scanningQR = [d decodeImage:image] == YES ? NO : YES;
//}


- (void)decodeImage:(UIImage *)image
{
    NSMutableSet *qrReader = [[NSMutableSet alloc] init];
        ZXQRCodeReader *qrcoderReader = [[ZXQRCodeReader alloc] init];
        [qrReader addObject:qrcoderReader];
    

    
        ZXAztecDecoder *decoder = [[ZXAztecDecoder alloc] init];
    
    
    
    
    
    
//        decoder.delegate = self;
//        decoder.readers = qrReader;
//        [decoder decodeImage:image];
}


-(void)getURLWithImage:(UIImage *)img{
    
    UIImage *loadImage= img;
    CGImageRef imageToDecode = loadImage.CGImage;
    
    
    // Given a CGImage in which we are looking for barcodes
    
    ZXLuminanceSource *source = [[ZXCGImageLuminanceSource alloc] initWithCGImage:imageToDecode];
    ZXBinaryBitmap *bitmap = [ZXBinaryBitmap binaryBitmapWithBinarizer:[ZXHybridBinarizer binarizerWithSource:source]];
    
    NSError *error = nil;
    
    // There are a number of hints we can give to the reader, including
    // possible formats, allowed lengths, and the string encoding.
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
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"成功" message:contents delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alter show];
        // The barcode format, such as a QR code or UPC-A
        //        ZXBarcodeFormat format = result.barcodeFormat;
    } else {
        NSLog(@"解析错误");
        // Use error to determine why we didn't get a result, such as a barcode
        // not being found, an invalid checksum, or a format inconsistency.
    }

    
    
}




- (IBAction)encode:(id)sender {
    
     UIImage *loadImage= self.myPIC.image;
    CGImageRef imageToDecode = loadImage.CGImage;
    

    // Given a CGImage in which we are looking for barcodes
    
    ZXLuminanceSource *source = [[ZXCGImageLuminanceSource alloc] initWithCGImage:imageToDecode];
    ZXBinaryBitmap *bitmap = [ZXBinaryBitmap binaryBitmapWithBinarizer:[ZXHybridBinarizer binarizerWithSource:source]];
    
    NSError *error = nil;
    
    // There are a number of hints we can give to the reader, including
    // possible formats, allowed lengths, and the string encoding.
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
        // The barcode format, such as a QR code or UPC-A
//        ZXBarcodeFormat format = result.barcodeFormat;
    } else {
        NSLog(@"失败");
        // Use error to determine why we didn't get a result, such as a barcode
        // not being found, an invalid checksum, or a format inconsistency.
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
//        [self decodeImage:image];
        [self getURLWithImage:image];
    }
    ];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
