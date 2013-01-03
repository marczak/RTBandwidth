//
//  RTBandwidthView.h
//  bandwithd
//
//  Created by Edward Marczak on 11/9/12.
//  Copyright (c) 2012 Edward Marczak. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <sys/sysctl.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <sys/un.h>
#include <unistd.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <net/if_var.h>
#include <net/route.h>

#import <Foundation/Foundation.h>

typedef struct io_stats {
  UInt64  bytes_delta;
  UInt64  bytes_prev;
  UInt64  bytes;
  UInt64  bsd_bytes_prev;
  UInt64  bsd_bytes;
} io_stats;

typedef struct network_interface_stats {
  char            if_name[32];
  struct io_stats if_in;
  struct io_stats if_out;
} network_interface_stats;

@interface RTBandwidthView : NSObject {
@private
  io_stats                i_net, o_net;
  network_interface_stats *interfaceStats;
  int                     mib[6];
  char                    *buf;
  size_t                  alloc;
}

- (void)getInterfacesBandwidth;
@end
