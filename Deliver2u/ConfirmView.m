//
//  ConfirmView.m
//  Deliver2u
//
//  Created by q on 11/17/17.
//  Copyright © 2017 Songu. All rights reserved.
//

#import "ConfirmView.h"
#import "HomeViewController.h"

@implementation ConfirmView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void) setParent:(HomeViewController*) parent
{
    self.parentController = parent;
}
-(void) setOrderInfo:(OrderModel *) oModel
{
    self.btnConfirm.layer.cornerRadius = self.btnConfirm.bounds.size.width / 2;
    self.btnConfirm.clipsToBounds = YES;
    
    if (oModel.mPickupState == nil) oModel.mPickupState = @"";
    if (oModel.mPickupCity == nil) oModel.mPickupCity = @"";
    if (oModel.mPickupAddress1 == nil) oModel.mPickupAddress1 = @"";
    
    self.lblPickup.text = [NSString stringWithFormat:@"%@ %@ %@",oModel.mPickupState,oModel.mPickupCity, oModel.mPickupAddress1];
    self.lblVendor.text = oModel.mVendorName;
    
    UITapGestureRecognizer *tapParent = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickParent:)];
    [self.vwBack addGestureRecognizer:tapParent];
}
-(void) clickParent:(UIGestureRecognizer *) gesture
{
    [self hideView];
    [self.parentController clearPathMap];
}

-(void) hideView
{
    [self removeFromSuperview];
}
@end
