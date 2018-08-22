//
//  MainRequestable.h
//  qtum wallet
//
//  Created by HenryFan on 23/8/2018.
//  Copyright © 2018 QTUM. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MainRequestable <NSObject>

- (void)uploadFile:(NSData *)data success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
