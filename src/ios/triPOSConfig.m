//
//  triPOSConfig.m
//  SampleApp
//

#import "triPOSConfig.h"
#import "ConfigurationTableViewController.h"

@implementation triPOSConfig

static triPOSConfig *sharedTriPOSConfig;


+(id)sharedTriPOSConfig
{
    if (sharedTriPOSConfig == nil)
    {
        sharedTriPOSConfig = [[triPOSConfig alloc] init];
    }
    return sharedTriPOSConfig;
}

- (id)init {
    self = [super init];

    if (self)
    {
        _vtpConfiguration = [[VTPConfiguration alloc] init];
        
        _transactionAmount = [[NSUserDefaults standardUserDefaults] stringForKey:@"transactionAmountKey"];
        
        if (_transactionAmount == nil)
        {
             _transactionAmount = @"$1.00";
        }

        // Change device type if you want to use a physical device: (VTPDeviceTypeIngenicoRba, VTPDeviceTypeIngenicoRbaTcpIp)
        _deviceType = VTPDeviceTypeNull;
        
        // Set IP address if using a TCP/IP device
        _tcpIpAddress = @"";
        
        // Get the most recently selected environment type from NSUserDefaults
        NSInteger mostRecentlySelectedEnvironmentTypeNum = [[NSUserDefaults standardUserDefaults] integerForKey:@"selectedEnvironmentKey"];
        VTPApplicationMode mostRecentlySelectedEnvironmentType = [ConfigurationTableViewController getEnvironmentTypeForIndex:mostRecentlySelectedEnvironmentTypeNum];
        
        _environmentType = mostRecentlySelectedEnvironmentType ? mostRecentlySelectedEnvironmentType : VTPApplicationModeTestCertification;
        
        _timeout = 10 * 1000;
        
        [self setupVtpConfiguration];
    }
    return self;
}

- (void)setupVtpConfiguration
{
    [self setupApplicationConfiguration:_vtpConfiguration];
    [self setupDeviceConfiguration:_vtpConfiguration];
    [self setupHostConfiguration:_vtpConfiguration];
    [self setupTransactionConfiguration:_vtpConfiguration];
}

- (void)setupApplicationConfiguration:(VTPConfiguration*)configuration
{
    configuration.applicationConfiguration.mode = _environmentType;
    configuration.applicationConfiguration.idlePrompt = @"\ntriPOS Samples";
}

- (void)setupDeviceConfiguration:(VTPConfiguration*)configuration
{
    configuration.deviceConfiguration.deviceType = _deviceType;
    configuration.deviceConfiguration.tcpIpConfiguration = [[VTPDeviceTcpIpConfiguration alloc] init];
    configuration.deviceConfiguration.tcpIpConfiguration.ipAddress = _tcpIpAddress;
    configuration.deviceConfiguration.tcpIpConfiguration.port = 12000;
    configuration.deviceConfiguration.isKeyedEntryAllowed = YES;
    configuration.deviceConfiguration.isContactlessMsdEntryAllowed = YES;
    configuration.deviceConfiguration.terminalId = @"00000000";
}

- (void)setupHostConfiguration:(VTPConfiguration*)configuration
{
    configuration.hostConfiguration.acceptorId = @"3928907";
    configuration.hostConfiguration.accountId = @"1045826";
    configuration.hostConfiguration.accountToken = @"079701FC1CBBEACDC0353ADFD246B965965C19C69BE2BC2B102DBCD524A78301A2AC6D01";
    configuration.hostConfiguration.applicationId = @"1234";
    
    configuration.hostConfiguration.applicationName = @"triPOS Samples";
    configuration.hostConfiguration.applicationVersion = @"0.0.0.0";
    configuration.hostConfiguration.storeCardID = @"631522003";
    configuration.hostConfiguration.storeCardPassword = @"xyz";
}

- (void)setupTransactionConfiguration:(VTPConfiguration*)configuration
{
    configuration.transactionConfiguration.isGiftCardAllowed = YES;
    configuration.transactionConfiguration.currencyCode = VTPCurrencyCodeUsd;
    configuration.transactionConfiguration.marketCode = VTPMarketCodeRetail;
    configuration.transactionConfiguration.arePartialApprovalsAllowed = NO;
    configuration.transactionConfiguration.areDuplicateTransactionsAllowed = NO;
    configuration.transactionConfiguration.isCashbackAllowed = YES;
    configuration.transactionConfiguration.cashbackSelections = @[ [NSDecimalNumber decimalNumberWithString:@"1.00"],
                                                                   [NSDecimalNumber decimalNumberWithString:@"2.00"],
                                                                   [NSDecimalNumber decimalNumberWithString:@"3.00"],
                                                                   [NSDecimalNumber decimalNumberWithString:@"4.00"] ];
    configuration.transactionConfiguration.isDebitAllowed = YES;
    configuration.transactionConfiguration.isEmvAllowed = YES;
}

@end
