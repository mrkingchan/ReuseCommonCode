//
//  NeedListView.m
//  KKJob
//
//  Created by Jason on 2019/1/24.
//  Copyright © 2019年 Chan. All rights reserved.
//

#import "NeedListView.h"
#import "ItemCell.h"
#import "ItemHeaderView.h"
#import "ItemFooterView.h"

@interface NeedListView() <UICollectionViewDelegate,UICollectionViewDataSource> {
    UICollectionView *_collectionView;
    UIView *_containerView;
}
@end
@implementation NeedListView

+ (instancetype)needListViewWithComplete:(void (^)(NSString *value1,NSString *value2,NSString *value3))complete {
    return [[NeedListView alloc] initWithComplete:complete];
}

// MARK: - initialized Method
- (instancetype)initWithComplete:(void (^)(NSString *value1,NSString *value2,NSString *value3))complete {
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.01];
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        _complete = complete;
        _containerView = [UIView new];
        _containerView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        [self addSubview:_containerView];
        [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            if (kisiPhoneX) {
                make.top.equalTo(self).offset(88 + 50);
            } else {
                make.top.equalTo(self).offset(64 + 50);
            }
            make.bottom.equalTo(self);
        }];
        
        //collectionView
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 60);
        layout.itemSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width - 90)/4.0, 30);
        layout.minimumLineSpacing = 18;
        layout.minimumInteritemSpacing = 18;
        layout.sectionInset = UIEdgeInsetsMake(0, 18, 0, 18);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_containerView addSubview:_collectionView];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_containerView  addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(_containerView);
            make.height.equalTo(@435);
        }];
        
        [_collectionView registerClass:[ItemCell class] forCellWithReuseIdentifier:NSStringFromClass([ItemCell class])];
        [_collectionView registerClass:[ItemHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([ItemHeaderView class])];
        for (int i = 0 ; i < 2; i ++) {
            UILabel *item = [UILabel new];
            item.textAlignment =1 ;
            item.text = i == 0 ?@"重置":@"确定";
            item.backgroundColor = i == 0? [UIColor whiteColor]:kMainColor;
            item.textColor = i == 0 ?[UIColor lightGrayColor]:[UIColor whiteColor];
            item.font = [UIFont systemFontOfSize:18];
            [_containerView addSubview:item];
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_collectionView.mas_bottom);
                make.height.equalTo(@40);
                make.width.equalTo(@([UIScreen mainScreen].bounds.size.width /2.0));
                if (i == 0 ) {
                    make.left.equalTo(_containerView);
                } else {
                    make.left.equalTo(_containerView).offset([UIScreen mainScreen].bounds.size.width/2.0);
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

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self hide];
}

// MARK: - private Method
- (void)buttonAction:(UITapGestureRecognizer *)sender {
    UIView *tapView = sender.view;
    NSInteger index = tapView.tag - 124;
    [self hide];
    if (index == 0) {
        
    } else {
        
    }
}

// MARK: - UICollectionViewDataSource&Delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ItemCell class]) forIndexPath:indexPath];
    [cell setCellWithData:@"xxxxxx"];
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        ItemHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([ItemHeaderView class]) forIndexPath:indexPath];
        [headerView setHeaderWithTitle:indexPath.section == 0?@"融资规模":indexPath.section == 1 ? @"团队规模":@"行业"];
        return headerView;
    }
    return nil;
}

// MARK: - private Method
-(void)hide {
    [UIView animateWithDuration:0.2 animations:^{
        [self removeFromSuperview];
    }];
}

// MARK: - memory management
-(void)dealloc {
    if (_collectionView) {
        _collectionView.dataSource = nil;
        _collectionView.delegate = nil;
        _collectionView = nil;
    }
    if (_containerView) {
        _containerView = nil;
    }
}

@end
