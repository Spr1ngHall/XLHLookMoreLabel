//
//  XLHTableViewCell.h
//  XLHLookMoreLabel
//
//  Created by 薛立恒 on 2019/3/6.
//  Copyright © 2019 薛立恒. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class XLHLookMoreLabel;
@class XLHModel;
@class XLHTableViewCell;

@protocol XLHTableViewDelegate <NSObject>

- (void)tableViewCell:(XLHTableViewCell *)cell model:(XLHModel *)model numberOfLines:(NSInteger)numberOfLines;

@end

@interface XLHTableViewCell : UITableViewCell

@property(nonatomic,weak) id<XLHTableViewDelegate> delegate;
@property(nonatomic,strong) XLHModel *model;
@property(nonatomic,strong) XLHLookMoreLabel *label;

@end

NS_ASSUME_NONNULL_END
