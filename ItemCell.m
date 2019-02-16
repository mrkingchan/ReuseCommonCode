//
//  ItemCell.m
//  KKJob
//
//  Created by Jason on 2019/1/24.
//  Copyright © 2019年 Chan. All rights reserved.
//

#import "ItemCell.h"

@interface ItemCell () {
    UIButton *_name;
}

@end
@implementation ItemCell

-(instancetype)initWithFrame:(CGRect)frame  {
    if (self = [super initWithFrame:frame]) {
        _name = [[UIButton alloc] initWithFrame:CGRectZero];
        [_name setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _name.titleLabel.textAlignment =1;
        _name.titleLabel.font = [UIFont systemFontOfSize:12];
        _name.clipsToBounds = YES;
        _name.layer.cornerRadius = 4.0;
        _name.layer.borderWidth = 1.0;
        _name.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [_name addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_name];
        [_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

// MARK: - private Method
- (void)buttonAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [_name setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _name.backgroundColor = kMainColor;
    } else {
        [_name setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _name.backgroundColor = [UIColor whiteColor];
    }
}

-(void)setCellWithData:(NSString *)data {
    [_name setTitle:data forState:UIControlStateNormal];
}

@end
