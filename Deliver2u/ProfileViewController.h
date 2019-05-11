//
//  ProfileViewController.h
//  Deliver2u
//
//  Created by q on 11/17/17.
//  Copyright © 2017 Songu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIButton *btnSetting;
@property (weak, nonatomic) IBOutlet UIImageView *imgProfile;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UIButton *btnEdit;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;
@property (weak, nonatomic) IBOutlet UIButton *btnPendingTab;
@property (weak, nonatomic) IBOutlet UIButton *btnCompleteTab;
@property (weak, nonatomic) IBOutlet UITableView *tblOrders;

@end
