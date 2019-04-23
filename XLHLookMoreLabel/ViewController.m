//
//  ViewController.m
//  XLHLookMoreLabel
//
//  Created by 薛立恒 on 2019/3/5.
//  Copyright © 2019 薛立恒. All rights reserved.
//

#import "ViewController.h"
#import "XLHTableViewCell.h"
#import "XLHModel.h"
#import "XLHLookMoreLabel.h"

static NSString * const cellID = @"cell";

@interface ViewController ()<XLHTableViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) NSMutableArray *dataSourceList;
@property(nonatomic,strong) NSMutableDictionary *offScreenCell;
@property(nonatomic,strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[XLHTableViewCell class] forCellReuseIdentifier:cellID];
    
    NSString *str = @"现在网上很流行一句话，有趣的灵魂万一挑一，好看的皮囊千律一遍。说实话有趣的灵魂见到的倒不是很多，但杠精倒是一大堆，啥是杠精，就是别人说啥他都要跟你抬杠，经常把别人气的半死，自己也一团火（想不通何必呢）不过呢因为这些人的存在，生活工作才不会那么无聊，没事两个人在那抬抬杠，也挺有意思。写这篇文章也是因为我一个杠精朋友觉得学runtime没啥用处，平时开发也用不到，学了也就是为了应付面试而已，我不这么觉得，所以今天讨论一下runtime这个黑科技能搞点啥东西出来，如有错误希望大家积极指正，我们一起进步";
    self.offScreenCell = [NSMutableDictionary new];
    self.dataSourceList = [NSMutableArray arrayWithCapacity:20];
    for (NSInteger i = 0; i < 50; i ++) {
        XLHModel *model = [[XLHModel alloc]init];
        model.title = str;
        model.numberOfLines = 3;
        model.state = XLHNormalState;
        [_dataSourceList addObject:model];
    }
}

#pragma mark - ======== UITableViewDelegate,UITableViewDataSource ========

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XLHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.delegate = self;
    [cell setModel:self.dataSourceList[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    XLHTableViewCell *cell = [self.offScreenCell objectForKey:cellID];
    if (!cell) {
        cell = [[XLHTableViewCell alloc]init];
        [self.offScreenCell setObject:cell forKey:cellID];
    }
    XLHModel *model = self.dataSourceList[indexPath.row];
    [cell.label setText:model.title];
    cell.label.state = model.state;
    cell.label.numberOfLines = model.numberOfLines;
    CGSize size = [cell.label sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width - 2 * 15, MAXFLOAT)];
    return size.height + 2 * 15;
}

#pragma mark - ======== XLHTableViewDelegate ========

- (void)tableViewCell:(XLHTableViewCell *)cell model:(XLHModel *)model numberOfLines:(NSInteger)numberOfLines {
    model.numberOfLines = numberOfLines;
    if (numberOfLines == 0) {
        model.state = XLHOpenState;
    } else {
        model.state = XLHCloseState;
    }
    [self.tableView reloadData];
}

#pragma mark - ======== getter ========
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 44) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
