 //
//  LZLunchViewController.m
//  LazyWeekend
//
//  Created by lunarboat on 15/11/8.
//  Copyright © 2015年 lunarboat. All rights reserved.
//

#import "LZLunchViewController.h"
#import "CWDAutoScrollView.h"
#import "LZLoginData.h"

#define kSettingInfoSegue @"ToSettingInfo"
#define kToMainVC @"ToMainVC"

@interface LZLunchViewController (){
    NSArray *_dataArray;
}
@property (weak, nonatomic) IBOutlet UIButton *wbLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *wxLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *pickViewBtn;

@property (nonatomic, assign) BOOL isEntry;

@end

@implementation LZLunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //加载变换动画
    [self loadScrollView];
    
}

- (void)loadScrollView{
    CWDAutoScrollView *autoScrollView = [[CWDAutoScrollView alloc]init];
    [autoScrollView updateViewWithImageArray:@[[UIImage imageNamed:@"1"], [UIImage imageNamed:@"2"], [UIImage imageNamed:@"3"], [UIImage imageNamed:@"4"]]];
    autoScrollView.height = self.view.height;
    autoScrollView.infiniteScrolling = YES;
    autoScrollView.userInteractionEnabled = NO;
    [autoScrollView startAutoScrollWithInterval:3];
    [self.view addSubview:autoScrollView];
    [self.view bringSubviewToFront:self.wbLoginBtn];
    [self.view bringSubviewToFront:self.wxLoginBtn];
    [self.view bringSubviewToFront:self.pickViewBtn];
}

#pragma mark - initial
- (BOOL)isEntry{
    return (GETSESSIONID != nil && ![GETSESSIONID isEqualToString:@""]);
}


#pragma mark - target-action
- (IBAction)loginBtnClick:(UIButton *)sender {
    if (sender.tag == 10) {
        //进行微博登录
        NSLog(@"sinalogin");
    }else if (sender.tag == 11){
        //进行微信登录
        NSLog(@"weChatlogin");
    }else{
        return;
    }
}

- (IBAction)peekClick:(id)sender {
    
    if (self.isEntry == YES) {
        //执行跳到主页面segue ,用sessionid取到数据
        NSDictionary *parameters = @{@"session_id":GETSESSIONID, @"v":@"3", @"page":@"1", @"lon":GETLON, @"lat":GETLAT};
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //这里应该加个hud延时加载，完成网络请求跳转后消失
            [LZLoginData getMainDataWithParameters:parameters complationBlock:^(NSArray *resultArray) {
                _dataArray = resultArray;
                dispatch_async(dispatch_get_main_queue(), ^{
                [self performSegueWithIdentifier:kToMainVC sender:self];
                });
            }];
        });
      
        
    }else{
        //执行跳到填写个人资料页面
        //获取session_id
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [LZLoginData getSessionID];
        });
        [self performSegueWithIdentifier:kSettingInfoSegue sender:self];
    }
    
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kToMainVC]) {
        UINavigationController *nav = segue.destinationViewController;
        UIViewController *vc = nav.topViewController;
        [vc setValue:_dataArray forKey:@"dataArray"];
    }
}


@end
