//
//  CityPicker.h
//  KKJob
//
//  Created by Jason on 2019/1/22.
//  Copyright © 2019年 Chan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CityPicker : UIView

@property(nonatomic,copy) void (^complete)(NSString *province,NSString *city);

+(instancetype)cityPickerWithComplete:(void (^)(NSString *province,NSString *city))complete;

@end

NS_ASSUME_NONNULL_END
