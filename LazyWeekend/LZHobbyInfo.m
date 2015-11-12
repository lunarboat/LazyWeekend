//
//  LZHobbyInfo.m
//  LazyWeekend
//
//  Created by lunarboat on 15/11/11.
//  Copyright © 2015年 lunarboat. All rights reserved.
//

#import "LZHobbyInfo.h"

@implementation LZHobbyInfo



- (NSArray *)titleArray{
    return @[@"周边游", @"酒吧", @"音乐", @"戏剧", @"展览", @"美食", @"购物", @"电影", @"聚会", @"运动", @"公益", @"商业"];
}
- (NSArray *)imageArray{
    NSMutableArray *mutableArray = [[NSMutableArray alloc]initWithCapacity:self.titleArray.count];
    for (int i=0; i<self.titleArray.count; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"ic_c_%d_small_small", i]];
        [mutableArray addObject:image];
    }
    return mutableArray;
}
- (NSArray *)unSelectedImageArray{
    NSMutableArray *mutableArray = [[NSMutableArray alloc]initWithCapacity:self.titleArray.count];
    for (int i=0; i<self.titleArray.count; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"ic_c_%d_gray", i]];
        [mutableArray addObject:image];
    }
    return mutableArray;
}

@end
