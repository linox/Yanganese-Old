//
//  NSDictionary+Mutable_Deep_Copy.m
//  Yanganese
//
//  Created by Michael Yang on 12/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NSDictionary+Mutable_Deep_Copy.h"

@implementation NSDictionary (Mutable_Deep_Copy)

- (NSMutableDictionary *)mutableDeepCopy{
    NSMutableDictionary *retainedCopy = [[NSMutableDictionary alloc] initWithCapacity:[self count]];
	
	// fill mutable dictionary based on value mutability
    NSArray *keys = [self allKeys];
    for(id key in keys) {
		id oneValue = [self valueForKey:key];
		id oneCopy = nil;
		
		if([oneValue respondsToSelector:@selector(mutableDeepCopy)])
			oneCopy = [oneValue mutableDeepCopy];
		else if([oneValue respondsToSelector:@selector(mutableCopy)])
			oneCopy = [oneValue mutableCopy];
		else if(oneCopy == nil)
			oneCopy = [oneValue copy];
        
		[retainedCopy setValue:oneCopy forKey:key];
	}
	
	return retainedCopy;
}

@end
