//
//  UIDeviceHardware.h
//
//  Used to determine EXACT version of device software is running on.

#import <Foundation/Foundation.h>

#define IS_IPHONE       UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad
#define IS_IPHONE4      ([[UIScreen mainScreen] bounds].size.width == 480 || [[UIScreen mainScreen] bounds].size.height == 480)
#define IS_IPHONE5      ([[UIScreen mainScreen] bounds].size.width == 568 || [[UIScreen mainScreen] bounds].size.height == 568)
#define IS_IPHONE6      ([[UIScreen mainScreen] bounds].size.width == 375 && [[UIScreen mainScreen] bounds].size.height == 667)
#define IS_IPHONE6_PLUS ([[UIScreen mainScreen] bounds].size.width == 414 && [[UIScreen mainScreen] bounds].size.height == 736)
#define IS_IPAD         UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad


@interface UIDeviceHardware : NSObject 


- (NSString *) platform;
- (NSString *) platformString;

- (BOOL) isIPhone4 ;

- (BOOL) isIPhone5 ;

- (BOOL) isIPhone6 ;

- (BOOL) isIPhone6Plus;

- (BOOL) isIPad;


@end