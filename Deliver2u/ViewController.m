//
//  ViewController.m
//  Deliver2u
//
//  Created by BoHuang on 10/27/17.
//  Copyright © 2017 Songu. All rights reserved.
//

#import "ViewController.h"
#import "ServiceManage.h"
#import "Globals.h"
#import "LoginViewController.h"
#import "HomeViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [Globals loadUserInfo];
    [ServiceManage serviceLogin:mAccount :self];
    
}

-(void) closeScreen
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) result:(int) code
{
    //[Utils removeActivityIndicator:self.view];
    LoginViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginViewController"];
    HomeViewController *vcHome = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeViewController"];
    switch (code) {
        case 0://Success
            [Globals saveUserInfo];
            [self presentViewController:vcHome animated:YES completion:nil];
            break;
        case 1:
            [self presentViewController:vc animated:YES completion:nil];
            break;
    }
}


@end
