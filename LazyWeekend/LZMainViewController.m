//
//  LZMainViewController.m
//  LazyWeekend
//
//  Created by lunarboat on 15/11/8.
//  Copyright © 2015年 lunarboat. All rights reserved.
//

#import "LZMainViewController.h"
#import "LZMainData.h"
#import "LZMainCell.h"
#import "LZLoginData.h"
#import <UIImageView+WebCache.h>

#define MainCellID @"MainCell"

@interface LZMainViewController ()<UITableViewDataSource, UITableViewDelegate>{
    
    __weak IBOutlet UITableView *_tableView;
}

@end

@implementation LZMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSLog(@"%@",self.dataArray);
    if (!self.dataArray) {
        NSDictionary *parameters = @{@"session_id":GETSESSIONID, @"v":@"3", @"page":@"1", @"lon":GETLON, @"lat":GETLAT};
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //这里应该加个hud延时加载，完成网络请求跳转后消失
            [LZLoginData getMainDataWithParameters:parameters complationBlock:^(NSArray *resultArray) {
                _dataArray = resultArray;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_tableView reloadData];
                });
            }];
        });
    }
}


#pragma mark - tableViewDelegate && tableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LZMainData *data = [self.dataArray objectAtIndex:indexPath.row];
    LZMainCell *cell = [tableView dequeueReusableCellWithIdentifier:MainCellID];
    [cell.headerImageView sd_setImageWithURL:[NSURL URLWithString:data.front_cover_image_list[0]]];
    cell.titleLabel.text = data.title;
    cell.subtitleLabel.text = [NSString stringWithFormat:@"%@・%.2fkm・%@", data.title, (data.distance / 1000.0f), data.category];
    cell.timeInfoLabel.text = data.time_info;
    cell.collectedNumLabel.text = [NSString stringWithFormat:@"%ld人收藏", data.collected_num];
    cell.priceLabel.text = [NSString stringWithFormat:@"¥%ld", data.price];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.view.bounds.size.width;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
