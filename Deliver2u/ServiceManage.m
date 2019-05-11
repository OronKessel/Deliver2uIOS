	//
//  ServiceManage.m
//  xiaokeyou
//
//  Created by BoHuang on 3/10/17.
//  Copyright © 2017 Songu. All rights reserved.
//

#import "ServiceManage.h"
#import "Config.h"
#import "AFNetworking.h"
#import "Utils.h"
#import "Globals.h"
#import "OrderModel.h"

@implementation ServiceManage

+(void) serviceRegister:(UserModel*) model:(id<ServiceResultDelegate>) caller
{
    
    NSString *serverurl = [c_baseUrl stringByAppendingString:c_registerUrl];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary * params = @{@"user":model.mName,@"email":model.mEmail,@"pw":model.mPassword};    
    [manager POST:serverurl parameters:params success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSDictionary *userObject = responseObject;
        NSString *response = [userObject objectForKey:@"result"];
        if ([response longLongValue] == 200)
        {
            NSDictionary *userData = [userObject objectForKey:@"user"];
            UserModel *uModel = [[UserModel alloc] init];
            
            uModel.mNo = [userData objectForKey:@"user_id"];
            uModel.mName = [userData objectForKey:@"username"];
            uModel.mPassword = model.mPassword;
            uModel.mPhoto = [userData objectForKey:@"image_url"];
            uModel.mEmail = [userData objectForKey:@"email"];
            mAccount = uModel;
            
            [caller result:0];
        }
        else{
            [caller result:1];
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [caller result:1];
    }];
}
+(void) serviceLogin:(UserModel*) model:(id<ServiceResultDelegate>) caller
{
    NSString *serverurl = [c_baseUrl stringByAppendingString:c_loginUrl];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary * params = @{@"user":model.mEmail,@"pw":model.mPassword};
    
    [manager POST:serverurl parameters:params success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSDictionary *userObject = responseObject;
        NSString *response = [userObject objectForKey:@"result"];
        if ([response longLongValue] == 200)
        {
            NSDictionary *userData = [userObject objectForKey:@"user"];
            UserModel *uModel = [[UserModel alloc] init];
            
            uModel.mNo = [userData objectForKey:@"user_id"];
            uModel.mName = [userData objectForKey:@"username"];
            uModel.mPassword = model.mPassword;
            uModel.mPhoto = [userData objectForKey:@"image_url"];
            uModel.mEmail = [userData objectForKey:@"email"];
            mAccount = uModel;
            
            [caller result:0];
        }
        else{
            [caller result:1];
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [caller result:1];
    }];
}
+(void) serviceLoadOrders:(id<ServiceResultDelegate>) caller
{
    NSString *serverurl = [c_baseUrl stringByAppendingString:c_loadAllPostUrl];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:serverurl parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSDictionary *userObject = responseObject;
        NSString *response = [userObject objectForKey:@"result"];
        if ([response longLongValue] == 200)
        {
            NSArray *orders = [userObject objectForKey:@"orders"];
            for (int i = 0;i < orders.count;i++)
            {
                NSDictionary *orderInfo = [orders objectAtIndex:i];
                OrderModel *oModel = [[OrderModel alloc] init];
                oModel.mNo = [orderInfo objectForKey:@"order_id"];
                oModel.mName = [orderInfo objectForKey:@"order_name"];
                oModel.mContact = [orderInfo objectForKey:@"contact"];
                oModel.mPickupAddress1 = [orderInfo objectForKey:@"pickup_address_1"];
                oModel.mPickupAddress2 = [orderInfo objectForKey:@"pickup_address_2"];
                oModel.mPickupCity = [orderInfo objectForKey:@"pickup_city"];
                oModel.mPickupState = [orderInfo objectForKey:@"pickup_state"];
                oModel.mPickupZip = [orderInfo objectForKey:@"pickup_zip"];
                oModel.mPickupDate = [orderInfo objectForKey:@"pickup_date"];
                oModel.mPickupTime = [orderInfo objectForKey:@"pickup_time"];
                oModel.mDropAddress1 = [orderInfo objectForKey:@"dropoff_address_line1"];
                oModel.mDropAddress2 = [orderInfo objectForKey:@"dropoff_address_line2"];
                oModel.mDropCity = [orderInfo objectForKey:@"dropoff_city"];
                oModel.mDropState = [orderInfo objectForKey:@"dropoff_state"];
                oModel.mDropZip = [orderInfo objectForKey:@"dropoff_zip"];
                oModel.mDropDate = [orderInfo objectForKey:@"dropoff_date"];
                oModel.mDropTime = [orderInfo objectForKey:@"dropoff_time"];
                oModel.mDetail = [orderInfo objectForKey:@"detail"];
                oModel.mInstruction = [orderInfo objectForKey:@"instruction"];
                oModel.mDistance = [orderInfo objectForKey:@"distance"];
                oModel.mAmount = [orderInfo objectForKey:@"amount"];
                oModel.mCustomerName = [orderInfo objectForKey:@"customer_name"];
                oModel.mCustomerContact = [orderInfo objectForKey:@"customer_contact"];
                oModel.mGroupStatus = [orderInfo objectForKey:@"group_status"];
                oModel.mVendorName = [orderInfo objectForKey:@"vendor"];
                
                
                [g_lstOrders addObject:oModel];
            }
            [caller result:0];
        }
        else{
            [caller result:1];
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [caller result:1];
    }];
}
//+(void) serviceForget:(NSString*) email:(id<ServiceResultDelegate>) caller
//{
//    NSString *serverurl = [c_baseUrl stringByAppendingString:c_forgetUrl];
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    NSDictionary * params = @{@"email":email};
//    
//    [manager POST:serverurl parameters:params success:^(NSURLSessionTask *task, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
//        NSDictionary *userObject = responseObject;
//        NSString *response = [userObject objectForKey:@"result"];
//        if ([response isEqualToString:@"ok"])
//        {
//            UserModel *uModel = [[UserModel alloc] init];
//            NSDictionary *dataObject = [userObject objectForKey:@"data"];
//            
//            uModel.mNo = [dataObject objectForKey:@"user_id"];
//            uModel.mFirstName = [dataObject objectForKey:@"first_name"];
//            uModel.mLastName = [dataObject objectForKey:@"last_name"];
//            uModel.mPhoto = [dataObject objectForKey:@"image_url"];
//            uModel.mPop = [dataObject objectForKey:@"referral_pops"];
//            
//            mAccount = uModel;
//            [caller result:0];
//        }
//        else{
//            [caller result:1];
//        }
//    } failure:^(NSURLSessionTask *operation, NSError *error) {
//        [caller result:1];
//    }];
//}

@end
