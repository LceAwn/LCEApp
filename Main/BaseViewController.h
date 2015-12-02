//
//  BaseViewController.h
//  LCEApp
//
//  Created by juziwl on 15/5/28.
//  Copyright (c) 2015年 juziwl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
{
    MGFashionMenuView *menuView;
}

@property (assign, nonatomic) BOOL HiddenNavigationBar;

-(void)popToViewController;
-(void)loadAlarmView:(NSString *)alarmString;
-(void)showAlarmView;
-(void)hideAlarmView;

@end
