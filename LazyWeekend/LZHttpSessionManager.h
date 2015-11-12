//
//  LZHttpSessionManager.h
//  LazyWeekend
//
//  Created by lunarboat on 15/11/12.
//  Copyright © 2015年 lunarboat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface LZHttpSessionManager : AFHTTPSessionManager

+ (instancetype)shareManager;

@end
