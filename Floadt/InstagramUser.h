//
//  InstagramUser.h
//  Floadt
//
//  Created by Pradyumn Nukala on 7/20/15.
//  Copyright (c) 2015 Floadt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InstagramUser : NSObject {
    NSString *bio;
    id followed_by;
    id follows;
    id media;
    NSString *full_name;
    NSString *idvalue;
    NSString *profile_picture;
    NSString *username;
    NSString *website;
    NSString *incoming_status;
    NSString *outgoing_status;
    id target_user_is_private;
}

@property (nonatomic, strong) NSString *bio;
@property (nonatomic, strong) id followed_by;
@property (nonatomic, strong) id follows;
@property (nonatomic, strong) id media;
@property (nonatomic, strong) NSString *full_name;
@property (nonatomic, strong) NSString *idvalue;
@property (nonatomic, strong) NSString *profile_picture;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *website;
@property (nonatomic, strong) NSString *incoming_status;
@property (nonatomic, strong) NSString *outgoing_status;
@property id target_user_is_private;

@end
