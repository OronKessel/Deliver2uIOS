//
//  ServiceManage.h
//  xiaokeyou
//
//  Created by BoHuang on 3/10/17.
//  Copyright © 2017 Songu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceResultDelegate.h"
#import "UserModel.h"

@interface ServiceManage : NSObject


+(void) serviceRegister:(UserModel*) model:(id<ServiceResultDelegate>) caller;
+(void) serviceLogin:(UserModel*) model:(id<ServiceResultDelegate>) caller;
+(void) serviceLoadOrders:(id<ServiceResultDelegate>) caller;

@end
