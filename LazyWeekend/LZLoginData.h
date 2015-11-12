//
//  LZLoginData.h
//  LazyWeekend
//
//  Created by lunarboat on 15/11/11.
//  Copyright © 2015年 lunarboat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZLoginData : NSObject

+ (void)getSessionID;

+ (void)postMainDataWithParameters:(NSDictionary *)parameters complationBlock:(void (^) (NSArray *resultArray))complationBlock;
+ (void)getMainDataWithParameters:(NSDictionary *)parameters complationBlock:(void (^) (NSArray *resultArray))complationBlock;
@end
