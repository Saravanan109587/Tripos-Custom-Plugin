#import "HWPTripos.h"
#import "VTPSaleRequest.h"
@implementation HWPTripos

- (void)greet:(CDVInvokedUrlCommand*)command
{

    NSString* name = [[command arguments] objectAtIndex:0];
    NSString* msg = [NSString stringWithFormat: @"Hello, %@", name];

    CDVPluginResult* result = [CDVPluginResult
                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

 
 

-(void)callProcessSales:(CDVInvokedUrlCommand*)command
{
    NSArray* returnResult = [[NSArray alloc] init];
     
    saleRequest = [self makeSaleReqeust];
    if (self->sharedVtp.isInitialized)
    {
        [sharedVtp processSaleRequest:saleRequest
            completionHandler:^(VTPSaleResponse* response)
            {
               returnResult = [self saleRequestComplete:response];
                 pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"SDk Called Suucess fully"];

              
            }
            errorHandler:^(NSError* error)
            {
              returnResult =  [self handleError:error];
               pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"SDk not Called Suucess fully"];
            }];
            
    }
    else
    {
           pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"SDk Not initialized"];
    }

             [self.commandDelegate sendPluginResult:pluginResult
                                callbackId:command.callbackId];
 
}
- (VTPSaleRequest*)makeSaleReqeust
{
    VTPSaleRequest* request = [[VTPSaleRequest alloc] init];
    
    request.cardholderPresentCode = VTPCardHolderPresentCodePresent;
    request.clerkNumber = @"123";
    request.convenienceFeeAmount = nil;
    request.laneNumber = @"1";
    request.referenceNumber = @"12345678";
    request.salesTaxAmount = nil;
    request.shiftID = @"2";
    request.ticketNumber = @"1234";
    request.tipAmount = nil;
    
    NSString *transactionAmount = [sharedTriPOSConfig.transactionAmount stringByTrimmingCharactersInSet:[NSCharacterSet symbolCharacterSet]];
    request.transactionAmount = [NSDecimalNumber decimalNumberWithString:transactionAmount];

    return request;
}

- (NSArray*)saleRequestComplete:(VTPSaleResponse*)response
{
   
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString* dateString = [dateFormatter stringFromDate:response.transactionDateTime];

    NSString *transactionStatus = [EnumToStringConverter getTransactionStatusName:response.transactionStatus];
    NSString *transactionId = response.host.transactionID;
    
    NSArray* responseArray = @[
        @[ @"transactionStatus", transactionStatus ],
        @[ @"transactionId", transactionId ? transactionId : @"<nil>" ],
        @[ @"wasProcessedOnline", response.wasProcessedOnline ? @"YES" : @"NO" ],
        @[ @"referenceNumber", response.referenceNumber ],
        @[ @"transactionDateTime", dateString ? dateString : @"<nil>" ],
        @[ @"approvedAmount", [NSString stringWithFormat:@"%@", response.approvedAmount] ],
        @[ @"cashbackAmount", response.cashbackAmount ? [NSString stringWithFormat:@"%@", response.cashbackAmount] : @"<nil>" ],
        @[ @"tipAmount", response.tipAmount ? [NSString stringWithFormat:@"%@", response.tipAmount] : @"<nil>" ],
        @[ @"balanceAmount", response.balanceAmount ? [NSString stringWithFormat:@"%@", response.balanceAmount] : @"<nil>" ]
    ];
    
   return responseArray;
  
}

-(NSArray*)handleError:(NSError*)error
{
    NSArray* responseArray = @[
        @[ @"Error Code", [NSString stringWithFormat:@"%ld", (long)error.code] ],
        @[ @"Error Domain", [NSString stringWithFormat:@"%@", error.domain] ],
        @[ @"Error Localized Description", error.localizedDescription ]
    ];

     return responseArray;  
}
 
@end
