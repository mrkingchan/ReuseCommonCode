//
//  AllNeedsView.h
//  KKJob
//
//  Created by Jason on 2019/2/14.
//  Copyright © 2019年 Chan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AllNeedsView : UIView

+ (instancetype)allNeedsViewWithComplete:(void (^)(NSString *value1,NSString  *value2,NSString *value3))complete;

@property(nonatomic,copy) void  (^complete) (NSString *value1,NSString  *value2,NSString *value3);

@end

NS_ASSUME_NONNULL_END
