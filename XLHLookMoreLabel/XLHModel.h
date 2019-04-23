//
//  XLHModel.h
//  XLHLookMoreLabel
//
//  Created by 薛立恒 on 2019/3/6.
//  Copyright © 2019 薛立恒. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XLHLookMoreLabel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XLHModel : NSObject

@property(nonatomic,assign) XLHLabelState state;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,assign) NSInteger numberOfLines;

@end

NS_ASSUME_NONNULL_END
