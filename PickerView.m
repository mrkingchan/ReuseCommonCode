//
//  PickerView.m
//  KKJob
//
//  Created by Jason on 2019/2/12.
//  Copyright © 2019年 Chan. All rights reserved.
//

#import "PickerView.h"

@interface PickerView () {
    UIPickerView *_picker;
    UIButton *_cancel;
    UIButton *_positive;
    NSMutableArray *_dataArray;
    UIView *_containerView;
}

@end
@implementation PickerView

+(instancetype)pickerWithArray:(NSArray *)items Complete:(void (^)(NSString *selectedStr))complete {
    return  [[PickerView alloc] initWithArray:items Complete:complete];
}

- (instancetype)initWithArray:(NSArray *)items Complete:(void (^)(NSString *selectedStr))complete {
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds] ) {
        _complete = complete;
        _dataArray = [NSMutableArray arrayWithArray:items];
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        [[UIApplication sharedApplication].keyWindow addSubview:self];
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
        title.text = @"公司规模";
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
        
        _picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 180)];
        _picker.dataSource = self;
        _picker.delegate = self;
        _picker.showsSelectionIndicator = YES;
        [_containerView addSubview:_picker];
        
    }
    return self;
}


- (void)buttonAction:(id)sender {
    if ([sender isEqual:_cancel]) {
        [self hide];
    } else {
        [self hide];
        if (_complete) {
            NSString *selectedStr = [_dataArray objectAtIndex:[_picker selectedRowInComponent:0]];
            _complete(selectedStr);
        }
    }
}

- (void)hide {
    [UIView animateWithDuration:0.2 animations:^{
        _containerView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 230);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

// MARK: - UIPickerViewDataSource&Delegate

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _dataArray.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _dataArray[row];
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 55;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
}



@end
