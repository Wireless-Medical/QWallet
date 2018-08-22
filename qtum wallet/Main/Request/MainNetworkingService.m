//
//  MainNetworkingService.m
//  qtum wallet
//
//  Created by HenryFan on 18/8/2018.
//  Copyright © 2018 QTUM. All rights reserved.
//

#import "MainNetworkingService.h"
#import "AFNetworking.h"

@interface MainNetworkingService ()
@property (nonatomic, readwrite, copy) NSString *baseUrl;
@property (nonatomic, readwrite, strong) AFHTTPRequestOperationManager *requestManager;
@end

@implementation MainNetworkingService

@synthesize accessToken;

#pragma mark - Lifecycle

- (instancetype)initWithBaseUrl:(NSString *)baseUrl {
    self = [super init];
    if (self) {
        [self networkMonitoring];
        _baseUrl = baseUrl;
    }
    return self;
}

- (AFHTTPRequestOperationManager *)requestManager {
    if (!_requestManager) {
        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:self.baseUrl]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        if (accessToken) {
            [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", accessToken] forHTTPHeaderField:@"Authorization"];
        }
        
        [manager.requestSerializer setTimeoutInterval:15];
        _requestManager = manager;
    }
    return _requestManager;
}

#pragma mark - Public Methods

- (void)uploadTask:(NSURL *)URL data:(NSData *)data success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:URL];
    AFURLSessionManager *manager = [AFURLSessionManager new];
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request fromData:data progress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            failure(error);
        } else {
            success(responseObject);
        }
    }];
    [uploadTask resume];
}

- (void)requestWithType:(RequestType)type path:(NSString *)path andParams:(NSDictionary *)param withSuccessHandler:(void (^)(id _Nonnull responseObject))success andFailureHandler:(void (^)(NSError *_Nonnull error, NSString *message))failure {
    if (type == POST) {
        [self.requestManager POST:path parameters:param success:^(AFHTTPRequestOperation *_Nonnull operation, id _Nonnull responseObject) {
            success (responseObject);
        } failure:^(AFHTTPRequestOperation *_Nullable operation, NSError *_Nonnull error) {
            if (operation.response.statusCode == 200) {
                success (@"");
            } else {
                [self handingErrorsWithOperation:operation andEror:error withSuccessHandler:success andFailureHandler:failure];
            }
        }];
    } else if (type == GET) {
        [self.requestManager GET:path parameters:param success:^(AFHTTPRequestOperation *_Nonnull operation, id _Nonnull responseObject) {
            success (responseObject);
        } failure:^(AFHTTPRequestOperation *_Nullable operation, NSError *_Nonnull error) {
            [self handingErrorsWithOperation:operation andEror:error withSuccessHandler:success andFailureHandler:failure];
        }];
    } else if (type == DELETE) {
        [self.requestManager DELETE:path parameters:param success:^(AFHTTPRequestOperation *_Nonnull operation, id _Nonnull responseObject) {
            success (responseObject);
        } failure:^(AFHTTPRequestOperation *_Nullable operation, NSError *_Nonnull error) {
            [self handingErrorsWithOperation:operation andEror:error withSuccessHandler:success andFailureHandler:failure];
        }];
    } else if (type == PUT) {
        [self.requestManager PUT:path parameters:param success:^(AFHTTPRequestOperation *_Nonnull operation, id _Nonnull responseObject) {
            success (responseObject);
        } failure:^(AFHTTPRequestOperation *_Nullable operation, NSError *_Nonnull error) {
            [self handingErrorsWithOperation:operation andEror:error withSuccessHandler:success andFailureHandler:failure];
        }];
    }
}

#pragma mark - Private Methods

- (void)networkMonitoring {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusReachableViaWiFi || status == AFNetworkReachabilityStatusReachableViaWWAN) {
        }
    }];
    [manager startMonitoring];
}

- (void)handingErrorsWithOperation:(AFHTTPRequestOperation *_Nullable)operation andEror:(NSError *_Nonnull)error withSuccessHandler:(void (^)(id _Nonnull responseObject))success andFailureHandler:(void (^)(NSError *_Nonnull error, NSString *message))failure {
    NSString *message = ([operation.responseObject isKindOfClass:[NSDictionary class]]) ? operation.responseObject[@"message"] : operation.responseObject[0][@"message"];
    if (message) {
        failure (error, message);
    } else if (!operation.response) {
        if (!self.requestManager.reachabilityManager.isReachable) {
            failure (error, NO_INTERNET_CONNECTION_ERROR_KEY);
            [[NSNotificationCenter defaultCenter] postNotificationName:NO_INTERNET_CONNECTION_ERROR_KEY object:nil];
        } else {
            failure (error, @"This action can not be performed");
        }
    } else {
        failure (error, @"This action can not be performed");
    }
}

@end
