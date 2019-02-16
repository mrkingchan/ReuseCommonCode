//
//  AllNeedsView.m
//  KKJob
//
//  Created by Jason on 2019/2/14.
//  Copyright © 2019年 Chan. All rights reserved.
//

#import "AllNeedsView.h"
#define kPinkColor  [UIColor colorWithRed:255.0/255.0 green:247/255.0 blue:246/255.0 alpha:1.0]
#define itemW     [UIScreen mainScreen].bounds.size.width / 3.0

@interface AllNeedsView () <UIPickerViewDataSource,UIPickerViewDelegate> {
    NSInteger _index;
    UIPickerView *_pickerView;
    UIView *_containerView;
    UIView *_subView1;
    UIView *_subView2;
    UIView *_subView3;
    
    UILabel *_tip1;
    UILabel *_tip2;
    UILabel *_tip3;

    UILabel *_item1;
    UILabel *_item2;
    UILabel *_item3;
    
    UIButton *_positive;
    UILabel *_chooseTip;
    
    NSMutableArray *_dataArray;
    NSMutableArray *_minArray;
    NSMutableArray *_maxArray;
    UIView *_line;

}

@end
@implementation AllNeedsView

+ (instancetype)allNeedsViewWithComplete:(void (^)(NSString *value1,NSString  *value2,NSString *value3))complete {
    return [[AllNeedsView alloc] initWithComplete:complete];
}

- (instancetype)initWithComplete:(void (^)(NSString *value1,NSString  *value2,NSString *value3))complete {
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        _complete = complete;
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        self.backgroundColor  = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        [self setUI];
    }
    return self;
}

// MARK: - setUI
- (void)setUI {
    _index = 0;
    _containerView = [UIView new];
    [self addSubview:_containerView];
    _containerView.backgroundColor = [UIColor whiteColor];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@(280));
    }];
    
    
    _subView1 = [UIView new];
    [_containerView  addSubview:_subView1];
    [_subView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(_containerView);
        make.width.equalTo(@(itemW));
        make.height.equalTo(@(80));
    }];
    
    _subView2 = [UIView new];
    [_containerView  addSubview:_subView2];
    [_subView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_containerView);
        make.left.equalTo(_containerView).offset(itemW);
        make.width.height.equalTo(_subView1);
    }];
    
    _subView3 = [UIView new];
    [_containerView  addSubview:_subView3];
    [_subView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_containerView);
        make.left.equalTo(_containerView).offset( 2 *itemW);
        make.height.width.equalTo(_subView1);
    }];
    
    _subView1.userInteractionEnabled = _subView2.userInteractionEnabled = _subView3.userInteractionEnabled = YES;
    _containerView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonAction:)];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonAction:)];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonAction:)];

    _subView1.tag = 10932;
    _subView2.tag = 10933;
    _subView3.tag = 10934;

    _subView1.backgroundColor = _subView2.backgroundColor = _subView3.backgroundColor = [UIColor whiteColor];
    [_subView1 addGestureRecognizer:tap1];
    [_subView2 addGestureRecognizer:tap2];
    [_subView3 addGestureRecognizer:tap3];

    
    _tip1 = [UILabel new];
    _tip1.text = @"求职状态";
    _tip1.textAlignment = 1;
    _tip1.font = [UIFont systemFontOfSize:12];
    [_subView1 addSubview:_tip1];
    _tip1.textColor = kGrayColor;
    [_tip1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_subView1);
        make.top.equalTo(_subView1).offset(15);
    }];
    
    
    _tip2 = [UILabel new];
    _tip2.text = @"最低学历";
    _tip2.textAlignment = 1;
    _tip2.font = [UIFont systemFontOfSize:12];
    [_subView2 addSubview:_tip2];
    _tip2.textColor = kGrayColor;
    [_tip2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_subView2);
        make.top.equalTo(_tip1);
    }];
    
    _tip3 = [UILabel new];
    _tip3.text = @"薪资范围";
    _tip3.textAlignment = 1;
    _tip3.font = [UIFont systemFontOfSize:12];
    [_subView3 addSubview:_tip3];
    _tip3.textColor = kGrayColor;
    [_tip3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_subView3);
        make.top.equalTo(_tip1);
    }];
    
    
    _item1 = [UILabel new];
    _item1.text = @"1年之内";
    _item1.textAlignment = 1;
    _item1.textColor =  kMainColor;
    _item1.font = [UIFont boldSystemFontOfSize:15];
    [_subView1 addSubview:_item1];
    [_item1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_subView1);
        make.top.equalTo(_tip1.mas_bottom).offset(8);
    }];
    
    
    _item2 = [UILabel new];
    _item2.text = @"本科";
    _item2.textAlignment = 1;
    _item2.font = [UIFont boldSystemFontOfSize:15];
    [_subView2 addSubview:_item2];
    [_item2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_subView2);
        make.top.equalTo(_tip2.mas_bottom).offset(8);
    }];
    
    
    _item3 = [UILabel new];
    _item3.text = @"10k-11k";
    _item3.textAlignment = 1;
    _item3.font = [UIFont boldSystemFontOfSize:15];
    [_subView3 addSubview:_item3];
    [_item3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_subView3);
        make.top.equalTo(_tip1.mas_bottom).offset(8);
    }];
    
    
    UIView *backView = [UIView new];
    backView.backgroundColor = kBackColor;
    [_containerView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_containerView);
        make.height.equalTo(@(45));
        make.top.equalTo(_subView1.mas_bottom);
    }];
    _chooseTip = [UILabel new];
    _chooseTip.text =  @"请选择求职状态";
    _chooseTip.textColor = kGrayColor;
    _chooseTip.textAlignment = 1;
    _chooseTip.font = [UIFont systemFontOfSize:12];
    [backView addSubview:_chooseTip];
    [_chooseTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(backView);
    }];
    
    //完成
    _positive = [UIButton new];
    [_positive setTitle:@"完成" forState:UIControlStateNormal];
    _positive.titleLabel.font = [UIFont systemFontOfSize:15];
    [_positive setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_positive addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:_positive];
    [_positive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(backView);
        make.right.equalTo(backView).offset(-25);
    }];
    
    //滚轮
    _pickerView = [UIPickerView new];
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    [_containerView addSubview:_pickerView];
    [_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(_containerView);
        make.top.equalTo(backView.mas_bottom);
    }];

    _line = [UIView new];
    _line.backgroundColor = kMainColor;
    [_containerView addSubview:_line];
    _line.frame = CGRectMake(0, 0, itemW, 3.0);

    _dataArray = [NSMutableArray arrayWithArray:@[@"1年以内",@"1-3年",@"3-5年",@"5年以上"]];


    _minArray = [NSMutableArray new];
    for (int i = 1; i < 50; i ++) {
        [_minArray addObject:[NSString stringWithFormat:@"%ik",i]];
    }
    
    NSInteger min = [[_minArray[0] stringByReplacingOccurrencesOfString:@"k" withString:@""] integerValue];
    _maxArray = [NSMutableArray new];
    for (NSInteger i = min + 1; i < 51 ; i ++) {
        [_maxArray addObject:[NSString stringWithFormat:@"%zdk",i]];
    }
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer  alloc] initWithTarget:self action:@selector(hide)];
    [self addGestureRecognizer:tap4];
}

// MARK: - private Method
- (void)buttonAction:(id)sender {
    if ([sender isKindOfClass:[UITapGestureRecognizer class]]) {
        //切换
        UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
        _index = tap.view.tag - 10932;
        if (_index == 0) {
            _dataArray = [NSMutableArray arrayWithArray:@[@"1年以内",@"1-3年",@"3-5年",@"5年以上"]];
            [_pickerView reloadAllComponents];
        } else if (_index == 1) {
            _dataArray = [NSMutableArray arrayWithArray:@[@"初中",@"高中",@"本科",@"硕士",@"博士"]];
            [_pickerView reloadAllComponents];
        } else if(_index == 2) {
            //薪资范围
            [_pickerView reloadAllComponents];
        }
        _chooseTip.text = _index == 0?@"请选择求职状态":_index == 1 ?@"请选择最低学历":@"请选择薪资范围";
        [self switchItemColorWithIndex:_index];
        
    }  else if ([sender isKindOfClass:[UIButton class]]) {
        [self hide];
        if (_complete) {
            _complete(_item1.text,_item2.text,_item3.text);
        }
    }
}

// MARK: - switchMethod
- (void)switchItemColorWithIndex:(NSInteger)index {
    
    [UIView animateWithDuration:0.2 animations:^{
        _line.frame = CGRectMake(index * itemW, 0, itemW, 3.0);
    }];
    
    if (index == 0 ) {
        _item1.textColor =  kMainColor;
        _subView1.backgroundColor = kPinkColor;
        _subView2.backgroundColor = _subView3.backgroundColor = [UIColor whiteColor];
        _item2.textColor = [UIColor blackColor];
        _item3.textColor = [UIColor blackColor];
    } else if (index == 1) {
        _item2.textColor = kMainColor;
        _subView2.backgroundColor = kPinkColor;
        _subView1.backgroundColor = _subView3.backgroundColor = [UIColor whiteColor];
        _item1.textColor = [UIColor blackColor];
        _item3.textColor = [UIColor blackColor];
    } else if (index == 2) {
        _item3.textColor = kMainColor;
        _subView3.backgroundColor = kPinkColor;
        _subView1.backgroundColor = _subView2.backgroundColor = [UIColor whiteColor];
        _item1.textColor = [UIColor blackColor];
        _item2.textColor = [UIColor blackColor];
    }
}


// MARK: - hide
- (void)hide {
    [UIView animateWithDuration:0.2 animations:^{
        _containerView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 285);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

// MARK: - UIPickerViewDataSource&Delegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return _index == 2 ? 2:1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _index == 2? component == 0?_minArray.count :_maxArray.count: _dataArray.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _index == 2? component == 0 ? _minArray[row]:_maxArray[row] :_dataArray[row];
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 55;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (_index == 0) {
        _item1.text = _dataArray[row];
    }else if (_index == 1) {
        _item2.text = _dataArray[row];
    } else if (_index == 2) {
        if (component == 0) {
            NSInteger min = [[_minArray[row] stringByReplacingOccurrencesOfString:@"k" withString:@""] integerValue];
            _maxArray = [NSMutableArray new];
            for (NSInteger i = min + 1; i < 51 ; i ++) {
                [_maxArray addObject:[NSString stringWithFormat:@"%zdk",i]];
            }
            [pickerView reloadComponent:1];
        }
        _item3.text = [NSString stringWithFormat:@"%@-%@",_minArray[row],_maxArray[row]];
    }
}

@end
