//
//  LZHobbyCollectionViewCell.h
//  LazyWeekend
//
//  Created by lunarboat on 15/11/11.
//  Copyright © 2015年 lunarboat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZHobbyCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *imageBtn;
@property (weak, nonatomic) IBOutlet UILabel *hobbyTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectedBtn;

@end
