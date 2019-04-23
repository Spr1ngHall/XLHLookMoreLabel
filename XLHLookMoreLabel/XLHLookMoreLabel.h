//
//  XLHLookMoreLabel.h
//  XLHLookMoreLabel
//
//  Created by 薛立恒 on 2019/3/5.
//  Copyright © 2019 薛立恒. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class XLHLookMoreLabel;
typedef NS_ENUM(NSInteger, XLHLabelState) {
    XLHNormalState,
    XLHOpenState,
    XLHCloseState
};

@protocol XLHAttributedLabelDelegate <NSObject>

@required
- (void)displayView:(XLHLookMoreLabel *)label openHeight:(CGFloat)height;
- (void)displayview:(XLHLookMoreLabel *)label closeHeight:(CGFloat)height;

@end

@interface XLHLookMoreLabel : UIView

@property(nonatomic,weak) id<XLHAttributedLabelDelegate> delegate;

/** 字体 */
@property(nonatomic,strong) UIFont *font;
/** 文字颜色 */
@property(nonatomic,strong) UIColor *textColor;
/** 文字的排版样式 */
@property(nonatomic,assign) CTTextAlignment textAlignment;
/** LineBreakMode */
@property(nonatomic,assign) CTLineBreakMode lineBreakMode;
/** 行间距 */
@property(nonatomic,assign) CGFloat lineSpacing;
/** 段间距 */
@property(nonatomic,assign) CGFloat paragraphSpacing;
/** 行数 */
@property(nonatomic,assign) NSInteger numberOfLines;
/** label的状态(开,关,默认) */
@property(nonatomic,assign) XLHLabelState state;


//获得大小
- (CGSize)sizeThatFits:(CGSize)size;
//传入普通文本
- (void)setText:(NSString *)text;
//传入属性文本
- (void)setAttributedText:(NSAttributedString *)attributedText;
//添加展开开关闭按钮
- (void)setOpenString:(NSString *)openString andCloseString:(NSString *)closeString;
- (void)setOpenString:(NSString *)openString andCloseString:(NSString *)closeString andFont:(UIFont *)font andTextColor:(UIColor *)textColor;

@end

NS_ASSUME_NONNULL_END
