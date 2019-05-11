//
//  LoginViewController.h
//  Deliver2u
//
//  Created by BoHuang on 10/27/17.
//  Copyright © 2017 Songu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceResultDelegate.h"

@interface LoginViewController : UIViewController<ServiceResultDelegate>
@property (weak, nonatomic) IBOutlet UITextField *editUser;
@property (weak, nonatomic) IBOutlet UITextField *editPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnForget;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIButton *btnSignup;

@end
