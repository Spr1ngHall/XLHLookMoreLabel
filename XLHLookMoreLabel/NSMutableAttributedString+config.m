//
//  NSMutableAttributedString+config.m
//  XLHLookMoreLabel
//
//  Created by 薛立恒 on 2019/3/5.
//  Copyright © 2019 薛立恒. All rights reserved.
//

#import "NSMutableAttributedString+config.h"
#import <CoreText/CoreText.h>

//检查URL/@/##/手机号
static NSString * const pattern = @"";

@implementation NSMutableAttributedString (config)

//设置颜色
- (void)setTextColor:(UIColor *)color {
    [self setTextColor:color range:NSMakeRange(0, [self length])];
}

- (void)setTextColor:(UIColor *)color range:(NSRange)range {
    if (color.CGColor) {
        [self removeAttribute:(NSString *)kCTForegroundColorAttributeName range:range];
        [self addAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)color.CGColor range:range];
    }
}

//设置字体
- (void)setFont:(UIFont *)font {
    [self setFont:font range:NSMakeRange(0, [self length])];
}

- (void)setFont:(UIFont *)font range:(NSRange)range {
    if (font) {
        [self removeAttribute:(NSString *)kCTForegroundColorAttributeName range:range];
        CTFontRef fontRef = CTFontCreateWithName((CFStringRef)font.fontName, font.pointSize, nil);
        if (nil != fontRef) {
            [self addAttribute:(NSString *)kCTForegroundColorAttributeName value:(__bridge id)fontRef range:range];
        }
    }
}

//设置属性
- (NSMutableAttributedString *)setAttributedsWithLineSpacing:(CGFloat)lineSpacing
                                         andParagraphSapcing:(CGFloat)paragraphSpacing
                                            andTextAlignment:(CTTextAlignment)textAlignment
                                            andLineBreakMode:(CTLineBreakMode)lineBreakMode {
    //设置行间距
    const CFIndex kNumberOfSettings = 6;
    CTParagraphStyleSetting theSettings[kNumberOfSettings] = {
        {kCTParagraphStyleSpecifierLineBreakMode,sizeof(uint8_t),&lineBreakMode},
        {kCTParagraphStyleSpecifierAlignment,sizeof(uint8_t),&textAlignment},
        {kCTParagraphStyleSpecifierParagraphSpacing,sizeof(CGFloat),&paragraphSpacing},
        {kCTParagraphStyleSpecifierLineSpacingAdjustment,sizeof(CGFloat),&lineSpacing},
        {kCTParagraphStyleSpecifierMaximumLineSpacing,sizeof(CGFloat),&lineSpacing},
        {kCTParagraphStyleSpecifierMinimumLineSpacing,sizeof(CGFloat),&lineSpacing}
    };
    CTParagraphStyleRef theParagraphRef = CTParagraphStyleCreate(theSettings, kNumberOfSettings);
    [self addAttribute:(id)kCTParagraphStyleAttributeName value:(__bridge id)theParagraphRef range:NSMakeRange(0, [self length])];
    CFRelease(theParagraphRef);
    return self;
}

@end
