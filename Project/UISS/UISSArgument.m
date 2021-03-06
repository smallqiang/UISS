//
//  UISSArgument.m
//  UISS
//
//  Created by Robert Wijas on 6/2/12.
//  Copyright (c) 2012 57things. All rights reserved.
//

#import "UISSArgument.h"

@interface UISSArgument ()

@property (nonatomic, readonly) id<UISSArgumentValueConverter> converter;

@end

@implementation UISSArgument

@synthesize propertySetter = _propertySetter;

@synthesize config = _config;

@synthesize name = _name;
@synthesize value = _value;

- (id)init
{
    self = [super init];
    if (self) {
        self.config = [UISSConfig sharedConfig];
    }
    return self;
}

- (id<UISSArgumentValueConverter>)converter;
{
    for (id<UISSArgumentValueConverter> converter in self.availableConverters) {
        if ([converter canConvertValueForArgument:self]) {
            return converter;
        }
    }
    
    return nil;
}

- (id)convertedValue;
{
    return [self.converter convertValue:self.value];
}

- (NSString *)generatedCode;
{
    return [self.converter generateCodeForValue:self.value];
}

@end
