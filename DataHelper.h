//
//  DataHelper.h
//  KKJob
//
//  Created by Jason on 2019/3/5.
//  Copyright © 2019年 Chan. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kDataHelper [DataHelper shareDataHelper]

#define kIndustryKey @"industry"
#define kDegreeKey @"degree"
#define kSalaryKey @"salary"
#define kExperienceKey @"experience"
#define kPostionKey @"position"
#define kScaleKey @"scale"

NS_ASSUME_NONNULL_BEGIN

@interface DataHelper : NSObject

+ (instancetype)shareDataHelper;

// MARK: - 获取所有版本信息
- (void)getAllVersions;

// MARK: - 根据Key去拉取网络数据 并缓存

- (NSDictionary *)getNetCacheDataWithKey:(NSString *)key;


@end

NS_ASSUME_NONNULL_END
