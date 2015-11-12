//
//  LZLoginData.m
//  LazyWeekend
//
//  Created by lunarboat on 15/11/11.
//  Copyright © 2015年 lunarboat. All rights reserved.
//

#import "LZLoginData.h"
#import "LZNetTools.h"
#import "LZMainData.h"

#define kGetSessionIDURL @"http://api.lanrenzhoumo.com/other/common/config"
#define kPostMainInfoURL @"http://api.lanrenzhoumo.com/main/recommend/time_to_go"
#define kGetMainInfoURL @"http://api.lanrenzhoumo.com/main/recommend/index"

@implementation LZLoginData

+ (void)getSessionID{
    [LZNetTools getJSONMethodAccessNetworkWithURLString:kGetSessionIDURL parameters:nil ComplationBlock:^(NSDictionary *object) {
        [[NSUserDefaults standardUserDefaults]setValue:[[object objectForKey:@"result"]objectForKey:@"session_id"] forKey:@"session_id"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [object writeToFile:[self getPath] atomically:YES];
    } failed:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

+ (void)postMainDataWithParameters:(NSDictionary *)parameters complationBlock:(void (^) (NSArray *resultArray))complationBlock{
    [LZNetTools postJsonMethodAccessNetworkWithURLString:kPostMainInfoURL parameters:parameters ComplationBlock:^(NSDictionary *object) {
        NSArray *array = [[object objectForKey:@"result"] objectForKey:@"recommend"];
        NSMutableArray *mutableArray = [[NSMutableArray alloc]initWithCapacity:array.count];
        for (NSDictionary *dic in array) {
            LZMainData *data = [[LZMainData alloc]init];
            [data setValuesForKeysWithDictionary:dic];
            [mutableArray addObject:data];
        }
        complationBlock(mutableArray);
    } failed:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

+ (void)getMainDataWithParameters:(NSDictionary *)parameters complationBlock:(void (^) (NSArray *resultArray))complationBlock{
    [LZNetTools getJSONMethodAccessNetworkWithURLString:kGetMainInfoURL parameters:parameters ComplationBlock:^(NSDictionary *object) {
        NSArray *array = [object objectForKey:@"result"];
        NSMutableArray *mutableArray = [[NSMutableArray alloc]initWithCapacity:array.count];
        for (NSDictionary *dic in array) {
            LZMainData *data = [[LZMainData alloc]init];
            [data setValuesForKeysWithDictionary:dic];
            [mutableArray addObject:data];
        }
        complationBlock(mutableArray);
    } failed:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


+ (NSString *)getPath{
    NSString *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
//    NSLog(@"%@",documents);
    return [[documents stringByAppendingPathComponent:@"commonConfig"] stringByAppendingPathExtension:@"plist"];
}

@end
