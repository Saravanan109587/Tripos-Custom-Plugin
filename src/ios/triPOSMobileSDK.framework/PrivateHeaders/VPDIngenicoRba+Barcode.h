///
/// \file VPDIngenicoRba+BarcodeInput.h
///

#ifndef VPDIngenicoRba_Barcode_h
#define VPDIngenicoRba_Barcode_h

#ifndef DOXYGEN_SHOULD_SKIP_THIS

#import "VPDIngenicoRba.h"
#import "VPDBarcodeInput.h"

@interface  VPDIngenicoRba(BarcodeInput) <VPDBarcodeInput>

extern NSString * const ResetTypeCode;

extern NSString * const ResetActionCode;

-(BOOL)resetBarcode:(VPDErrorHandler)errorHandler;


extern NSString * const IlluminationModeTypeCode;

extern NSString * const IlluminationModeAimerAndScanLightsActionCode;

extern NSString * const IlluminationModeAimerLightsOnlyActionCode;

extern NSString * const IlluminationModeScanLightsOnlyActionCode;

extern NSString * const IlluminationModeNoLightsActionCode;

-(BOOL)setBarcodeIlluminationMode:(BOOL)enableAimerLights enableScanLights:(BOOL)enableScanLights errorHandler:(VPDErrorHandler)errorHandler;


extern NSString * const ImageModeTypeCode;

extern NSString * const ImageMode1DActionCode;

extern NSString * const ImageMode2DActionCode;

extern NSString * const ImageMode2DForShinySurfacesActionCode;

extern NSString * const ImageMode2DForBrightEnvironmentActionCode;

-(BOOL)setBarcodeImageMode:(VPDBarcodeImageMode)imageMode errorHandler:(VPDErrorHandler)errorHandler;


extern NSString * const LightingModeTypeCode;

extern NSString * const LightingModeLongerExposure;

extern NSString * const LightingModeShorterExposure;

-(BOOL)setBarcodeLightingMode:(VPDBarcodeLightingMode)lightingMode errorHandler:(VPDErrorHandler)errorHandler;


extern NSString * const ScanModeTypeCode;

extern NSString * const ScanModeActionCodeSingle;

-(BOOL)setBarcodeSingleScanMode:(VPDErrorHandler)errorHandler;


extern NSString * const SymbologiesTypeCode;

extern NSString * const SymbologiesEnabledActionCode;

-(BOOL)setBarcodeSymbologies:(NSArray<NSString *> *)symbologies errorHandler:(VPDErrorHandler)errorHandler;


extern NSString * const PowerTypeCode;

extern NSString * const PowerOffActionCode;

extern NSString * const PowerOnActionCode;

-(BOOL)powerBarcodeReader:(BOOL)on errorHandler:(VPDErrorHandler)errorHandler;


extern NSString * const TriggerTypeCode;

extern NSString * const TriggerDisabledActionCode;

extern NSString * const TriggerEnabledActionCode;

-(BOOL)setBarcodeReaderTrigger:(BOOL)enabled errorHandler:(VPDErrorHandler)errorHandler;


extern NSString * const ScanTypeCode;

extern NSString * const ScanStopActionCode;

extern NSString * const ScanStartActionCode;

-(BOOL)setBarcodeReaderScan:(BOOL)start errorHandler:(VPDErrorHandler)errorHandler;


-(BOOL)barcodeSet:(NSString *)typeCode actionCode:(NSString *)actionCode symbologyList:(NSString *)symbologyList errorHandler:(VPDErrorHandler)errorHandler;

@end

#endif /* !DOXYGEN_SHOULD_SKIP_THIS */

#endif /* VPDIngenicoRba_Barcode_h */

