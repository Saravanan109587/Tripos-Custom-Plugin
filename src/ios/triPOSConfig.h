//
//  triPOSConfig.h
//  SampleApp
//

#import <Foundation/Foundation.h>

#include <triPOSMobileSDK/triPOSMobileSDK.h>

@interface triPOSConfig : NSObject

+(id)sharedTriPOSConfig;
- (void)setupVtpConfiguration;

@property (retain, nonatomic) VTPConfiguration* vtpConfiguration;
@property (nonatomic) NSString *transactionAmount;
@property (nonatomic) VTPDeviceType deviceType;
@property (nonatomic) NSInteger timeout;
@property (nonatomic) NSString* tcpIpAddress;
@property (nonatomic) VTPApplicationMode environmentType;

@end
