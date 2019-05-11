//
//  Globals.h
//  xiaokeyou
//
//  Created by BoHuang on 3/3/17.
//  Copyright © 2017 Songu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WNAActivityIndicator.h"
#import "UserModel.h"
#import <MapKit/MapKit.h>



extern NSMutableArray *g_lstOrders;

extern WNAActivityIndicator *activityIndicator;
extern CLLocationCoordinate2D g_currentLocation;
extern UserModel *mAccount;

@interface Globals : NSObject


+(void) saveUserInfo;
+(void) loadUserInfo;


@end
