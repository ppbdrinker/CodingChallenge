//
//  NetworkServices.m
//  CodeChallenge
//
//  Created by MAC_A_120413 on 3/31/18.
//

#import "NetworkService.h"
#import "NSDictionary+Networking.h"

#define BASE_URL @"https://api.github.com"

@interface NetworkService ()

@property (nonatomic, weak) NSURLSession *session;

@end

@implementation NetworkService

- (instancetype)init{
    self = [super init];
    
    if (self != nil) {
        self.session = [NSURLSession sharedSession];//sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    return self;
}

- (NSMutableURLRequest *)requestForPath:(NSString *)path{
    NSString *absolute = [NSString stringWithFormat:@"%@/%@", BASE_URL, path];
     return [NSMutableURLRequest requestWithURL:[NSURL URLWithString:absolute]];
}

- (void)loadRequest:(NSURLRequest *)request successBlock:(SuccessBlock)success failureBlock:(FailureBlock)failure{
    __block typeof(success) _success = [success copy];
    __block typeof(failure) _failure = [failure copy];
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error){
            _failure(error);
        }else{
            NSDictionary *json = [NSDictionary dictionaryWithData:data];
            _success(json);
        }
    }];
    [task resume];
}

#pragma mark -

- (void)fetchAvatarForAuthor:(NSString *)author successBlock:(DataSuccessBlock)success failureBlock:(FailureBlock)failure {
    NSMutableURLRequest *request = [self requestForPath:@""];
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
    }];
    [task resume];
}

- (void)fetchCommitsForRepository:(NSString *)repository limit:(NSUInteger)limit successBlock:(SuccessBlock)success failureBlock:(FailureBlock)failure {
    NSMutableURLRequest *request = [self requestForPath:@"repositories"];
    request.HTTPMethod = @"GET";
    [self loadRequest:request successBlock:success failureBlock:failure];
}

- (void)fetchRepositoriesWithOffset:(NSUInteger)offset limit:(NSUInteger)limit successBlock:(SuccessBlock)success failureBlock:(FailureBlock)failure {
    NSString *query = [NSString stringWithFormat:@"search/repositories?q=language:Swift&s=stars&o=desc&page=%lu&per_page=%lu", offset, limit];
    NSMutableURLRequest *request = [self requestForPath:query];
    request.HTTPMethod = @"GET";
    [self loadRequest:request successBlock:success failureBlock:failure];
}

- (void)cancelAllRequests {
    [self.session invalidateAndCancel];
    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
}

@end
