//
//  RTBandwidthView.m
//  bandwithd
//
//  Created by Edward Marczak on 11/9/12.
//  Copyright (c) 2012 Edward Marczak. All rights reserved.
//

#import "RTBandwidthView.h"

@implementation RTBandwidthView

- (void)getInterfacesBandwidth {

  struct if_msghdr	*ifm, *nextifm;
  struct sockaddr_dl	*sdl;
  char		*lim, *next;
  size_t		needed;
  char		s[32];
  mib[0] = CTL_NET;
  mib[1] = PF_ROUTE;
  mib[2] = 0;
  mib[3] = 0;
  mib[4] = NET_RT_IFLIST;
  mib[5] = 0;
  
  if (sysctl(mib, 6, NULL, &needed, NULL, 0) < 0)
    return;
  if (alloc < needed) {
    if (buf != NULL)
      free(buf);
    buf = malloc(needed);
    if (buf == NULL)
      return;
    alloc = needed;
  }
  
  if (sysctl(mib, 6, buf, &needed, NULL, 0) < 0)
    return;
  lim = buf + needed;
  
  next = buf;
  while (next < lim) {
    ifm = (struct if_msghdr *)next;
    if (ifm->ifm_type != RTM_IFINFO)
      return;
    next += ifm->ifm_msglen;
    
    while (next < lim) {
      nextifm = (struct if_msghdr *)next;
      if (nextifm->ifm_type != RTM_NEWADDR)
        break;
      next += nextifm->ifm_msglen;
    }
    
    if (ifm->ifm_flags & IFF_UP) {
      sdl = (struct sockaddr_dl *)(ifm + 1);
      if (sdl->sdl_family != AF_LINK)
        continue;
      strncpy(s, sdl->sdl_data, sdl->sdl_nlen);
      s[sdl->sdl_nlen] = '\0';
      
      NSLog(@"if: %s, In: %lld, out: %lld", s, (UInt64)ifm->ifm_data.ifi_ibytes,
            (UInt64)ifm->ifm_data.ifi_obytes);
    }
  }
}

@end

