//
//  NSMutableAttributedString+CTFrameRef.m
//  XLHLookMoreLabel
//
//  Created by 薛立恒 on 2019/3/5.
//  Copyright © 2019 薛立恒. All rights reserved.
//

#import "NSMutableAttributedString+CTFrameRef.h"

static CGFloat const kMaxFloat = 10000.0f;

@implementation NSMutableAttributedString (CTFrameRef)

NSRange NSRangeFromCFRange(CFRange range) {
    return NSMakeRange((NSUInteger)range.location, (NSUInteger)range.length);
}

BOOL CTRunContainerCharactersFromStringRange(CTRunRef run, NSRange range) {
    NSRange runRange = NSRangeFromCFRange(CTRunGetStringRange(run));
    NSRange intersectedRange = NSIntersectionRange(runRange, range);
    return (intersectedRange.length <= 0);
    
}

BOOL CTLineContainerCharactersFromStringRange(CTLineRef line, NSRange range) {
    NSRange lineRange = NSRangeFromCFRange(CTLineGetStringRange(line));
    NSRange intersectedRange = NSIntersectionRange(lineRange, range);
    return (intersectedRange.length <= 0);
}

CGRect CTRunGetTypeGraphicBoundsAsRect(CTRunRef run, CTLineRef line, CGPoint lineOrigin) {
    CGFloat ascent = 0.0f;
    CGFloat descent = 0.0f;
    CGFloat leading = 0.0f;
    CGFloat width = (CGFloat)CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, &leading);
    CGFloat height = ascent + descent;
    CGFloat xOffset = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);
    return CGRectMake(lineOrigin.x + xOffset - leading, lineOrigin.y - descent, width + leading, height);
}

CGRect CTLineGetTypeGraphicBoundsAsRect(CTLineRef line, CGPoint lineOrigin) {
    CGFloat ascent = 0.0f;
    CGFloat descent = 0.0f;
    CGFloat leading = 0.0f;
    CGFloat width = (CGFloat)CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    CGFloat height = ascent + descent;
    return CGRectMake(lineOrigin.x, lineOrigin.y - descent, width, height);
}

CGRect CTRunGetTypeGraphicBoundsForLinkRect(CTLineRef line, NSRange range, CGPoint lineOrigin) {
    CGRect rectForRange = CGRectZero;
    CFArrayRef runs = CTLineGetGlyphRuns(line);
    CFIndex runCount = CFArrayGetCount(runs);
    for (CFIndex i = 0; i < runCount; i ++) {
        CTRunRef run = CFArrayGetValueAtIndex(runs, i);
        if (CTRunContainerCharactersFromStringRange(run, range)) {
            continue;
        }
        CGRect linkRect = CTRunGetTypeGraphicBoundsAsRect(run, line, lineOrigin);
        linkRect.origin.y = roundf(linkRect.origin.y);
        linkRect.origin.x = roundf(linkRect.origin.x);
        linkRect.size.width = roundf(linkRect.size.width);
        linkRect.size.height = roundf(linkRect.size.height);
        rectForRange = CGRectIsEmpty(rectForRange) ? linkRect : CGRectUnion(rectForRange, linkRect);
    }
    return rectForRange;
}

//获取CTFrameRef
- (CTFrameRef)prepareFrameRefWithWidth:(CGFloat)width {
    //创建CTFramesetterRef的实例
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)self);
    //获得要缓制的区域的高度
    CGSize restrictSize = CGSizeMake(width, kMaxFloat);
    CGSize coreTextSize = CTFramesetterSuggestFrameSizeWithConstraints(frameSetter, CFRangeMake(0, 0), nil, restrictSize, nil);
    CTFrameRef frameRef = [self p_createFrameWithFrameSetter:frameSetter width:width height:coreTextSize.height];
    return frameRef;
}

- (CTFrameRef)p_createFrameWithFrameSetter:(CTFramesetterRef)frameSetter width:(CGFloat)width height:(CGFloat)height {
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathAddRect(pathRef, NULL, CGRectMake(0, 0, width, height));
    CTFrameRef frameRef = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), pathRef, NULL);
    CFRelease(pathRef);
    return frameRef;
}

//获取label高度
- (CGFloat)boundingHeightForWidth:(CGFloat)width {
    return [self boundingHeightForWidth:width numberOfLines:0];
}

//获取固定行数的高度
- (CGFloat)boundingHeightForWidth:(CGFloat)width numberOfLines:(NSUInteger)numberOfLines {
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)self);
    CFRange range = CFRangeMake(0, 0);
    if (numberOfLines > 0 && framesetter) {
        CTFrameRef frameRef = [self p_createFrameWithFrameSetter:framesetter width:width height:MAXFLOAT];
        CFArrayRef lines = CTFrameGetLines(frameRef);
        if (nil != lines && CFArrayGetCount(lines) > 0) {
            NSInteger lastVisibleLineIndex = MIN(numberOfLines, CFArrayGetCount(lines)) - 1;
            CTLineRef lastVisibleLine = CFArrayGetValueAtIndex(lines, lastVisibleLineIndex);
            CFRange rangeToLayout = CTLineGetStringRange(lastVisibleLine);
            range = CFRangeMake(0, rangeToLayout.location + rangeToLayout.length);
        }
        CFRelease(frameRef);
    }
    CGSize newSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, range, NULL, CGSizeMake(width, MAXFLOAT), NULL);
    return newSize.height;
}





@end
