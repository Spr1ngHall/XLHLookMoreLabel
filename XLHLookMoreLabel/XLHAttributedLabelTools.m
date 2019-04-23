//
//  XLHAttributedLabelTools.m
//  XLHLookMoreLabel
//
//  Created by 薛立恒 on 2019/3/5.
//  Copyright © 2019 薛立恒. All rights reserved.
//

#import "XLHAttributedLabelTools.h"
#import "NSMutableAttributedString+CTFrameRef.h"

static const CGFloat kMargin = 5;

@implementation XLHAttributedLabelTools

+ (CFIndex)touchContentOffsetInView:(UIView *)view atPoint:(CGPoint)point ctFrame:(CTFrameRef)ctFrame {
    //获取CFArrayRef
    CTFrameRef textFrame = ctFrame;
    CFArrayRef lines = CTFrameGetLines(textFrame);
    if (!lines) {
        return -1;
    }
    CFIndex count = CFArrayGetCount(lines);
    CGPoint origins[count];
    CTFrameGetLineOrigins(textFrame, CFRangeMake(0, 0), origins);
    //翻转坐标系
    CGAffineTransform transform = CGAffineTransformMakeTranslation(0, view.bounds.size.height);
    transform = CGAffineTransformScale(transform, 1.f, -1.f);
    CFIndex index = -1;
    for (CFIndex i = 0; i < count; i++) {
        CGPoint linePoint = origins[i];
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        CGRect flippedRect = CTLineGetTypeGraphicBoundsAsRect(line, linePoint);
        CGRect rect = CGRectApplyAffineTransform(flippedRect, transform);
        rect = CGRectInset(rect, 0, -kMargin);
        
        if (CGRectContainsPoint(rect, point)) {
            //将点击的坐标转换成相对于当前行的坐标
            CGPoint relativeoPoint = CGPointMake(point.x - CGRectGetMinX(rect), point.y - CGRectGetMinY(rect));
            //获取点击位置所处的字符位置,相当于点击了第几个字符
            index = CTLineGetStringIndexForPosition(line, relativeoPoint);
        }
    }
    return index;
}

@end
