//
//  OrderDetailView.h
//  Deliver2u
//
//  Created by q on 11/16/17.
//  Copyright © 2017 Songu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

@interface OrderDetailView : UIView
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblPickupLocation;
@property (weak, nonatomic) IBOutlet UILabel *lblDropLocation;
@property (weak, nonatomic) IBOutlet UIButton *btnAccept;
@property (weak, nonatomic) IBOutlet UIView *vwParent;
@property  Boolean bNew;
@property (weak, nonatomic) IBOutlet UIView *vwBackground;

-(void) setOrderInfo:(OrderModel *) oModel;
-(void) hideView;
@end
