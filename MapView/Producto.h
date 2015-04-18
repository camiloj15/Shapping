//
//  Producto.h
//  MapView
//
//  Created by Camilo Jimenez Ibañez on 18/04/15.
//  Copyright (c) 2015 Camilo Jimenez Ibañez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Producto : NSObject

@property (strong, nonatomic) NSString *nombre;
@property (strong, nonatomic) NSString *establecimiento;
@property (strong, nonatomic) NSNumber *lat;
@property (strong, nonatomic) NSNumber *lng;

@end
