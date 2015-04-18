//
//  ViewController.m
//  MapView
//
//  Created by Camilo Jimenez Ibañez on 18/04/15.
//  Copyright (c) 2015 Camilo Jimenez Ibañez. All rights reserved.
//

//
//  ViewController.m
//  MapView
//
//  Created by Camilo Jimenez Ibañez on 2/04/14.
//  Copyright (c) 2014 Camilo Jimenez Ibañez. All rights reserved.
//

#import "ViewController.h"
#import "Producto.m"

@interface ViewController (){
    NSArray *array;
    NSArray *filterArray;
}

@end

@implementation ViewController
Producto *p;
NSMutableArray *lista;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    p = [[Producto alloc]init];
    
    // Do any additional setup after loading the view, typically from a nib.
    self.searchBar.delegate = self;
    self.mapView.delegate = self;
    NSURL *url = [NSURL URLWithString:@"http://198.61.223.60/api/consult/s2"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (connectionError != nil) {
             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                                 message:[connectionError localizedDescription]
                                                                delegate:nil
                                                       cancelButtonTitle:@"Ok"
                                                       otherButtonTitles:nil];
             [alertView show];
         }
         if (data.length > 0) {
             NSArray *array = [NSJSONSerialization JSONObjectWithData:data
                                                              options:0
                                                                error:NULL];
             
             CLLocationCoordinate2D location;                         // coordinates of the annotation
             NSMutableArray *newAnnotations = [NSMutableArray array]; // an array in which we'll save our annotations temporarily
             MKPointAnnotation *newAnnotation;                        // the pointer to the annotation we're adding
             
             // iterate through the array, adding an annotation to our our array of new annotations
             
             for (NSDictionary *dictionary in array)
             {
                 // retrieve latitude and longitude from the dictionary entry
                 NSNumber *lat = [NSNumber numberWithDouble:[dictionary[@"lat"] doubleValue]];
                 NSNumber *lngg = [NSNumber numberWithDouble:[dictionary[@"lng"] doubleValue]];
                 location.latitude = [lngg doubleValue];
                 location.longitude = [lat doubleValue];
                 
                 // create the annotation
                 
                 newAnnotation = [[MKPointAnnotation alloc] init];
                 newAnnotation.title = dictionary[@"name"];
                 newAnnotation.coordinate = location;
                 
                 // add it to our array
                 //
                 // incidentally, generally I just add it to the mapview directly, but
                 // given that you have a didAddAnnotationViews, we'll just build up
                 // an array and add them all to the map view in one step after we're
                 // done iterating through the JSON results
                 
                 [newAnnotations addObject:newAnnotation];
                 
                 // clean up
                 
             }
             MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location, 7000100, 7000100);
             [self.mapView setRegion:region];
             [self.mapView addAnnotations:newAnnotations];
             
         }
     }];
    
    lista = [[NSMutableArray alloc]init];
    
    // when done, add the annotations
    [self llenarLista];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"%@",searchBar.text);
    [self.searchBar resignFirstResponder];
    for (int i = 0; i < [lista count]; i++){
        Producto *producto = [lista objectAtIndex:i];
        if([producto.nombre isEqualToString:searchBar.text]){
            CLLocationCoordinate2D location;                         // coordinates of the annotation
            NSMutableArray *newAnnotations = [NSMutableArray array]; // an array in which we'll save our annotations temporarily
            MKPointAnnotation *newAnnotation;                        // the pointer to the annotation we're adding
            
            location.latitude = [producto.lat doubleValue];
            location.longitude = [producto.lng doubleValue];
            
            // create the annotation
            newAnnotation = [[MKPointAnnotation alloc] init];
            newAnnotation.title = producto.nombre;
            newAnnotation.coordinate = location;
            
            MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location, 7000100, 7000100);
            [self.mapView setRegion:region];
            [self.mapView addAnnotations:newAnnotations];
        }
    }
    //next you've to setup logic to pass search text to your mapview
}

- (void)llenarLista{
    p.nombre = @"Moto";
    p.establecimiento = @"Akt";
    p.lat = [NSNumber numberWithDouble:[@10.925491 doubleValue]];
    p.lng = [NSNumber numberWithDouble:[@-74.79475 doubleValue]];
    [lista addObject:p];
    p.nombre = @"Moto";
    p.establecimiento = @"Jana`s Moto";
    p.lat = [NSNumber numberWithDouble:[@10.925491 doubleValue]];
    p.lng = [NSNumber numberWithDouble:[@-74.79475 doubleValue]];
    [lista addObject:p];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
