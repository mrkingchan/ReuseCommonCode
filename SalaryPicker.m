//
//  SalaryPicker.m
//  KKJob
//
//  Created by Jason on 2019/1/22.
//  Copyright © 2019年 Chan. All rights reserved.
//

#import "SalaryPicker.h"

@interface SalaryPicker () <UIPickerViewDelegate,UIPickerViewDataSource> {
    UIPickerView *_picker;
    UIButton *_cancel;
    UIButton *_positive;
    UIView *_containerView;
    NSMutableArray  *_minArray;
    NSMutableArray *_maxArray;
}

@end

@implementation SalaryPicker

+(instancetype)salaryPickerWithComplete:(void (^)(NSString *year,NSString *month))complete {
    return [[SalaryPicker alloc] initWithComplete:complete];
}

- (instancetype)initWithComplete:(void (^)(NSString *year,NSString *month))complete {
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds] ) {
        _complete = complete;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        
        _minArray = [NSMutableArray new];
        for (int i = 1; i < 50; i ++) {
            [_minArray addObject:[NSString stringWithFormat:@"%ik",i]];
        }
        
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 230)];
        _containerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_containerView];
        
        //取消
        _cancel = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancel setImage:kImage(@"cancel") forState:UIControlStateNormal];
        _cancel.frame = CGRectMake(25, 10, 30, 30);
        [_cancel addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_containerView addSubview:_cancel];
        
        UILabel *title = [UILabel new];
        title.frame = CGRectMake(60, 0, [UIScreen mainScreen].bounds.size.width - 60 - 60, 50);
        title.text = @"薪资要求（月薪，单位：千元)";
        title.font = [UIFont systemFontOfSize:15];
        title.textAlignment = 1;
        [_containerView addSubview:title];
        
        //确定
        _positive = [UIButton buttonWithType:UIButtonTypeCustom];
        [_positive setImage:kImage(@"positive") forState:UIControlStateNormal];
        _positive.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 30 - 30, 10, 30, 30);
        [_positive addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_containerView addSubview:_positive];
        
        [UIView animateWithDuration:0.2 animations:^{
            _containerView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height  - 230, [UIScreen mainScreen].bounds.size.width, 230);
        }];

        //picker
        _picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 180)];
        _picker.dataSource = self;
        _picker.delegate = self;
        [_containerView addSubview:_picker];
        _picker.showsSelectionIndicator = YES;
        
        [self pickerView:_picker didSelectRow:0 inComponent:0];
    }
    return self;
}

// MARK: - private Method
- (void)buttonAction:(id)sender {
    if ([sender isEqual:_cancel]) {
        [self hide];
    } else {
        [self hide];
        if (_complete) {
            NSString *year = [_minArray objectAtIndex:[_picker selectedRowInComponent:0]];
            NSString *month = [_maxArray objectAtIndex:[_picker selectedRowInComponent:1]];
            _complete(year,month);
        }
    }
}

// MARK: - hide
- (void)hide {
    [UIView animateWithDuration:0.2 animations:^{
        _containerView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 230);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

// MARK: - UIPickerViewDataSource&Delegate

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return component == 0 ? _minArray.count:_maxArray.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return component == 0 ?_minArray[row]:_maxArray[row];
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 55;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        NSInteger min = [[_minArray[row] stringByReplacingOccurrencesOfString:@"k" withString:@""] integerValue];
        _maxArray = [NSMutableArray new];
        for (NSInteger i = min + 1; i < 51 ; i ++) {
            [_maxArray addObject:[NSString stringWithFormat:@"%zdk",i]];
        }
        [pickerView reloadComponent:1];
    }
}

// MARK: - memory management

- (void)dealloc {
    
}
@end

