
#import "RNIcloudGettoken.h"

@implementation RNIcloudGettoken

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE()

RCT_REMAP_METHOD(getToken,
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject) {
  id token = [[[NSFileManager alloc] init] ubiquityIdentityToken];
  
  if (token == nil) {
    NSString *code;
    NSString *message = @"Could not get token";
    NSError *error;
    reject(code, message, error);
  } else {
    NSString *rawToken = [NSString stringWithFormat:@"%@", token];
    NSCharacterSet *charsToRemove = [NSCharacterSet characterSetWithCharactersInString:@"<>"];
    NSString *tokenStr = [rawToken stringByTrimmingCharactersInSet:charsToRemove];
    NSString *cleanToken = [[tokenStr componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]
                            componentsJoinedByString:@""];
    resolve(cleanToken);
  }
}

@end
  