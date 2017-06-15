/*
 *   Copyright © 2017 Teclib. All rights reserved.
 *
 * OperatingSystem.m is part of FlyveMDMInventory
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
 * @date      15/06/17
 * @copyright Copyright © 2017 Teclib. All rights reserved.
 * @license   GPLv3 https://www.gnu.org/licenses/gpl-3.0.html
 * @link      https://github.com/flyve-mdm/flyve-mdm-ios-inventory
 * @link      https://flyve-mdm.com
 * ------------------------------------------------------------------------------
 */

#import "OperatingSystem.h"

#include <sys/sysctl.h>

@implementation OperatingSystem

/**
 Operating System Name
 
 - returns: Operating system name of Device string
 */
- (nullable NSString *)name {
    
    return [[UIDevice currentDevice] systemName];
}

/**
 Operating System Version
 
 - returns: Operating system version of Device string
 */
- (nullable NSString *)version {
    
    NSOperatingSystemVersion version = [[NSProcessInfo processInfo] operatingSystemVersion];
    
    return [NSString stringWithFormat:@"%d.%d.%d", version.majorVersion, version.minorVersion, version.patchVersion];
}

/**
 Operating System Kernel Name
 
 - returns: Operating system kernel name of Device string
 */
- (nullable NSString *)kernelName {
    
    return [self getSystemInfoWith:"kern.ostype"];
}

/**
 Operating System Kernel Version
 
 - returns: Operating system kernel version of Device string
 */
- (nullable NSString *)kernelVersion {
    
    return [self getSystemInfoWith:"kern.osrelease"];
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
