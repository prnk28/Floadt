//
//  MessageInterceptor.h
//  MasonryViewDemo
//
//  Created by Sarp Erdag on 3/31/12.
//  Copyright (c) 2012 Apperto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageInterceptor : NSObject {
    id __unsafe_unretained receiver;
    id __unsafe_unretained middleMan;
}
@property (nonatomic, unsafe_unretained) id receiver;
@property (nonatomic, unsafe_unretained) id middleMan;
@end
