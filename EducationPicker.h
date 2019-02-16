//
//  EducationPicker.h
//  KKJob
//
//  Created by Jason on 2019/1/22.
//  Copyright © 2019年 Chan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EducationPicker : UIView

@property(nonatomic,copy) void (^complete)(NSString *selectedStr);

+(instancetype)educationPickerWithComplete:(void (^)(NSString *selectedStr))complete;

@end

NS_ASSUME_NONNULL_END
