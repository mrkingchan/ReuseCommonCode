//
//  TimePicker.h
//  KKJob
//
//  Created by Jason on 2019/1/22.
//  Copyright © 2019年 Chan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TimePicker : UIView

@property(nonatomic,copy) void (^complete)(NSString *year,NSString *month);


+(instancetype)timePickerWithComplete:(void (^)(NSString *year,NSString *month))complete;

@end

NS_ASSUME_NONNULL_END
