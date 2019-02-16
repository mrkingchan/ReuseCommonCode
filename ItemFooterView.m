//
//  ItemFooterView.m
//  KKJob
//
//  Created by Jason on 2019/1/24.
//  Copyright © 2019年 Chan. All rights reserved.
//

#import "ItemFooterView.h"

@interface ItemFooterView () {
    
}

@end
@implementation ItemFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        for (int i = 0 ; i < 2; i ++) {
            UILabel *item = [UILabel new];
            item.textAlignment =1 ;
            item.text = i == 0 ?@"重置":@"确定";
            item.backgroundColor = i == 0? [UIColor whiteColor]:kMainColor;
            item.textColor = i == 0 ?[UIColor lightGrayColor]:[UIColor whiteColor];
            item.font = [UIFont systemFontOfSize:18];
            [self addSubview:item];
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self);
                make.height.equalTo(@40);
                make.width.equalTo(@([UIScreen mainScreen].bounds.size.width /2.0));
                if (i == 0 ) {
                    make.left.equalTo(self);
                } else {
                    make.left.equalTo(self).offset([UIScreen mainScreen].bounds.size.width/2.0);
                }
            }];
            item.clipsToBounds = YES;
            item.layer.borderWidth = 1.0;
            item.layer.borderColor = [UIColor lightGrayColor].CGColor;
            item.tag = 124 +i;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonAction:)];
            [item addGestureRecognizer:tap];
        }
    }
    return self;
}

// MARK: - private Method
- (void)buttonAction:(UITapGestureRecognizer *)sender {
    UIView *tapView = sender.view;
    NSInteger index = tapView.tag - 124;
    if (index == 0) {
        
    } else {
        
    }
}
@end
