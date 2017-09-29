/*
 *   Copyright © 2017 Teclib. All rights reserved.
 *
 * Memory.h is part of FlyveMDMInventory
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
/// Memory device Information
@interface Memory : NSObject

/**
 Total Memory Information
 
 - returns: total ram memory in the device
 */
- (double)total;// Error

/**
 Free Memory Information
 
 - returns: free ram memory in the device
 */
- (double)free;

/**
 Used Memory Information
 
 - returns: used ram memory in the device
 */
- (double)used;

/**
 Active Memory Information
 
 - returns: active ram memory in the device
 */
- (double)active;

/**
 Inactive Memory Information
 
 - returns: inactive ram memory in the device
 */
- (double)inactive;

@end
