//
//  LZLocationCoordinate.m
//  LazyWeekend
//
//  Created by lunarboat on 15/11/12.
//  Copyright © 2015年 lunarboat. All rights reserved.
//

#import "LZLocationCoordinate.h"
#import <CoreLocation/CoreLocation.h>

@interface LZLocationCoordinate ()<CLLocationManagerDelegate>{
    CLLocationManager *_manager;
}

@end

@implementation LZLocationCoordinate

- (instancetype)init
{
    self = [super init];
    if (self) {
        if ([CLLocationManager locationServicesEnabled]) {
            _manager = [[CLLocationManager alloc]init];
            _manager.delegate = self;
            _manager.desiredAccuracy = kCLLocationAccuracyBest;
            _manager.distanceFilter = 10;
            _manager.allowsBackgroundLocationUpdates = YES;
            [_manager requestAlwaysAuthorization];
            [_manager startUpdatingLocation];
        }else{
            //提示定位失败;
            NSLog(@"定位失败");
            return nil;
        }
        
    }
    return self;
}

//- (void)startLocation{
//    [_manager startUpdatingLocation];
//}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    //最后一个是最新的
    CLLocation *currentLocation = [locations lastObject];
    CLLocationCoordinate2D coor = currentLocation.coordinate;
    self.lat = coor.latitude;
    self.lon = coor.longitude;
    
    NSLog(@"lat:%f",coor.latitude);
    NSLog(@"lon:%f",coor.longitude);
//    [_manager stopUpdatingLocation];
}
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {

}

@end
