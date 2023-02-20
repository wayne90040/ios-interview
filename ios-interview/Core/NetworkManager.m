//
//  NetworkManager.m
//  ios-interview
//
//  Created by Wei Lun Hsu on 2023/2/16.
//

#import "NetworkManager.h"

@interface NetworkManager ()

@end

@implementation NetworkManager

+ (NetworkManager *)sharedInstance {
    static NetworkManager *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[NetworkManager alloc] init];
    });
    return instance;
}

- (void) fetchManWithCompletion:(NSDictionaryNSErrorBlock)completionHandler {
    [self performRequestWithURLString:@"https://dimanyen.github.io/man.json" completionHandler:completionHandler];
}

- (void) fetchFriends1WithCompletion:(NSDictionaryNSErrorBlock)completionHandler {
    [self performRequestWithURLString:@"https://dimanyen.github.io/friend1.json" completionHandler:completionHandler];
}

- (void) fetchFriends2WithCompletion:(NSDictionaryNSErrorBlock)completionHandler {
    [self performRequestWithURLString:@"https://dimanyen.github.io/friend2.json" completionHandler:completionHandler];
}

- (void) fetchFriends3WithCompletion:(NSDictionaryNSErrorBlock)completionHandler {
    [self performRequestWithURLString:@"https://dimanyen.github.io/friend3.json" completionHandler:completionHandler];
}

- (void)fetchFriends4WithCompletion:(NSDictionaryNSErrorBlock)completionHandler {
    [self performRequestWithURLString:@"https://dimanyen.github.io/friend4.json" completionHandler:completionHandler];
}

- (void) performRequestWithURLString:(NSString*)urlString completionHandler:(NSDictionaryNSErrorBlock)completionHandler {
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    [urlRequest setHTTPMethod:@"GET"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:urlRequest
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (httpResponse.statusCode == 200) {
            NSError *parseError = nil;
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            completionHandler(result, parseError);
            return;
        }
        completionHandler(nil, error);
    }];
    
    [task resume];
}

@end
