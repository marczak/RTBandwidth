//
//  main.m
//  bandwithd
//
//  Created by Edward Marczak on 11/9/12.
//  Copyright (c) 2012 Edward Marczak. All rights reserved.
//

#import "RTBandwidthView.h"
#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

  @autoreleasepool {
    
    RTBandwidthView *bwidth = [[RTBandwidthView alloc]init];
    [bwidth getInterfacesBandwidth];
    
  }
  return 0;
}

