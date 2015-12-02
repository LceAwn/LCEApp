//
//  LoginViewController.m
//  LCEApp
//
//  Created by juziwl on 15/5/28.
//  Copyright (c) 2015年 juziwl. All rights reserved.
//

#import "LoginViewController.h"
#import "ForgetViewController.h"
#import "WSCoachMarksView.h"

@interface LoginViewController ()<UITextFieldDelegate,WSCoachMarksViewDelegate>
{
    IBOutlet UIWebView *webViewBG;

}

@end

@implementation LoginViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.HiddenNavigationBar=YES;
//    [self internalGuide];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"railway" ofType:@"gif"];
    NSData *gif = [NSData dataWithContentsOfFile:filePath];
    
    [webViewBG loadData:gif MIMEType:@"image/gif" textEncodingName:@"" baseURL:[NSURL URLWithString:@""]];

    webViewBG.autoresizesSubviews = YES;//自动调整大小
    webViewBG.scalesPageToFit =YES;//自动对页面进行缩放以适应屏幕
    webViewBG.delegate=self;
    webViewBG.userInteractionEnabled = NO;

    [self initViewDatil];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{    
    [webView stringByEvaluatingJavaScriptFromString:@"document.body.style.zoom = 2.0;"];
}

-(void)internalGuide
{
    NSArray *coachMarks = @[
                            @{
                                @"rect":[NSValue valueWithCGRect:(CGRect){{14,42},{200,60}}],
                                @"caption":@"用户登录",
                                @"shape": @"square"
                                },
                            @{
                                @"rect": [NSValue valueWithCGRect:(CGRect){{(SCREEN_WIDTH-90)/2,117.0f},{90.0f,90.0f}}],
                                @"caption": @"用户头像",
                                @"shape": @"circle"
                                },
                            @{
                                @"rect": [NSValue valueWithCGRect:CGRectMake(20, 230, SCREEN_WIDTH-40, 50)],
                                @"caption": @"姓名"
                                },
                            @{
                                @"rect": [NSValue valueWithCGRect:CGRectMake(20, 300, SCREEN_WIDTH-40, 50)],
                                @"caption": @"密码"
                                },
//                            @{
//                                @"rect": [NSValue valueWithCGRect:(CGRect){{10.0f,SCREEN_HEIGHT-90},{300.0f,56.0f}}],
//                                @"caption": @"Invite friends to get more photos"
//                                },
//                            @{
//                                @"rect": [NSValue valueWithCGRect:(CGRect){{0.0f,410.0f},{320.0f,50.0f}}],
//                                @"caption": @"Keep your guests informed with your wedding details"
//                                }
                            ];
    WSCoachMarksView *coachMarksView = [[WSCoachMarksView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) coachMarks:coachMarks];
    coachMarksView.delegate=self;
    [self.view addSubview:coachMarksView];
    [coachMarksView start];

}
- (void)coachMarksView:(WSCoachMarksView*)coachMarksView willNavigateToIndex:(NSUInteger)index
{

}
- (void)coachMarksView:(WSCoachMarksView*)coachMarksView didNavigateToIndex:(NSUInteger)index
{

}
- (void)coachMarksViewWillCleanup:(WSCoachMarksView*)coachMarksView
{

}
- (void)coachMarksViewDidCleanup:(WSCoachMarksView*)coachMarksView
{

}

-(void)initViewDatil
{
//    //动画 水
//    [self.waterWaveView wave];
     self.nameImageView.image=[UIImage imageNamed:@"headerImage"];

    /// 名字
    [self setupInputRectangle];
}

- (void)setupInputRectangle
{
    nameField.inputAccessoryView=self.inputAccessoryView;
    pawField.inputAccessoryView=self.inputAccessoryView;
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self diminishTextName:(textField==nameField)?nameLabel:pawLabel];
    [self diminishImage:(textField==nameField)?nameIMG:pawIMG];
    
    return YES;

}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (textField == nameField) {
        
        if ((self.view.height - nameField.center.y) < 346) {
            [UIView animateWithDuration:0.25 animations:^{
                self.view.center = CGPointMake(self.view.centerX,self.view.height - nameField.centerY-100);
            } completion:^(BOOL finished) {
                NSLog(@"success");
            }];
        }
        
    }else if (textField == pawField)
    {
        
        if ((self.view.height - pawField.center.y) < 286) {
            [UIView animateWithDuration:0.25 animations:^{
                
                self.view.center = CGPointMake(self.view.centerX, self.view.height - pawField.centerY-30);
            } completion:^(BOOL finished) {
                NSLog(@"success");
            }];
            
        }
    }

}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
        [UIView animateWithDuration:0.25 animations:^{
            
            self.view.center = CGPointMake(self.view.center.x, self.view.frame.size.height/2);
            
        } completion:^(BOOL finished) {
            NSLog(@"success");
        }];


    if ([Utils isBlankString:textField.text]) {
        [self restoreTextName:(textField==nameField)?nameLabel:pawLabel];
        [self restoreImage:(textField==nameField)?nameIMG:pawIMG];
    
    }


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)diminishTextName:(UILabel *)label
{
    [UIView animateWithDuration:0.5 animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, -26);
        label.font = [UIFont systemFontOfSize:17];
        label.textColor = [UIColor blackColor];
        
    }];
    
}

- (void)diminishImage:(UIImageView *)IMG
{
    [UIView animateWithDuration:0.5 animations:^{
        IMG.transform = CGAffineTransformMakeTranslation(0, -2);
        IMG.backgroundColor = [UIColor blackColor];
    }];
    
}
- (void)restoreImage:(UIImageView *)IMG
{
    [UIView animateWithDuration:0.5 animations:^{
        IMG.transform = CGAffineTransformIdentity;
        IMG.backgroundColor = [UIColor grayColor];
    }];
    
}
- (void)restoreTextName:(UILabel *)label
{
        [UIView animateWithDuration:0.5 animations:^{
            label.transform = CGAffineTransformIdentity;
            label.font = [UIFont systemFontOfSize:15];
            label.textColor = UIColorFromRGB(0x979797);
        }];
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (IBAction)downBtn:(UIButton *)sender {
    [self.view endEditing:YES];

}

- (IBAction)certainBtn:(UIButton *)sender
{
    if ([Utils isBlankString:nameField.text]) {
        [self loadAlarmView:@"请输入账号"];

        [Utils errorShaked:self.nameImageView delegate:self];

    }else if([Utils isBlankString:pawField.text])
    {
        [self loadAlarmView:@"请输入密码"];
        [Utils errorShaked:self.nameImageView delegate:self];

    }else
    {
        [UIView animateWithDuration:0.25 animations:^(void){
            heightCst.constant=568;
        }];

    }
}
- (IBAction)ForgetViewBtnClick:(UIButton *)sender
{
    ForgetViewController *forgetVC=[[ForgetViewController alloc]initWithNibName:@"ForgetViewController" bundle:nil];
    
    [self.navigationController pushViewController:forgetVC animated:YES];
    //因为一个事件循环机制中
    CATransition *tran=[CATransition animation];
    tran.duration=0.75;
    tran.type=@"rippleEffect";
    tran.subtype=kCATransitionFromLeft;
    [self.navigationController.view.layer addAnimation:tran forKey:nil];
    
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
