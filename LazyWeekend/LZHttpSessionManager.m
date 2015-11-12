//
//  LZHttpSessionManager.m
//  LazyWeekend
//
//  Created by lunarboat on 15/11/12.
//  Copyright © 2015年 lunarboat. All rights reserved.
//

#import "LZHttpSessionManager.h"

@implementation LZHttpSessionManager

+ (instancetype)shareManager{
    static LZHttpSessionManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [LZHttpSessionManager manager];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    });
    return _manager;
}

@end
