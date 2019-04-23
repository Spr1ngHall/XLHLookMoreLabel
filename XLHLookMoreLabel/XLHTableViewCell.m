//
//  XLHTableViewCell.m
//  XLHLookMoreLabel
//
//  Created by 薛立恒 on 2019/3/6.
//  Copyright © 2019 薛立恒. All rights reserved.
//

#import "XLHTableViewCell.h"
#import "XLHLookMoreLabel.h"
#import "XLHModel.h"

@interface XLHTableViewCell ()<XLHAttributedLabelDelegate>

@end

@implementation XLHTableViewCell

#pragma mark - ======== life cycle ========

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.label];
    }
    return self;
}

#pragma mark - ======== XLHAttributedLabelDelegate ========

- (void)displayView:(XLHLookMoreLabel *)label openHeight:(CGFloat)height {
    if ([self.delegate respondsToSelector:@selector(tableViewCell:model:numberOfLines:)]) {
        [self.delegate tableViewCell:self model:_model numberOfLines:0];
    }
}

- (void)displayview:(XLHLookMoreLabel *)label closeHeight:(CGFloat)height {
    if ([self.delegate respondsToSelector:@selector(tableViewCell:model:numberOfLines:)]) {
        [self.delegate tableViewCell:self model:_model numberOfLines:3];
    }
}

#pragma mark - ======== getter ========
- (XLHLookMoreLabel *)label {
    if (!_label) {
        _label = [[XLHLookMoreLabel alloc]init];
        _label.delegate = self;
        _label.textColor = [UIColor blackColor];
        _label.backgroundColor = [UIColor clearColor];
        [_label setOpenString:@"查看更多" andCloseString:@"点击收起" andFont:[UIFont systemFontOfSize:16] andTextColor:[UIColor blueColor]];
    }
    return _label;
}

#pragma mark - ======== setter ========
- (void)setModel:(XLHModel *)model {
    _model = model;
    [_label setText:model.title];
    _label.state = model.state;
    _label.numberOfLines = model.numberOfLines;
    CGSize size = [_label sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width - 2 * 15, MAXFLOAT)];
    _label.frame = CGRectMake(15, 15, size.width, size.height);
}


@end
