//
//  LZHobbiesViewController.m
//  LazyWeekend
//
//  Created by lunarboat on 15/11/10.
//  Copyright © 2015年 lunarboat. All rights reserved.
//

#import "LZHobbiesViewController.h"
#import "LZHobbyInfo.h"
#import "LZHobbyCollectionViewCell.h"
#import "LZLocationCoordinate.h"
#import "LZLoginData.h"

#define kBarItemTagPerfix 30
#define kInterestsPerfix 3
#define ItemID @"HobbyItem"
#define kComplationInfoToMain @"ComplationInfoToMain"

@interface LZHobbiesViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>{
    LZHobbyInfo *hobbyInfo;
    NSMutableArray *_selectedItems;
    LZLocationCoordinate *coor;
    NSArray *_dataArray;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableDictionary *postParameterDic;
@end

@implementation LZHobbiesViewController

- (NSMutableDictionary *)postParameterDic{
    _postParameterDic = [[NSMutableDictionary alloc]init];
    [_postParameterDic setObject:@"1" forKey:@"gender"];
    [_postParameterDic setObject:@"3" forKey:@"v"];
    [_postParameterDic setObject:@"匿名用户" forKey:@"nickname"];
    [_postParameterDic setObject:@"4" forKey:@"personal_status"];
    return _postParameterDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    hobbyInfo = [[LZHobbyInfo alloc]init];
    _selectedItems = [[NSMutableArray alloc]init];
    [self.postParameterDic setObject:GETSESSIONID forKey:@"session_id"];
    
    coor = [[LZLocationCoordinate alloc]init];
    [coor addObserver:self forKeyPath:@"lat" options:NSKeyValueObservingOptionNew context:nil];
    [coor addObserver:self forKeyPath:@"lon" options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark - collectionViewdelegata&datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return hobbyInfo.titleArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LZHobbyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ItemID forIndexPath:indexPath];
    cell.hobbyTitleLabel.text = hobbyInfo.titleArray[indexPath.item];
    [cell.imageBtn setImage:hobbyInfo.unSelectedImageArray[indexPath.item] forState:UIControlStateNormal];
    [cell.imageBtn setImage:hobbyInfo.imageArray[indexPath.item] forState:UIControlStateSelected];
    cell.imageBtn.selected = NO;
    cell.imageBtn.userInteractionEnabled = NO;
    cell.selectedBtn.selected = NO;
    cell.selectedBtn.userInteractionEnabled = NO;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LZHobbyCollectionViewCell *cell = (LZHobbyCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.imageBtn.selected = !cell.imageBtn.selected;
    cell.selectedBtn.selected = !cell.selectedBtn.selected;
    if (cell.imageBtn.selected) {
        if (indexPath.item == 0) {
             [_selectedItems addObject:[NSString stringWithFormat:@"%ld",(long)indexPath.item + kInterestsPerfix]];
        }else{
            [_selectedItems addObject:[NSString stringWithFormat:@"%ld",(long)indexPath.item + kInterestsPerfix + 1]];
        }
    }else{
        if (indexPath.item == 0) {
             [_selectedItems removeObject:[NSString stringWithFormat:@"%ld",(long)indexPath.item + kInterestsPerfix]];
        }else{
             [_selectedItems removeObject:[NSString stringWithFormat:@"%ld",(long)indexPath.item + kInterestsPerfix + 1]];
        }
        
    }
    
   
}


- (IBAction)barBtnClick:(UIBarButtonItem *)sender {
    if (sender.tag == kBarItemTagPerfix) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        if (_selectedItems.count > 0) {
            NSString *resultString = [_selectedItems firstObject];
            if (_selectedItems.count > 1) {
                [_selectedItems removeObjectAtIndex:0];
                for (NSString *indexStr in _selectedItems) {
                    resultString = [resultString stringByAppendingString:[NSString stringWithFormat:@",%@",indexStr]];
                }
            }
            
            [_postParameterDic setObject:resultString forKey:@"interests"];
            [LZLoginData postMainDataWithParameters:_postParameterDic complationBlock:^(NSArray *resultArray) {
                _dataArray = resultArray;
                [self performSegueWithIdentifier:kComplationInfoToMain sender:self];
            }];
        }else{
            NSLog(@"需要选择一个兴趣爱好");
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"lat"]) {
        [_postParameterDic setObject:@"22.284681" forKey:@"lat"];
        [[NSUserDefaults standardUserDefaults]setValue:@"22.284681" forKey:@"lat"];
    }
    if ([keyPath isEqualToString:@"lon"]) {
        [_postParameterDic setObject:@"114.158177" forKey:@"lon"];
        [[NSUserDefaults standardUserDefaults]setValue:@"114.158177" forKey:@"lon"];
    }
    
}

- (void)dealloc{
    [coor removeObserver:self forKeyPath:@"lon"];
    [coor removeObserver:self forKeyPath:@"lat"];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"ComplationInfoToMain"]) {
        UINavigationController *nav = segue.destinationViewController;
        UIViewController *vc = nav.topViewController;
        [vc setValue:_dataArray forKey:@"dataArray"];
    }
}


@end
