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
#import <UMSocial.h>

#define kSettingInfoSegue @"ToSettingInfo"
#define kToMainVC @"ToMainVC"



@interface LZLunchViewController ()<UMSocialUIDelegate>{
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
        [self weiboSSOLogin];
    }else if (sender.tag == 11){
        //进行微信登录
        [self umengShareSocial];
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


//进行微博授权登录(官方)
- (void)weiboSSOLogin{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURL;
    request.scope = @"all";
    request.userInfo = @{@"name":@"lunarboat", @"age":@"22"};
    [WeiboSDK sendRequest:request];
}

//友盟SSO第三方登录
//- (void)weiboSSOLogin{
//    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
//    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService], YES, ^(UMSocialResponseEntity * response){
//        if (response.responseCode == UMSResponseCodeSuccess) {
//            
//            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
//            
//            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
//        }});
//}

//练习分享
- (void)umengShareSocial{
    [UMSocialSnsService presentSnsIconSheetView:self appKey:kUmengAppkey shareText:@"测试分享" shareImage:nil shareToSnsNames:@[UMShareToSina, UMShareToTencent, UMShareToWechatTimeline, UMShareToQQ, UMShareToQzone, UMShareToWechatSession, UMShareToSms] delegate:self];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kToMainVC]) {
        UINavigationController *nav = segue.destinationViewController;
        UIViewController *vc = nav.topViewController;
        [vc setValue:_dataArray forKey:@"dataArray"];
    }
}

#pragma mark - 分享
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response{
    NSLog(@"分享完成");
}

@end
