//
//  UserModel.h
//  Deliver2u
//
//  Created by BoHuang on 11/3/17.
//  Copyright © 2017 Songu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UserModel : NSObject


@property (strong, nonatomic) IBOutlet NSString *mNo;
@property (strong, nonatomic) IBOutlet NSString *mName;
@property (strong, nonatomic) IBOutlet NSString *mEmail;
@property (strong, nonatomic) IBOutlet NSString *mPassword;
@property (strong, nonatomic) IBOutlet NSString *mPhoto;
@property (strong, nonatomic) IBOutlet UIImage *mImage;


@end
