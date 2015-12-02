//
//  LoginViewController.h
//  LCEApp
//
//  Created by juziwl on 15/5/28.
//  Copyright (c) 2015年 juziwl. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginViewController : BaseViewController
{
    IBOutlet UITextField *nameField;
    IBOutlet UITextField *pawField;

    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *pawLabel;
    
    IBOutlet NSLayoutConstraint *heightCst;
    IBOutlet UIImageView *nameIMG;
    
    IBOutlet UIView *bgView;
    IBOutlet UIImageView *pawIMG;
}
@property (strong, nonatomic) IBOutlet UIView *inputAccessoryView;
@property (strong, nonatomic) IBOutlet KYWaterWaveView *waterWaveView;
@property (strong, nonatomic) IBOutlet UIImageView *nameImageView;


@end
