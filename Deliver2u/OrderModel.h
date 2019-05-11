//
//  OrderModel.h
//  Deliver2u
//
//  Created by q on 11/15/17.
//  Copyright © 2017 Songu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface OrderModel : NSObject

@property (strong, nonatomic) IBOutlet NSString *mNo;
@property (strong, nonatomic) IBOutlet NSString *mName;
@property (strong, nonatomic) IBOutlet NSString *mContact;
@property (strong, nonatomic) IBOutlet NSString *mPickupAddress1;
@property (strong, nonatomic) IBOutlet NSString *mPickupAddress2;
@property (strong, nonatomic) IBOutlet NSString *mPickupCity;
@property (strong, nonatomic) IBOutlet NSString *mPickupState;
@property (strong, nonatomic) IBOutlet NSString *mPickupZip;
@property (strong, nonatomic) IBOutlet NSString *mPickupDate;
@property (strong, nonatomic) IBOutlet NSString *mPickupTime;
@property (strong, nonatomic) IBOutlet NSString *mDropAddress1;
@property (strong, nonatomic) IBOutlet NSString *mDropAddress2;
@property (strong, nonatomic) IBOutlet NSString *mDropCity;
@property (strong, nonatomic) IBOutlet NSString *mDropState;
@property (strong, nonatomic) IBOutlet NSString *mDropZip;
@property (strong, nonatomic) IBOutlet NSString *mDropDate;
@property (strong, nonatomic) IBOutlet NSString *mDropTime;
@property (strong, nonatomic) IBOutlet NSString *mDetail;
@property (strong, nonatomic) IBOutlet NSString *mInstruction;
@property (strong, nonatomic) IBOutlet NSString *mDistance;
@property (strong, nonatomic) IBOutlet NSString *mAmount;
@property (strong, nonatomic) IBOutlet NSString *mCustomerName;
@property (strong, nonatomic) IBOutlet NSString *mCustomerContact;
@property (strong, nonatomic) IBOutlet NSString *mGroupStatus;
@property CLLocationCoordinate2D mPickupCoor;
@property CLLocationCoordinate2D mDropCoor;


@property (strong, nonatomic) IBOutlet NSString *mVendorName;

@end
