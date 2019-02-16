//
//  SecondPageView.h
//  KKJob
//
//  Created by Jason on 2019/1/23.
//  Copyright © 2019年 Chan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SecondPageView : UIView

@property(nonatomic,copy) void (^complete) (NSString *value1,NSString *value2);

+ (instancetype)secondPageViewWithComplete:(void (^)(NSString *value1,NSString *value2))complete;

@end

NS_ASSUME_NONNULL_END
