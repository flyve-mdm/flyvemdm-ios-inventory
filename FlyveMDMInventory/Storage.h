/*
 *   Copyright © 2017 Teclib. All rights reserved.
 *
 * Storage.h is part of FlyveMDMInventory
 *
 * FlyveMDMInventory is a subproject of Flyve MDM. Flyve MDM is a mobile
 * device management software.
 *
 * FlyveMDMInventory is Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ------------------------------------------------------------------------------
 * @author    Hector Rondon
 * @date      07/06/17
 * @copyright Copyright © 2017 Teclib. All rights reserved.
 * @license   Apache License, Version 2.0 https://www.apache.org/licenses/LICENSE-2.0
 * @link      https://github.com/flyve-mdm/flyve-mdm-ios-inventory
 * @link      https://flyve-mdm.com
 * ------------------------------------------------------------------------------
 */

#import <Foundation/Foundation.h>
/// Disk space information
@interface Storage: NSObject

/**
 Total disk space information
 
 - returns: Total disk space in the device
 */
- (nullable NSString *)total;

/**
 Total free disk space information
 
 - returns: Total disk space in the device
 */
- (nullable NSString *)free:(BOOL)inPercent;

/**
 Total used disk space information
 
 - returns: Total used disk space in the device
 */
- (nullable NSString *)used:(BOOL)inPercent;

/**
 Partitions disk information
 
 - returns: Partitions disk in the device
 */
- (nullable NSString *)partitions;

@end
