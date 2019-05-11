//
//  ConfirmView.h
//  Deliver2u
//
//  Created by q on 11/17/17.
//  Copyright © 2017 Songu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
#import "HomeViewController.h"
@class HomeViewController;
@interface ConfirmView : UIView
@property (weak, nonatomic) IBOutlet UILabel *lblPickup;
@property (weak, nonatomic) IBOutlet UIButton *btnConfirm;
@property (weak, nonatomic) IBOutlet UILabel *lblVendor;
@property (weak, nonatomic) IBOutlet UIView *vwBack;

@property HomeViewController *parentController;

-(void) setParent:(HomeViewController*) parent;
-(void) setOrderInfo:(OrderModel *) oModel;
-(void) hideView;

@end
