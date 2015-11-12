//
//  LZPersonInfoViewController.m
//  LazyWeekend
//
//  Created by lunarboat on 15/11/9.
//  Copyright © 2015年 lunarboat. All rights reserved.
//

#import "LZPersonInfoViewController.h"
#define SexButtonTagPerfix 10
#define StatusButtonTagPerfix 20
#define BarButtonTagPerfix 30

@interface LZPersonInfoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *catMeImageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stackView1Y;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stackView2Y;


@end

@implementation LZPersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.catMeImageView.layer.cornerRadius = _catMeImageView.bounds.size.width / 2;
    self.catMeImageView.clipsToBounds = YES;
    
}
//tag = index + 10
- (IBAction)sexSelectedClick:(UIButton *)sender {
    if (!sender.selected) {
        sender.selected = YES;
        CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
        basic.duration = .2f;
        basic.fromValue = @0;
        basic.toValue = @(M_PI);
        basic.removedOnCompletion = YES;
        basic.fillMode = kCAFillModeBoth;
        basic.autoreverses = YES;
        [sender.layer addAnimation:basic forKey:@"SexButtonRotation"];
        
        for (int i=0; i<2; i++) {
            UIButton *button = [self.view viewWithTag:SexButtonTagPerfix + i];
            if (button != sender) {
                button.selected = NO;
            }
        }
        
    }
}
//tag = index + 20
- (IBAction)statusSelectClick:(UIButton *)sender{
    if (!sender.selected) {
        sender.selected = YES;
        for (int i=0; i<3; i++) {
            UIButton *button = [self.view viewWithTag:StatusButtonTagPerfix + i];
            if (button != sender) {
                button.selected = NO;
            }
        }
        
    }
}
//tag = index + 30
- (IBAction)barBtnClick:(UIBarButtonItem *)sender {
    if (sender.tag == BarButtonTagPerfix + 1) {
        for (int i=0; i<2; i++) {
            UIButton *button1 = [self.view viewWithTag:SexButtonTagPerfix + i];
            for (int j=0; j<3; j++) {
                UIButton *button2 = [self.view viewWithTag:StatusButtonTagPerfix + j];
                if (button1.selected && button2.selected) {
                    [self performSegueWithIdentifier:@"ToHobbiesVC" sender:self];
                }
            }
        }
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
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
