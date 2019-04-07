///
/// \file VTPDelegate.h
///

#ifndef VTPDelegate_h
#define VTPDelegate_h

#import "VTPStatus.h"

///
/// \protocol VTPDelegate
///
/// \brief Protocol for the device notifications
///
/// The VTPDelegate protocol defines the methods a receiver may implement for device notifications.
///
@protocol VTPDelegate

@optional

///
/// \brief Device connected callback
///
/// This protocol method is called to inform the delegate a recognized device has been connected.
///
/// \param description The description of the connected device.
///
/// \param model The model of the connected device.
///
/// \param serialNumber The serial number of the connected device. This value may be nil if the connected device does not supply this value. In some cases, this value may not be available immediately upon connection.
///
-(void)deviceDidConnect:(NSString *)description model:(NSString *)model serialNumber:(NSString *)serialNumber;

///
/// \brief Device disconnected callback
///
/// This protocol method is called to inform the delegate the device has been disconnected.
///
-(void)deviceDidDisconnect;

///
/// \brief Device error callback
///
/// This protocol method is called to inform the delegate the device generated an error. This notification is only generated for errors occuring outside functionality explicitly invoked by the integrator. For example, if the device connects, but an error occurs during initialization, this method is called. However, if something like a sale is started or card input is enabled, any errors are reported through the mechanisms defined by those methods.
///
/// \param error The error generated by the device.
///
-(void)deviceDidError:(NSError *)error;


///
/// \brief Status callback
///
/// This protocol method is called to inform the delegate the SDK's status has changed. Currently the status is changed during initialization and during operations like sale or refund. However, the status is not changed during direct operations like the integrator enabling card input directly or making a direct call to Express.
///
/// \param status The current status.
///
/// \param description The description of the current status.
///
-(void)statusDidChange:(VTPStatus)status description:(NSString *)description;

@end

#endif /* VTPDelegate_h */
