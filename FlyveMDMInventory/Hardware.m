/*
 *   Copyright © 2017 Teclib. All rights reserved.
 *
 * Hardware.m is part of FlyveMDMInventory
 *
 * FlyveMDMInventory is a subproject of Flyve MDM. Flyve MDM is a mobile
 * device management software.
 *
 * FlyveMDMInventory is free software: you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 3
 * of the License, or (at your option) any later version.
 *
 * FlyveMDMInventory is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * ------------------------------------------------------------------------------
 * @author    Hector Rondon
 * @date      13/06/17
 * @copyright Copyright © 2017 Teclib. All rights reserved.
 * @license   GPLv3 https://www.gnu.org/licenses/gpl-3.0.html
 * @link      https://github.com/flyve-mdm/flyve-mdm-ios-inventory
 * @link      https://flyve-mdm.com
 * ------------------------------------------------------------------------------
 */

#import "Hardware.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#include <sys/sysctl.h>
#include <mach/machine.h>
#import <sys/utsname.h>

/// Hardware Information
@implementation Hardware

/**
 Device ID
 
 - returns: UUIDString
 */
- (NSString *)uuid {
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

/**
 Device Name
 
 - returns: Device name string
 */
- (nullable NSString *)name {
    
    return [[UIDevice currentDevice] name];
}

/**
 Model of Device
 
 - returns: Model of Device string
 */
- (NSString *)model {
    return [self getSystemInfoWith:"hw.model"];
}

/**
 Operating System Name
 
 - returns: Operating system name of Device string
 */
- (nullable NSString *)osName {
    
    return [[UIDevice currentDevice] systemName];
}

/**
 Operating System Type
 
 - returns: Operating system type of Device string
 */
- (nullable NSString *)osType {
    
    struct utsname systemInfo;
    uname(&systemInfo);
    
    return [NSString stringWithCString:systemInfo.sysname
                              encoding:NSUTF8StringEncoding];
    
    
}

/**
 Operating System Version
 
 - returns: Operating system version of Device string
 */
- (nullable NSString *)osVersion {
    
    return [[NSProcessInfo processInfo] operatingSystemVersionString];
}

/**
 System architecture name
 
 - returns: System architecture name of Device string
 */
- (nullable NSString *)archName {
    
    NSMutableString *cpu = [[NSMutableString alloc] init];
    
    size_t size;
    cpu_type_t type;
    cpu_subtype_t subtype;
    
    size = sizeof(type);
    sysctlbyname("hw.cputype", &type, &size, NULL, 0);
    
    size = sizeof(subtype);
    sysctlbyname("hw.cpusubtype", &subtype, &size, NULL, 0);
    
    if (type == CPU_TYPE_X86)
    {
        [cpu appendString:@"x86"];
        
        if(sizeof(int*) == 8) {
            //system is 64-bit
            [cpu appendString:@"_64"];
        }
        
    }
    else if (type == CPU_TYPE_ARM)
    {
        [cpu appendString:@"ARM"];
        
        switch(subtype) {
            
            case CPU_SUBTYPE_ARM_V4T:
                [cpu appendString:@"_V4T"];
                break;
            case CPU_SUBTYPE_ARM_V6:
                [cpu appendString:@"_V6"];
                break;
            case CPU_SUBTYPE_ARM_V5TEJ:
                [cpu appendString:@"_V5TEJ"];
                break;
            case CPU_SUBTYPE_ARM_XSCALE:
                [cpu appendString:@"_XSCALE"];
                break;
            case CPU_SUBTYPE_ARM_V7:
                [cpu appendString:@"_V7"];
                break;
            case CPU_SUBTYPE_ARM_V7F:
                [cpu appendString:@"_V7F"];
                break;
            case CPU_SUBTYPE_ARM_V7S:
                [cpu appendString:@"_V7S"];
                break;
            case CPU_SUBTYPE_ARM_V7K:
                [cpu appendString:@"_V7K"];
                break;
            case CPU_SUBTYPE_ARM_V6M:
                [cpu appendString:@"_V6M"];
                break;
            case CPU_SUBTYPE_ARM_V7M:
                [cpu appendString:@"_V7M"];
                break;
            case CPU_SUBTYPE_ARM_V7EM:
                [cpu appendString:@"_V7EM"];
                break;
            case CPU_SUBTYPE_ARM_V8:
                [cpu appendString:@"_V8"];
                break;
      
        }
    } else if(type == CPU_TYPE_ARM64) {
        
        [cpu appendString:@"ARM64"];
        
        switch(subtype) {

            case CPU_SUBTYPE_ARM64_V8:
                [cpu appendString:@"_V8"];
                break;
        
        }
    }
    
    return [NSString stringWithString:cpu];
}

/**
 Information Hardware by name
 
 - returns: Information Hardware by name in string
 */
- (NSString *) getSystemInfoWith:(char *)name
{
    size_t size;
    sysctlbyname(name, NULL, &size, NULL, 0);
    
    char *answer = malloc(size);
    sysctlbyname(name, answer, &size, NULL, 0);
    
    NSString *result = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];
    free(answer);
    
    return result;
}

@end
