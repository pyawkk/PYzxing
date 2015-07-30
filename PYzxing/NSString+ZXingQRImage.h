//
//  NSString+ZXingQRImage.h
//  Jiazhi
//
//  Created by 潘勇 on 15/7/23.
//  Copyright (c) 2015年 mobilenowgroup. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIImage;

@interface NSString (ZXingQRImage)


/**
 *  生成QR码图像
 *
 *  @param qrString url地址
 *  @param width    生成图片的宽度
 *  @param height   生成图片的高度
 *
 *  @return UIImage图片
 */
+(UIImage *)becomeQRCodeWithQRstring:(NSString *)qrURLString withWidth:(int)width withHight:(int)height;

@end
