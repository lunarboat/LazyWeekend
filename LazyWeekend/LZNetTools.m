//
//  LZNetTools.m
//  LazyWeekend
//
//  Created by lunarboat on 15/11/11.
//  Copyright © 2015年 lunarboat. All rights reserved.
//

#import "LZNetTools.h"
#import "LZHttpSessionManager.h"

@implementation LZNetTools

+ (void)getJSONMethodAccessNetworkWithURLString:(NSString *)URLString parameters:(NSDictionary *)parametersDic ComplationBlock:(void (^) (NSDictionary *object))complationBlock failed:(void (^) (NSError *error))failedBlock{
    LZHttpSessionManager *manager = [LZHttpSessionManager shareManager];
    [manager GET:URLString parameters:parametersDic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (complationBlock) {
            complationBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failedBlock) {
            failedBlock(error);
        }
    }];
}
+ (void)postJsonMethodAccessNetworkWithURLString:(NSString *)URLString parameters:(NSDictionary *)parametersDic ComplationBlock:(void (^) (NSDictionary *object))complationBlock failed:(void (^) (NSError *error))failedBlock{
    LZHttpSessionManager *manager = [LZHttpSessionManager shareManager];
    [manager POST:URLString parameters:parametersDic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (complationBlock) {
            complationBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failedBlock) {
            failedBlock(error);
        }
    }];
}

@end
