//
//  SSAccelerometerInfo.m
//  SystemServicesDemo
//
//  Created by Shmoopi LLC on 9/20/12.
//  Copyright (c) 2012 Shmoopi LLC. All rights reserved.
//

#import "SSAccelerometerInfo.h"

@implementation SSAccelerometerInfo

// Accelerometer Information

// Device Orientation
+ (UIDeviceOrientation)deviceOrientation {
    // Get the device's current orientation
    @try {
        // Device orientation
        UIDeviceOrientation Orientation = [[UIApplication sharedApplication] statusBarOrientation];
        
        // Successful
        return Orientation;
    }
    @catch (NSException *exception) {
        // Error
        return -1;
    }
}

// Accelerometer X Value
+ (float)accelerometerXValue {
    // Get the accelerometer X value
    @try {
        // Set up the accelerometer
        UIAcceleration *Accelerometer = [UIAcceleration alloc];
        // Get the X value
        float CurrentAccelerationXValue = Accelerometer.x;
        // Successful
        return CurrentAccelerationXValue;
    }
    @catch (NSException *exception) {
        // Error
        return -1;
    }
}

// Accelerometer Y Value
+ (float)accelerometerYValue {
    // Get the accelerometer Y value
    @try {
        // Set up the accelerometer
        UIAcceleration *Accelerometer = [UIAcceleration alloc];
        // Get the Y value
        float CurrentAccelerationYValue = Accelerometer.y;
        // Successful
        return CurrentAccelerationYValue;
    }
    @catch (NSException *exception) {
        // Error
        return -1;
    }
}

// Accelerometer Z Value
+ (float)accelerometerZValue {
    // Get the accelerometer Z value
    @try {
        // Set up the accelerometer
        UIAcceleration *Accelerometer = [UIAcceleration alloc];
        // Get the Z value
        float CurrentAccelerationZValue = Accelerometer.z;
        // Successful
        return CurrentAccelerationZValue;
    }
    @catch (NSException *exception) {
        // Error
        return -1;
    }
}

@end
