//
//  DistrictView.h
//  KKJob
//
//  Created by Jason on 2019/1/30.
//  Copyright © 2019年 Chan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DistrictView : UIView

@property(nonatomic,copy) void (^complete)(NSString *selectedItem);


+ (instancetype)districtViewWithSelectedComplete:(void (^)(NSString *selectedItem))complete;

- (void)hide;


@end

NS_ASSUME_NONNULL_END
