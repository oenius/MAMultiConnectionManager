//
//  MAMultiConnectionManager.h
//  Bonjour
//
//  Created by YURI_JOU on 15/12/30.
//  Copyright © 2015年 oenius. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MAMultiConnectionManager : NSObject

@property (nonatomic, copy) void(^didRecivedMessage)(NSString *msg);

- (instancetype)initWithIdentifier:(NSString *)identifier;
- (void)start;
- (void)stop;

- (void)sendMessage:(NSString *)text completion:(void(^)(bool))completion;
- (void)sendImage:(UIImage *)image completion:(void(^)(CGFloat))completion;

@end
