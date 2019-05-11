//
//  LoginViewController.m
//  Deliver2u
//
//  Created by BoHuang on 10/27/17.
//  Copyright © 2017 Songu. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "UserModel.h"
#import "Utils.h"
#import "ServiceManage.h"
#import "Globals.h"
#import "HomeViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.btnForget addTarget:self action:@selector(clickForget) forControlEvents:UIControlEventTouchUpInside];
    [self.btnSignup addTarget:self action:@selector(clickRegister) forControlEvents:UIControlEventTouchUpInside];
    [self.btnLogin addTarget:self action:@selector(clickLogin) forControlEvents:UIControlEventTouchUpInside];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) clickForget
{
}

-(void) clickRegister
{
    RegisterViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"RegisterViewController"];
    [self presentViewController:vc animated:YES completion:nil];
}

-(void) clickLogin
{
    NSString *email = self.editUser.text;
    NSString *password = self.editPassword.text;
    if ([email isEqualToString:@""])
    {
        [Utils showErrorDialog:@"Please fill email address"];
        return;
    }
    else if ([password isEqualToString:@""])
    {
        [Utils showErrorDialog:@"Please fill password"];
        return;
    }
    UserModel *uModel = [[UserModel alloc] init];
    uModel.mEmail = email;
    uModel.mPassword = password;
    [Utils addActivityIndicator:self.view];
    [ServiceManage serviceLogin:uModel :self];
}

-(void) result:(int) code
{
    [Utils removeActivityIndicator:self.view];
    HomeViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeViewController"];
    switch (code) {
        case 0://Success
            [Globals saveUserInfo];
            [self presentViewController:vc animated:YES completion:nil];
            break;
        case 1://Fail
            [Utils showErrorDialog:@"Oops,that email is not registered."];
            break;
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
