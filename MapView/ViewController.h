//
//  ViewController.h
//  MapView
//
//  Created by Camilo Jimenez Ibañez on 2/04/14.
//  Copyright (c) 2014 Camilo Jimenez Ibañez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController <MKMapViewDelegate, UISearchBarDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end
