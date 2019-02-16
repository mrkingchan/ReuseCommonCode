//
//  SalaryPicker.h
//  KKJob
//
//  Created by Jason on 2019/1/22.
//  Copyright © 2019年 Chan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SalaryPicker : UIView
@property(nonatomic,copy) void (^complete)(NSString *min,NSString *max);


+(instancetype)salaryPickerWithComplete:(void (^)(NSString *min,NSString *max))complete;

@end

NS_ASSUME_NONNULL_END
