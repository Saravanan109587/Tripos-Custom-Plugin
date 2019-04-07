///
/// \file VTPCardEntryMode.h
///

#ifndef VTPCardEntryMode_h
#define VTPCardEntryMode_h

///
/// \enum VTPCardEntryMode
///
typedef enum _VTPCardEntryMode
{
    /// Keyed
    VTPCardEntryModeKeyed,
    /// Swiped
    VTPCardEntryModeSwiped,
    /// Contactless magnetic stripe
    VTPCardEntryModeContactlessMagneticStripe,
    /// ICC
    VTPCardEntryModeIcc,
}   VTPCardEntryMode;

#endif /* VTPCardEntryMode_h */
