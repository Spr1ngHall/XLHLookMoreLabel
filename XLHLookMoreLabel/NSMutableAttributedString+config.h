//
//  NSMutableAttributedString+config.h
//  XLHLookMoreLabel
//
//  Created by 薛立恒 on 2019/3/5.
//  Copyright © 2019 薛立恒. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableAttributedString (config)

//设置颜色
- (void)setTextColor:(UIColor *)color;
- (void)setTextColor:(UIColor *)color range:(NSRange)range;

//设置字体
- (void)setFont:(UIFont *)font;
- (void)setFont:(UIFont *)font range:(NSRange)range;

//设置属性
- (NSMutableAttributedString *)setAttributedsWithLineSpacing:(CGFloat)lineSpacing
                                         andParagraphSapcing:(CGFloat)paragraphSpacing
                                            andTextAlignment:(CTTextAlignment)textAlignment
                                            andLineBreakMode:(CTLineBreakMode)lineBreakMode;

@end

NS_ASSUME_NONNULL_END
