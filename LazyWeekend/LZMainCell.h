//
//  LZMainCell.h
//  LazyWeekend
//
//  Created by lunarboat on 15/11/12.
//  Copyright © 2015年 lunarboat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZMainCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *collectedNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end
