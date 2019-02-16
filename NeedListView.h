//
//  NeedListView.h
//  KKJob
//
//  Created by Jason on 2019/1/24.
//  Copyright © 2019年 Chan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NeedListView : UIView

@property(nonatomic,copy) void (^complete)(NSString *value1,NSString *value2,NSString *value3);

+ (instancetype)needListViewWithComplete:(void (^)(NSString *value1,NSString *value2,NSString *value3))complete;

- (void)hide;

@end

NS_ASSUME_NONNULL_END
