/*
 * Copyright 2009-2011,2014 Ettus Research LLC
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef INCLUDED_ETH_MAC_ADDR_H
#define INCLUDED_ETH_MAC_ADDR_H

#include <stdint.h>

// Ethernet MAC address

#pragma pack(push,1)
typedef struct {
  uint8_t	addr[6];
} eth_mac_addr_t;
#pragma pack(pop)

#endif /* INCLUDED_ETH_MAC_ADDR_H */
