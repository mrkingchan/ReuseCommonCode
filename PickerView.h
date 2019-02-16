//
//  PickerView.h
//  KKJob
//
//  Created by Jason on 2019/2/12.
//  Copyright © 2019年 Chan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PickerView : UIView

@property(nonatomic,copy) void (^complete)(NSString *selectedStr);

+(instancetype)pickerWithArray:(NSArray *)items Complete:(void (^)(NSString *selectedStr))complete;
@end

NS_ASSUME_NONNULL_END
