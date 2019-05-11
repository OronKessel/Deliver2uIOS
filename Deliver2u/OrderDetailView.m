//
//  OrderDetailView.m
//  Deliver2u
//
//  Created by q on 11/16/17.
//  Copyright © 2017 Songu. All rights reserved.
//

#import "OrderDetailView.h"

@implementation OrderDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void) setOrderInfo:(OrderModel *) oModel
{
    if (self.bNew)
    {
        self.lblTitle.text = @"New Order!";
    }
    else self.lblTitle.text = @"Details";
    if (oModel.mPickupState == nil) oModel.mPickupState = @"";
    if (oModel.mPickupCity == nil) oModel.mPickupCity = @"";
    if (oModel.mPickupAddress1 == nil) oModel.mPickupAddress1 = @"";
    
    self.lblPickupLocation.text = [NSString stringWithFormat:@"%@ %@ %@",oModel.mPickupState,oModel.mPickupCity, oModel.mPickupAddress1];
    
    if (oModel.mDropState == nil) oModel.mDropState = @"";
    if (oModel.mDropCity == nil) oModel.mDropCity = @"";
    if (oModel.mDropAddress1 == nil) oModel.mDropAddress1 = @"";
    
    self.lblDropLocation.text = [NSString stringWithFormat:@"%@ %@ %@",oModel.mDropState,oModel.mDropCity, oModel.mDropAddress1];
    self.vwParent.layer.cornerRadius = 7;
    self.vwParent.clipsToBounds = YES;
    
    UITapGestureRecognizer *tapParent = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickParent:)];
    [self.vwBackground addGestureRecognizer:tapParent];
}
-(void) clickParent:(UIGestureRecognizer *) gesture
{
    [self hideView];
}

-(void) hideView
{
    [self removeFromSuperview];
}
@end
