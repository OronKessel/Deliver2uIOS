//
//  RegisterViewController.m
//  Deliver2u
//
//  Created by BoHuang on 10/27/17.
//  Copyright © 2017 Songu. All rights reserved.
//

#import "RegisterViewController.h"
#import "Globals.h"
#import "Config.h"
#import "Utils.h"
#import "UserModel.h"
#import "ServiceManage.h"
#import "HomeViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.btnRegister addTarget:self action:@selector(clickRegister) forControlEvents:UIControlEventTouchUpInside];
    [self.btnLogin addTarget:self action:@selector(clickLogin) forControlEvents:UIControlEventTouchUpInside];
}
-(void) clickRegister
{
    NSString *email = self.editEmail.text;
    NSString *user = self.editUser.text;
    NSString *password = self.editPassword.text;
    NSString *confirm = self.editConfirm.text;
    
    if ([email isEqualToString:@""])
    {
        [Utils showErrorDialog:@"Please fill email address"];
        return;
    }
    else if ([user isEqualToString :@""])
    {
        [Utils showErrorDialog:@"Please fill name"];
        return;
    }
    else if ([password isEqualToString:@""])
    {
        [Utils showErrorDialog:@"Please fill password"];
        return;
    }
    else if (![password isEqualToString:confirm])
    {
        [Utils showErrorDialog:@"Two passwords don't match"];
        return;
    }
    UserModel *uModel = [[UserModel alloc] init];
    uModel.mName = user;
    uModel.mEmail = email;
    uModel.mPassword = password;
    [Utils addActivityIndicator:self.view];
    [ServiceManage serviceRegister:uModel :self];    
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


-(void) clickLogin
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void) closeScreen
{
    [self dismissViewControllerAnimated:NO completion:nil];
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
