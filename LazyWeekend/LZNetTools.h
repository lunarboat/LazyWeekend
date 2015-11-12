//
//  LZNetTools.h
//  LazyWeekend
//
//  Created by lunarboat on 15/11/11.
//  Copyright © 2015年 lunarboat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZNetTools : NSObject

+ (void)getJSONMethodAccessNetworkWithURLString:(NSString *)URLString parameters:(NSDictionary *)parametersDic ComplationBlock:(void (^) (NSDictionary *object))complationBlock failed:(void (^) (NSError *error))failedBlock;
+ (void)postJsonMethodAccessNetworkWithURLString:(NSString *)URLString parameters:(NSDictionary *)parametersDic ComplationBlock:(void (^) (NSDictionary *object))complationBlock failed:(void (^) (NSError *error))failedBlock;

@end
