//
//  HomeViewController.m
//  Deliver2u
//
//  Created by BoHuang on 11/3/17.
//  Copyright © 2017 Songu. All rights reserved.
//

#import "HomeViewController.h"
#import "MenuView.h"
#import "ServiceManage.h"
#import "Globals.h"
#import "Utils.h"
#import "OrderModel.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    g_lstOrders = [[NSMutableArray alloc] init];
    [self.btnMenu addTarget:self action:@selector(clickMenu) forControlEvents:UIControlEventTouchUpInside];
    [Utils addActivityIndicator:self.view];
    self.mapHome.delegate = self;
    self.orderView = [[[NSBundle mainBundle] loadNibNamed:@"OrderDetailView" owner:self options:nil] firstObject];
    [self.orderView.btnAccept addTarget:self action:@selector(clickAccept) forControlEvents:UIControlEventTouchUpInside];
    [self initMap];
    [self initUserLocation];
    [self initConfirmDialog];
    [ServiceManage serviceLoadOrders: self];
}
-(void) initConfirmDialog
{
    self.popConfirm = [[[NSBundle mainBundle] loadNibNamed:@"ConfirmView" owner:self options:nil] firstObject];
    [self.popConfirm setParent:self];
    [self.popConfirm.btnConfirm addTarget:self action:@selector(clickConfirm) forControlEvents:UIControlEventTouchUpInside];
}
-(void) clickConfirm
{
    
}
-(void) initUserLocation
{
    
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
}
- (void)mapView:(MKMapView *)aMapView didUpdateUserLocation:(MKUserLocation *)aUserLocation {
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.005;
    span.longitudeDelta = 0.005;
    CLLocationCoordinate2D location;
    location.latitude = aUserLocation.coordinate.latitude;
    location.longitude = aUserLocation.coordinate.longitude;
    region.span = span;
    region.center = location;
    [aMapView setRegion:region animated:YES];
    
    MKPointAnnotation *mark = [[MKPointAnnotation alloc] init];
    mark.title = @"Your position";
    mark.coordinate = location;
    //mark.coordinate = [self getLocationFromAddressString:constant];;
    [self.mapHome addAnnotation:mark];
    
    
}
-(void) clickAccept
{
    [self.orderView hideView];
    [self drawPathOnMap];
    [self.popConfirm setOrderInfo:self.mCurrentOrder];
    [self.view addSubview:self.popConfirm];
}
-(void) initMap
{
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    region.center = self.mapHome.region.center;
    span.latitudeDelta = self.mapHome.region.span.latitudeDelta / 2.0002;
    span.longitudeDelta = self.mapHome.region.span.longitudeDelta / 2.0002;
    region.span = span;
    [self.mapHome setRegion:region animated:TRUE];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) clickMenu
{
    if (self.drawerLayout.opened)
        [self.drawerLayout closeDrawer];
    else [self.drawerLayout openDrawer];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.drawerLayout = [[ECDrawerLayout alloc] initWithParentView:self.view];
    
    MenuView *menuView =   [[[NSBundle mainBundle] loadNibNamed:@"MenuView" owner:self options:nil] firstObject];
    self.drawerLayout.delegate = self;
    self.drawerLayout.width = 250;
    self.drawerLayout.contentView = menuView;
    
    [self.view addSubview:self.drawerLayout];
    
    self.drawerLayout.openFromRight = NO;
    
    
    //Update User location
    self.ceo= [[CLGeocoder alloc]init];
    [self.locationManager requestWhenInUseAuthorization];
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    g_currentLocation.latitude=self.locationManager.location.coordinate.latitude;
    g_currentLocation.longitude=self.locationManager.location.coordinate.longitude;
    //CLLocationCoordinate2D  ctrpoint;
    //  ctrpoint.latitude = ;
    //ctrpoint.longitude =f1;
    g_currentLocation.latitude=22.372352;
    g_currentLocation.longitude=114.114268;
    MKPointAnnotation *marker = [MKPointAnnotation new];
    marker.coordinate = g_currentLocation;
    marker.title = @"Your position";
    //NSLog(@"%f",coordinate.latitude);
    [self.mapHome addAnnotation:marker];
    
    
    CLLocation *loc = [[CLLocation alloc]initWithLatitude:g_currentLocation.latitude longitude:g_currentLocation.longitude
                       ];
    [self.ceo reverseGeocodeLocation:loc
              completionHandler:^(NSArray *placemarks, NSError *error) {
                  CLPlacemark *placemark = [placemarks objectAtIndex:0];
                  NSLog(@"placemark %@",placemark);
                  //String to hold address
                  NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
                  NSLog(@"addressDictionary %@", placemark.addressDictionary);
                  
                  NSLog(@"placemark %@",placemark.region);
                  NSLog(@"placemark %@",placemark.country);  // Give Country Name
                  NSLog(@"placemark %@",placemark.locality); // Extract the city name
                  NSLog(@"location %@",placemark.name);
                  NSLog(@"location %@",placemark.ocean);
                  NSLog(@"location %@",placemark.postalCode);
                  NSLog(@"location %@",placemark.subLocality);
                  
                  NSLog(@"location %@",placemark.location);
                  //Print the location to console
                  NSLog(@"I am currently at %@",locatedAt);
                  
                  self.lblPosition.text = locatedAt;
                  [self.locationManager stopUpdatingLocation];
              }
     
     ];

    
}
-(void) clearPathMap
{
    NSArray *arrayOverlay = [self.mapHome overlays];
    for (int i = 0;i < arrayOverlay.count;i++)
         [self.mapHome removeOverlay:[arrayOverlay objectAtIndex :i]] ;
}
-(void) drawPathOnMap
{
    MKPlacemark *source = [[MKPlacemark alloc]initWithCoordinate:g_currentLocation addressDictionary:[NSDictionary dictionaryWithObjectsAndKeys:@"",@"", nil] ];
    MKMapItem *sourceMapItem = [[MKMapItem alloc]initWithPlacemark:source];
    MKPlacemark *destination = [[MKPlacemark alloc]initWithCoordinate:self.mCurrentOrder.mPickupCoor addressDictionary:[NSDictionary dictionaryWithObjectsAndKeys:@"",@"", nil] ];
    MKMapItem *distMapItem = [[MKMapItem alloc]initWithPlacemark:destination];
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc]init];
    [request setSource:sourceMapItem];
    [request setDestination:distMapItem];
    [request setTransportType:MKDirectionsTransportTypeAutomobile];
    MKDirections *direction = [[MKDirections alloc]initWithRequest:request];
    [direction calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        if (!error) {
            for (MKRoute *route in [response routes]) {
                [self.mapHome addOverlay:[route polyline] level:MKOverlayLevelAboveRoads];
            }
        }
    }];
}
- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation
{
    MKAnnotationView *pinView = nil;
    if(annotation != mapView.userLocation)
    {
        static NSString *defaultPinID = @"com.invasivecode.pin";
        pinView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
        if ( pinView == nil )
            pinView = [[MKAnnotationView alloc]
                       initWithAnnotation:annotation reuseIdentifier:defaultPinID];
        
        if ([annotation.title isEqualToString: @"Your position"])
        {
            pinView.canShowCallout = YES;
            pinView.image = [UIImage imageNamed:@"ic_marker_map_red.png"];    //as suggested by Squatch
        }
        else
        {
            pinView.canShowCallout = YES;
            pinView.image = [UIImage imageNamed:@"ic_marker_map.png"];    //as suggested by Squatch
            UIButton *detailButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            pinView.rightCalloutAccessoryView=detailButton;
        }
        
    }
    else {
        [mapView.userLocation setTitle:@"I am here"];
        //[mapView showsUserLocation];
    }
    return pinView;
}
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    //[self performSegueWithIdentifier:@"DetailsIphone" sender:view];
    //[Globals showErrorDialog:@"aaa"];
    MKAnnotationView *annotation = [view annotation];
    if ([annotation isKindOfClass:[MKPointAnnotation class]])
    {
        MKPointAnnotation *mark = annotation;
        for (int i = 0;i < g_lstOrders.count;i++)
        {
            OrderModel *oModel = [g_lstOrders objectAtIndex:i];
            if ([mark.title isEqualToString:oModel.mName])
            {
                self.mCurrentOrder = oModel;
                [self.orderView setOrderInfo:self.mCurrentOrder];
                [self.view addSubview:self.orderView];
                return;
            }
        }
    }
}
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id)overlay
{
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
        [renderer setStrokeColor:[UIColor redColor]];
        [renderer setLineWidth:3.0];
        return renderer;
    }
    return nil;
}
-(void) showOrdersOnMap
{
    for(int i = 0; i < g_lstOrders.count; i++)
    {
        OrderModel* gModel = [g_lstOrders objectAtIndex:i];
        MKPointAnnotation *mark = [[MKPointAnnotation alloc] init];
        mark.title = gModel.mName;
        NSString *addr = gModel.mPickupAddress1;
        if (addr == nil || [addr isEqualToString:@""])
        {
            addr = gModel.mPickupAddress2;
        }
        if (gModel.mPickupState == nil || gModel.mPickupCity == nil || addr == nil)
            continue;
        //NSString *constant = @"Liaoning Shenyang Heping";
        NSString *strAddress = [NSString stringWithFormat:@"%@ %@ %@",gModel.mPickupState, gModel.mPickupCity, addr];
        ((OrderModel*)[g_lstOrders objectAtIndex:i]).mPickupCoor = [self getLocationFromAddressString:strAddress];
        
        mark.coordinate =  ((OrderModel*)[g_lstOrders objectAtIndex:i]).mPickupCoor;
        //mark.coordinate = [self getLocationFromAddressString:constant];;
        [self.mapHome addAnnotation:mark];
        
        
    }
}

-(CLLocationCoordinate2D) getLocationFromAddressString: (NSString*) addressStr {
    double latitude = 0, longitude = 0;
    NSString *esc_addr =  [addressStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *req = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", esc_addr];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    if (result) {
        NSScanner *scanner = [NSScanner scannerWithString:result];
        if ([scanner scanUpToString:@"\"lat\" :" intoString:nil] && [scanner scanString:@"\"lat\" :" intoString:nil]) {
            [scanner scanDouble:&latitude];
            if ([scanner scanUpToString:@"\"lng\" :" intoString:nil] && [scanner scanString:@"\"lng\" :" intoString:nil]) {
                [scanner scanDouble:&longitude];
            }
        }
    }
    CLLocationCoordinate2D center;
    center.latitude=latitude;
    center.longitude = longitude;
    NSLog(@"View Controller get Location Logitute : %f",center.latitude);
    NSLog(@"View Controller get Location Latitute : %f",center.longitude);
    return center;
    
}
- (void)mapViewDidFinishRenderingMap:(MKMapView *)mapView fullyRendered:(BOOL)fullyRendered
{
   
}
-(void) result:(int) code
{
    [Utils removeActivityIndicator:self.view];
    switch (code) {
        case 0://Success
            [self showOrdersOnMap];
            break;
        case 1://Fail
            [Utils showErrorDialog:@"Internet Problem."];
            break;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
