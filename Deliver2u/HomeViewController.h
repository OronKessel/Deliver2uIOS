//
//  HomeViewController.h
//  Deliver2u
//
//  Created by BoHuang on 11/3/17.
//  Copyright © 2017 Songu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <ECDrawerLayout/ECDrawerLayout.h>
#import "OrderDetailView.h"
#import "OrderModel.h"
#import "ConfirmView.h"

@class ConfirmView;
@interface HomeViewController : UIViewController<MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mapHome;
@property (weak, nonatomic) IBOutlet UILabel *lblPosition;

@property (weak, nonatomic) IBOutlet UIButton *btnMenu;
@property (weak, nonatomic) IBOutlet UIButton *btnProfile;
@property (weak, nonatomic) IBOutlet UIView *vwLocation;

@property (strong, nonatomic) ECDrawerLayout* drawerLayout;
@property (strong, nonatomic) CLLocationManager* locationManager;
@property (strong, nonatomic) CLGeocoder *ceo;
@property (strong, nonatomic) OrderDetailView *orderView;
@property (strong, nonatomic) OrderModel *mCurrentOrder;
@property (strong, nonatomic) ConfirmView *popConfirm;

-(void) clearPathMap;
@end
