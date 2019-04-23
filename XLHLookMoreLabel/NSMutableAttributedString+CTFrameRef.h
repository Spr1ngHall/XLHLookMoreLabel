//
//  NSMutableAttributedString+CTFrameRef.h
//  XLHLookMoreLabel
//
//  Created by 薛立恒 on 2019/3/5.
//  Copyright © 2019 薛立恒. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableAttributedString (CTFrameRef)

NSRange NSRangeFromCFRange(CFRange range);

BOOL CTRunContainerCharactersFromStringRange(CTRunRef run, NSRange range);
BOOL CTLineContainerCharactersFromStringRange(CTLineRef line, NSRange range);

CGRect CTRunGetTypeGraphicBoundsAsRect(CTRunRef run, CTLineRef line, CGPoint lineOrigin);
CGRect CTLineGetTypeGraphicBoundsAsRect(CTLineRef line, CGPoint lineOrigin);
CGRect CTRunGetTypeGraphicBoundsForLinkRect(CTLineRef line, NSRange range, CGPoint lineOrigin);

//获取CTFrameRef
- (CTFrameRef)prepareFrameRefWithWidth:(CGFloat)width;
//获取label高度
- (CGFloat)boundingHeightForWidth:(CGFloat)width;
//获取固定行数的高度
- (CGFloat)boundingHeightForWidth:(CGFloat)width numberOfLines:(NSUInteger)numberOfLines;

@end

NS_ASSUME_NONNULL_END
