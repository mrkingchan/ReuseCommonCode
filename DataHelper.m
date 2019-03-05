//
//  DataHelper.m
//  KKJob
//
//  Created by Jason on 2019/3/5.
//  Copyright © 2019年 Chan. All rights reserved.
//

#import "DataHelper.h"

#define kUserDefaultSet(key,value) [[NSUserDefaults standardUserDefaults] setObject:value forKey:key]
#define kSynchronize  [[NSUserDefaults standardUserDefaults] synchronize]
#define kUserDefaultValue(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]
#define kAllVersionData             [[NSUserDefaults standardUserDefaults] objectForKey:@"CacheAllVersions"]

#define kCategeoryDataPath @"basicdata/api/system-metadata/find-cache-data"

@implementation DataHelper


+ (instancetype)shareDataHelper {
    
    static DataHelper *_helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _helper = [[DataHelper alloc] init];
        [_helper getAllVersions];
    });
    return _helper;
}

-(void)getAllVersions {
    [NetTool postWithPath:kAllVersion params:nil sucess:^(NSDictionary * _Nonnull json) {
        /*
         {
         "status": true,
         "message": null,
         "failureCode": null,
         "failureMsg": null,
         "extend": "CACHE",
         "data": {

         "BossReports": "1.0",
         "GeekReports": "1.0",
         "SMS_MES_Des": "1.0",
         "businessDistrict": "1",
         "hotCity": "11.9",
         "GeekInterviewCommentTag": "1.0",
         "geekFilterConfig": "11.9",
         "hotJobServiceHint": "1.0",
         "industry": "11.9",
         "positionWordsCategory": "11.9",
         "labels": "1.0",
         "workCategorywords": "11.9",
         "experience": "11.9",
         "BossInterviewCommentTag": "1.0",
         "hotJobHint": "1.0",
         "telenote": "1.0",
         "position": "11.9",
         "industryHeader": "11.9",
         "BossShareText": "1.0",
         "BossSilence": "1.0",
         "salary": "11.9",
         "degree": "11.9",
         "BossLurekeyword": "1.0",
         "SeekerSilence": "1.0",
         "bossFilterConfig": "11.9",
         "GeekInterviewComment": "1.0",
         "subway": "1.3",
         "SeekerLurekeyword": "1.0",
         "scale": "11.9"
         }
         }
         */
        
        if (json[@"data"]) {
            //存版本号信息
            kUserDefaultSet(@"CacheAllVersions", json[@"data"]);
            kSynchronize;
        }
    }];
}

- (NSDictionary *)getNetCacheDataWithKey:(NSString *)key {
    NSDictionary *allVersionDic = kAllVersionData;
    NSString *version = [allVersionDic objectForKey:key];
    NSString *cachedVersion = [((NSDictionary *) kUserDefaultValue(key)) objectForKey:key][@"dataVersion"];
    //对比版本号
    if (!version || !version.length || (![version  isEqualToString:cachedVersion] && version)) {
        [NetTool postWithPath:kCategeoryDataPath params:@{@"dataGroupKeys":key} sucess:^(NSDictionary * _Nonnull json) {
            if (json) {
                kUserDefaultSet(key, json[@"data"]);
                kSynchronize;
            }
        }];
    }
    return kUserDefaultValue(key);
}

@end
