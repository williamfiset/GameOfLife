//
//  UIDeviceHardware.m
//
//  Used to determine EXACT version of device software is running on.

#import <UIKit/UIKit.h>
#import "UIDeviceHardware.h"
#include <sys/types.h>
#include <sys/sysctl.h>

#define IS_IPHONE       UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad
#define IS_IPHONE4      ([[UIScreen mainScreen] bounds].size.width == 480 || [[UIScreen mainScreen] bounds].size.height == 480)
#define IS_IPHONE5      ([[UIScreen mainScreen] bounds].size.width == 568 || [[UIScreen mainScreen] bounds].size.height == 568)
#define IS_IPHONE6      ([[UIScreen mainScreen] bounds].size.width == 375 && [[UIScreen mainScreen] bounds].size.height == 667)
#define IS_IPHONE6_PLUS ([[UIScreen mainScreen] bounds].size.width == 414 && [[UIScreen mainScreen] bounds].size.height == 736)
#define IS_IPAD         UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

// ([[UIScreen mainScreen] bounds].size.width == 768 || [[UIScreen mainScreen] bounds].size.height == 768)

// 1334
// 1920


@implementation UIDeviceHardware

- (BOOL) isIPhone4 {
    printf("%f\n", [[UIScreen mainScreen] bounds].size.width);
    printf("%f\n", [[UIScreen mainScreen] bounds].size.height);
    return IS_IPHONE4;
}

- (BOOL) isIPhone5 {
    return IS_IPHONE5;
}

- (BOOL) isIPhone6 {
    return IS_IPHONE6;
}

- (BOOL) isIPhone6Plus {
    return IS_IPHONE6_PLUS;
}

- (BOOL) isIPad {
    return IS_IPAD;
}



- (NSString *) platform{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    return platform;
}

- (NSString *) platformString{
    NSString *platform = [self platform];
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"Verizon iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    
    return platform;
}

- (BOOL)iPhone6Plus {
    
    UIScreen *mainScreen = [UIScreen mainScreen];
    NSLog(@"Screen bounds: %@\nScreen resolution: %@\nscale: %f\nnativeScale: %f\n",
          NSStringFromCGRect(mainScreen.bounds), mainScreen.coordinateSpace, mainScreen.scale, mainScreen.nativeScale);
    
    if ([UIScreen mainScreen].scale > 2.1) return YES;
    return NO;

}

@end





