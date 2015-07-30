//
//  NSString+ZXingQRImage.m
//  Jiazhi
//
//  Created by 潘勇 on 15/7/23.
//  Copyright (c) 2015年 mobilenowgroup. All rights reserved.
//

#import "NSString+ZXingQRImage.h"

//ZXING
#import "ZXMultiFormatWriter.H"
#import "ZXImage.h"

#import <UIKit/UIImage.h>

@implementation NSString (ZXingQRImage)

+(UIImage *)becomeQRCodeWithQRstring:(NSString *)qrURLString withWidth:(int)width withHight:(int)height{
    
//    NSError *error = nil;
    ZXMultiFormatWriter *writer = [ZXMultiFormatWriter writer];
    ZXBitMatrix* result = [writer encode:qrURLString
                                  format:kBarcodeFormatQRCode
                                   width:width
                                  height:height
                                   error:nil];//err 不写了
    
    CGImageRef image = [[ZXImage imageWithMatrix:result] cgimage];
    UIImage *qrImage = [UIImage imageWithCGImage:image];
    return qrImage;
}

@end
