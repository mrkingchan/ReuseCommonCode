//
//  ItemHeaderView.m
//  KKJob
//
//  Created by Jason on 2019/1/24.
//  Copyright © 2019年 Chan. All rights reserved.
//

#import "ItemHeaderView.h"

@interface ItemHeaderView() {
    UILabel *_title;
}

@end
@implementation ItemHeaderView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _title  = [UILabel new];
        _title.textColor = [UIColor grayColor];
        _title.font = [UIFont systemFontOfSize:14];
        [self addSubview:_title];
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20);
            make.top.bottom.equalTo(self);
        }];
    }
    return self;
}

-(void)setHeaderWithTitle:(NSString *)title {
    _title.text = title;
}


@end
