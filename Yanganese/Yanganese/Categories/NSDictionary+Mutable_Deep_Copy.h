//
//  NSDictionary+Mutable_Deep_Copy.h
//  Yanganese
//
//  Created by Michael Yang on 12/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Mutable_Deep_Copy)

// Creates a mutable deep copy
- (NSMutableDictionary *)mutableDeepCopy;

@end
