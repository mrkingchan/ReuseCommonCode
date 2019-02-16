//
//  DistrictView.m
//  KKJob
//
//  Created by Jason on 2019/1/30.
//  Copyright © 2019年 Chan. All rights reserved.
//

#import "DistrictView.h"
#import "CityCell.h"
#import "MetroCell.h"

#define kGap  [UIScreen mainScreen].bounds.size.width / 4.0 - 40
#define kLineW 80
@interface DistrictView () <UITableViewDataSource,UITableViewDelegate> {
    UIView *_containerView;
    UIView *_topView;
    UITableView *_tableView1;
    UITableView *_tableView2;
    UIView *_line;
    NSInteger _index1;
    NSInteger _index2;
    NSMutableArray *_dataArray;
}

@end
@implementation DistrictView

+ (instancetype)districtViewWithSelectedComplete:(void (^)(NSString *selectedItem))complete {
    return [[DistrictView alloc] initWithSelectedComplete:complete];
}

- (instancetype)initWithSelectedComplete:(void (^)(NSString *selectedItem))complete {
    if (self = [super  initWithFrame:[UIScreen mainScreen].bounds]) {
        _complete = complete;
        _index1 = _index2 = 0;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.01];
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        [self setUI];
    }
    return self;
}

- (void)setUI {
    NSString *areaFile = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"];
    NSArray <NSDictionary *> *dataArray = [NSArray  arrayWithContentsOfFile:areaFile][18][@"cities"][2][@"areas"];
     _dataArray = [NSMutableArray arrayWithArray:dataArray];
    _containerView = [UIView new];
    _containerView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    [self addSubview:_containerView];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        if (kisiPhoneX) {
            make.top.equalTo(self).offset(88 + 50);
        } else {
            make.top.equalTo(self).offset(64 + 50);
        }
    }];
    
    _topView = [UIView new];
    _topView.userInteractionEnabled = YES;
    _topView.backgroundColor = [UIColor whiteColor];
    [_containerView addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(_containerView);
        make.height.equalTo(@50);
    }];
    
    NSArray *titles = @[@"商圈",@"地铁"];
    _line = [UIView new];
    [_topView addSubview:_line];
    _line.backgroundColor = kMainColor;
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topView).offset(kGap);
        make.width.equalTo(@(kLineW));
        make.height.equalTo(@3.0);
        make.bottom.equalTo(_topView).offset(-3.0);
    }];
    for (int i = 0 ; i < 2; i ++) {
        UILabel *title = [UILabel new];
        title.textAlignment = 1;
        title.font = [UIFont systemFontOfSize:14];
        title.text  = titles[i];
        title.userInteractionEnabled = YES;
        title.tag = 18394 + i;
        [_topView addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_topView);
            make.width.equalTo(@([UIScreen mainScreen].bounds.size.width/ 2.0));
            if (i == 0) {
                make.left.equalTo(_topView);
            } else {
                make.left.equalTo(_topView).offset([UIScreen mainScreen].bounds.size.width/2.0);
            }
            make.bottom.equalTo(_topView).offset(-3.0);
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonAction:)];
        [title addGestureRecognizer:tap];
    }
    
    _tableView1 = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView1.dataSource = self;
    _tableView1.delegate = self;
    _tableView1.tableFooterView = [UIView new];
    [_containerView addSubview:_tableView1];
    [_tableView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_containerView);
        make.top.equalTo(_topView.mas_bottom);
        make.height.equalTo(@(7 * 50));
        make.width.equalTo(@160);
    }];
    
    [_tableView1 registerNib:[UINib nibWithNibName:NSStringFromClass([CityCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([CityCell class])];

    _tableView2 = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView2.dataSource = self;
    _tableView2.delegate = self;
    _tableView2.tableFooterView = [UIView new];
    [_containerView addSubview:_tableView2];
    [_tableView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_tableView1.mas_right);
        make.top.equalTo(_tableView1);
        make.height.equalTo(@(7 * 50));
        make.right.equalTo(_containerView);
    }];
    
    [_tableView2 registerNib:[UINib nibWithNibName:NSStringFromClass([MetroCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([MetroCell class])];
    
    UIView *toolView = [UIView new];
    toolView.backgroundColor = [UIColor whiteColor];
    [_containerView addSubview:toolView];
    [toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_containerView);
        make.top.equalTo(_tableView1.mas_bottom);
        make.height.equalTo(@77);
    }];
    
    NSArray *items = @[@"重置",@"确定",@"切换城市"];
    for (int i = 0 ; i < 3 ; i ++) {
        UIButton *item = [UIButton new];
        item.clipsToBounds = YES;
        item.layer.borderColor = [UIColor lightGrayColor].CGColor;
        item.layer.borderWidth = 0.5;
        item.backgroundColor = [UIColor whiteColor];
        [item setTitle:items[i] forState:UIControlStateNormal];
        item.titleLabel.textAlignment = 1;
        [item setTitleColor:i == 1 ? kMainColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        item.titleLabel.font = [UIFont systemFontOfSize:15];
        [toolView addSubview:item];
        if (i < 2) {
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(toolView);
                make.width.equalTo(@([UIScreen mainScreen].bounds.size.width / 2.0));
                make.height.equalTo(@40);
                make.left.equalTo(toolView).offset(i  * [UIScreen mainScreen].bounds.size.width / 2.0);
            }];
        } else {
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@37);
                make.left.right.bottom.equalTo(toolView);
            }];
        }
        item.tag = 38943 + i;
        [item addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }

    //hide TapGesture
    UITapGestureRecognizer *hideTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [self addGestureRecognizer:hideTap];
}

// MARK: - private Method
- (void)buttonAction:(id)sender {
    if ([sender isKindOfClass:[UITapGestureRecognizer class]]) {
        UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
        NSInteger index = tap.view.tag -18394;
        [UIView animateWithDuration:0.2 animations:^{
            CGRect frame = _line.frame;
            frame.origin.x = (index * [UIScreen mainScreen].bounds.size.width/2.0) +kGap;
            _line.frame = frame;
        }];
    } else if ([sender isKindOfClass:[UIButton class]]) {
        [self hide];
        NSInteger index = ((UIButton *)sender).tag -38943;
        if (index ==0) {
            //重置
        } else if (index == 1) {
            //确定
        } else if (index == 2) {
            //切换城市
        }
    }
}

/*-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self hide];
}*/

// MARK: - hide

-(void)hide {
    [UIView animateWithDuration:0.2 animations:^{
        [self removeFromSuperview];
    }];
}

// MARK: - UITableViewDataSource &Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:_tableView1]) {
        return _dataArray.count;
    } else if ([tableView isEqual:_tableView2]) {
        return [_dataArray[_index1][@"streets"] count];
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:_tableView1]) {
        CityCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CityCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setCellWithContent:_dataArray[indexPath.row][@"county"] selected:_index1 == indexPath.row];
        return cell;
    } else if([tableView isEqual:_tableView2]) {
        MetroCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MetroCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setCellWithContent:_dataArray[_index1][@"streets"][indexPath.row] selected:_index2 == indexPath.row];
        return cell;
    } else {
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:_tableView1]) {
        _index1 = indexPath.row;
    } else if([tableView isEqual:_tableView2]) {
        _index2 = indexPath.row;
    }
    [_tableView1 reloadData];
    [_tableView2 reloadData];
}
@end
