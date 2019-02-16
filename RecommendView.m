//
//  RecommendView.m
//  KKJob
//
//  Created by Jason on 2019/1/30.
//  Copyright © 2019年 Chan. All rights reserved.
//

#import "RecommendView.h"
#import "RecommendChooseCell.h"

@interface RecommendView() <UITableViewDataSource,UITableViewDelegate> {
    UIView *_containView;
    UITableView *_tableView;
    NSInteger _index;
    
}
@end

@implementation RecommendView

+ (instancetype)recommendViewWithSelectedComplete:(void (^)(NSString *selectedItem))complete {
    return [[RecommendView alloc] initWithSelectedComplete:complete];
}

- (instancetype)initWithSelectedComplete:(void (^)(NSString *selectedItem))complete {
    if (self = [super  initWithFrame:[UIScreen mainScreen].bounds]) {
        _complete = complete;
        _index = 0;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.01];
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        [self setUI];
    }
    return self;
}

// MARK: - setUI
- (void)setUI {
    _containView = [[UIView alloc] initWithFrame:CGRectZero];
    _containView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    [self addSubview:_containView];
    [_containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        if (kisiPhoneX) {
            make.top.equalTo(self).offset(88 + 50);
        } else {
            make.top.equalTo(self).offset(64 + 50);
        }
    }];
    
    //tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [UIView new];
    [_containView addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(_containView);
        make.height.equalTo(@(100));
    }];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RecommendChooseCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([RecommendChooseCell class])];
    
}

// MARK: - UITableViewDataSource &Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView  {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecommendChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RecommendChooseCell class])];
    [cell setCellWithContent:indexPath.row == 0 ?@"推荐":@"最新" selected:indexPath.row == _index];
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _index = indexPath.row;
    [tableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self hide];
}

-(void)hide {
    [UIView animateWithDuration:0.01 animations:^{
        [self removeFromSuperview];
    }];
}
@end
