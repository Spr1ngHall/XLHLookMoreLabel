//
//  XLHAttributedLabelTools.h
//  XLHLookMoreLabel
//
//  Created by 薛立恒 on 2019/3/5.
//  Copyright © 2019 薛立恒. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

NS_ASSUME_NONNULL_BEGIN

@interface XLHAttributedLabelTools : NSObject

//将点击的位置转换成字符串的偏移量,如果没有找到,则返回-1
+ (CFIndex)touchContentOffsetInView:(UIView *)view atPoint:(CGPoint)point ctFrame:(CTFrameRef)ctFrame;

@end

NS_ASSUME_NONNULL_END
