//
//  ForgetViewController.m
//  LCEApp
//
//  Created by juziwl on 15/6/3.
//  Copyright (c) 2015年 juziwl. All rights reserved.
//

#import "ForgetViewController.h"

@interface ForgetViewController ()
{
    int cycleTimes;
}
@end

@implementation ForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.HiddenNavigationBar=YES;
    cycleTimes=0;

    CADisplayLink* gameTimer;
    gameTimer = [CADisplayLink displayLinkWithTarget:self
                                            selector:@selector(updateDisplay:)];
    [gameTimer addToRunLoop:[NSRunLoop currentRunLoop]
                    forMode:NSDefaultRunLoopMode];

 
}
-(void)updateDisplay:(id)sender
{
    //旋转动画
    cycleTimes=cycleTimes+1;
    if(cycleTimes>45)
    {
        cycleTimes=1;
    }
    self.loadingIMV.layer.affineTransform=CGAffineTransformMakeRotation(M_PI*2/45*cycleTimes);

}
- (IBAction)buttonClick:(UIButton *)sender
{
    
    [self  popToViewController];
    
    CATransition *tran=[CATransition animation];
    tran.duration=0.75;
    tran.type=@"rippleEffect";
    tran.subtype=kCATransitionFromLeft;
    [self.navigationController.view.layer addAnimation:tran forKey:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
