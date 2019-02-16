//
//  SecondPageView.m
//  KKJob
//
//  Created by Jason on 2019/1/23.
//  Copyright © 2019年 Chan. All rights reserved.
//

#import "SecondPageView.h"
#import "ChooseJobCell.h"

@interface SecondPageView ()<UITableViewDelegate,UITableViewDataSource> {
    UITableView *_tableView1;
    UITableView *_tableView2;
    NSMutableArray *_dataArray;
    UIView *_containerView;
    NSInteger _index1;
    NSInteger _index2;
}

@end
@implementation SecondPageView

+ (instancetype)secondPageViewWithComplete:(void (^)(NSString *value1,NSString *value2))complete {
    return [[SecondPageView alloc] initWithComplete:complete];
}

// MARK: - initialized method
-(instancetype)initWithComplete:(void (^)(NSString *value1,NSString *value2))complete {
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        _complete = complete;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.01];
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        _containerView = [[UIView alloc] initWithFrame:CGRectZero];
        _containerView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        [self addSubview:_containerView];
        [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            if (kisiPhoneX) {
                make.top.equalTo(self).offset(88);
            } else {
                make.top.equalTo(self).offset(64);
            }
        }];
        
        //tableView1
        _tableView1 = [[UITableView alloc] initWithFrame:CGRectZero style:0];
        _tableView1.dataSource = self;
        _tableView1.delegate = self;
        [_containerView addSubview:_tableView1];
        [_tableView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_containerView).offset(60);
            make.top.bottom.equalTo(_containerView);
            make.width.equalTo(@(([UIScreen mainScreen].bounds.size.width - 60)/2.0));
        }];
        
        // tableView2
        _tableView2 = [[UITableView alloc] initWithFrame:CGRectZero style:0];
        _tableView2.dataSource = self;
        _tableView2.delegate = self;
        [_containerView addSubview:_tableView2];
        [_tableView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_tableView1.mas_right);
            make.top.bottom.equalTo(_containerView);
            make.width.equalTo(@(([UIScreen mainScreen].bounds.size.width - 60)/2.0));
        }];
        
        [_tableView1 registerNib:[UINib nibWithNibName:NSStringFromClass([ChooseJobCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([ChooseJobCell class])];
        [_tableView2 registerNib:[UINib nibWithNibName:NSStringFromClass([ChooseJobCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([ChooseJobCell class])];
        _index1 = _index2 = 0;
        _tableView1.showsVerticalScrollIndicator = _tableView2.showsVerticalScrollIndicator = NO;
        /*
        [self tableView:_tableView1 didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
         [self tableView:_tableView2 didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
         */
    }
    return self;
}

// MARK: - UITableViewDataSource &Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:_tableView1]) {
        ChooseJobCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ChooseJobCell class])];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        cell.content.text = @"xxx";
        cell.content.textColor = indexPath.row == _index1 ? kMainColor:[UIColor lightGrayColor];
        return cell;
    } else if ([tableView isEqual:_tableView2]) {
        ChooseJobCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ChooseJobCell class])];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        cell.content.text = @"xxx";
        cell.content.textColor = indexPath.row == _index2 ? kMainColor:[UIColor lightGrayColor];
        return cell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:_tableView1]) {
        _index1 = indexPath.row;
        [tableView reloadData];
    } else if ([tableView  isEqual:_tableView2]) {
        _index2 = indexPath.row;
        [tableView reloadData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self hide];
            if (_complete) {
                _complete(@"xxx",@"xxx");
            }
        });
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self hide];
}

// MARK: - private Method
-(void)hide {
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame =  _containerView.frame;
        frame.origin.x = [UIScreen mainScreen].bounds.size.width;
        _containerView.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

// MARK: - memory management
-(void)dealloc {
    if (_tableView1) {
        _tableView1.dataSource = nil;
        _tableView1.delegate = nil;
        _tableView1 = nil;
    }
    if (_tableView2) {
        _tableView2.dataSource = nil;
        _tableView2.delegate = nil;
        _tableView2 = nil;
    }
    if (_dataArray) {
        [_dataArray removeAllObjects];
        _dataArray = nil;
    }
}

@end
