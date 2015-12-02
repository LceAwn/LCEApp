//
//  BaseViewController.m
//  LCEApp
//
//  Created by juziwl on 15/5/28.
//  Copyright (c) 2015年 juziwl. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}
-(void)setHiddenNavigationBar:(BOOL)HiddenNavigationBar
{
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;

    if (HiddenNavigationBar) {
        self.navigationController.navigationBar.hidden=YES;
    }else
    {
        self.navigationController.navigationBar.hidden=NO;
    }

}

-(void)loadAlarmView:(NSString *)alarmString
{
    [menuView removeFromSuperview];
    menuView = [[MGFashionMenuView alloc] initWithMenuView:[self createExampleView:alarmString] animationType:MGAnimationTypeWave];
    [self.view.window addSubview:menuView];
    
    [menuView show];
    
    [self performSelector:@selector(hideAlarmView) withObject:self afterDelay:1];
}
- (UIView *)createExampleView:(NSString *)alarmString {
    
    UIView *view = [MyControl viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    [view setBackgroundColor:[UIColor colorWithRed:0 green:0.722 blue:1 alpha:1]];
    
    UILabel *lbl = [MyControl createLabelWithFrame:view.bounds Font:16.0 Text:alarmString];
    [lbl setTextAlignment:NSTextAlignmentCenter];
    [lbl setTextColor:[UIColor whiteColor]];
    [view addSubview:lbl];
    [lbl setCenter:view.center];
    
    return view;
}
-(void)popToViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)showAlarmView
{
    [menuView show];
}
-(void)hideAlarmView
{
    [menuView hide];
    [menuView removeFromSuperview];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
