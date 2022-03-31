# datacenter_fabric

# Table of Contents

- [Fabric Switches and Management IP](#fabric-switches-and-management-ip)
  - [Fabric Switches with inband Management IP](#fabric-switches-with-inband-management-ip)
- [Fabric Topology](#fabric-topology)
- [Fabric IP Allocation](#fabric-ip-allocation)
  - [Fabric Point-To-Point Links](#fabric-point-to-point-links)
  - [Point-To-Point Links Node Allocation](#point-to-point-links-node-allocation)
  - [Loopback Interfaces (BGP EVPN Peering)](#loopback-interfaces-bgp-evpn-peering)
  - [Loopback0 Interfaces Node Allocation](#loopback0-interfaces-node-allocation)
  - [VTEP Loopback VXLAN Tunnel Source Interfaces (VTEPs Only)](#vtep-loopback-vxlan-tunnel-source-interfaces-vteps-only)
  - [VTEP Loopback Node allocation](#vtep-loopback-node-allocation)

# Fabric Switches and Management IP

| POD | Type | Node | Management IP | Platform | Provisioned in CloudVision |
| --- | ---- | ---- | ------------- | -------- | -------------------------- |
| datacenter_fabric | spine | switch01 | 10.73.254.1/24 | veos-lab | Provisioned |
| datacenter_fabric | spine | switch02 | 10.73.254.2/24 | veos-lab | Provisioned |
| datacenter_fabric | l3leaf | switch03 | 10.73.254.3/24 | veos-lab | Provisioned |
| datacenter_fabric | l3leaf | switch04 | 10.73.254.4/24 | veos-lab | Provisioned |
| datacenter_fabric | l3leaf | switch05 | 10.73.254.5/24 | veos-lab | Provisioned |
| datacenter_fabric | l3leaf | switch06 | 10.73.254.6/24 | veos-lab | Provisioned |
| datacenter_fabric | l3leaf | switch07 | 10.73.254.7/24 | veos-lab | Provisioned |
| datacenter_fabric | l3leaf | switch08 | 10.73.254.8/24 | veos-lab | Provisioned |
| datacenter_fabric | l2leaf | switch013 | 10.73.254.13/24 | veos-lab | Provisioned |
| datacenter_fabric | l2leaf | switch014 | 10.73.254.14/24 | veos-lab | Provisioned |
| datacenter_fabric | l2leaf | switch015 | 10.73.254.15/24 | veos-lab | Provisioned |

> Provision status is based on Ansible inventory declaration and do not represent real status from CloudVision.

## Fabric Switches with inband Management IP
| POD | Type | Node | Management IP | Inband Interface |
| --- | ---- | ---- | ------------- | ---------------- |

# Fabric Topology

| Type | Node | Node Interface | Peer Type | Peer Node | Peer Interface |
| ---- | ---- | -------------- | --------- | ----------| -------------- |
| spine | switch01 | ethernet1 | l3leaf | switch03 | ethernet1 |
| spine | switch01 | ethernet2 | l3leaf | switch04 | ethernet1 |
| spine | switch01 | ethernet3 | l3leaf | switch05 | ethernet1 |
| spine | switch01 | ethernet4 | l3leaf | switch06 | ethernet1 |
| spine | switch01 | ethernet5 | l3leaf | switch07 | ethernet1 |
| spine | switch01 | ethernet6 | l3leaf | switch08 | ethernet1 |
| spine | switch02 | ethernet1 | l3leaf | switch03 | ethernet2 |
| spine | switch02 | ethernet2 | l3leaf | switch04 | ethernet2 |
| spine | switch02 | ethernet3 | l3leaf | switch05 | ethernet2 |
| spine | switch02 | ethernet4 | l3leaf | switch06 | ethernet2 |
| spine | switch02 | ethernet5 | l3leaf | switch07 | ethernet2 |
| spine | switch02 | ethernet6 | l3leaf | switch08 | ethernet2 |
| l3leaf | switch03 | Ethernet3 | mlag_peer | switch04 | Ethernet3 |
| l3leaf | switch03 | ethernet4 | l2leaf | switch013 | ethernet1 |
| l3leaf | switch04 | ethernet4 | l2leaf | switch013 | ethernet2 |
| l3leaf | switch05 | Ethernet3 | mlag_peer | switch06 | Ethernet3 |
| l3leaf | switch05 | ethernet4 | l2leaf | switch014 | ethernet1 |
| l3leaf | switch06 | ethernet4 | l2leaf | switch014 | ethernet2 |
| l3leaf | switch07 | Ethernet3 | mlag_peer | switch08 | Ethernet3 |
| l3leaf | switch07 | ethernet4 | l2leaf | switch015 | ethernet1 |
| l3leaf | switch08 | ethernet4 | l2leaf | switch015 | ethernet2 |

# Fabric IP Allocation

## Fabric Point-To-Point Links

| Uplink IPv4 Pool | Available Addresses | Assigned addresses | Assigned Address % |
| ---------------- | ------------------- | ------------------ | ------------------ |
| 172.31.255.0/24 | 256 | 24 | 9.38 % |

## Point-To-Point Links Node Allocation

| Node | Node Interface | Node IP Address | Peer Node | Peer Interface | Peer IP Address |
| ---- | -------------- | --------------- | --------- | -------------- | --------------- |
| switch01 | ethernet1 | 172.31.255.8/31 | switch03 | ethernet1 | 172.31.255.9/31 |
| switch01 | ethernet2 | 172.31.255.12/31 | switch04 | ethernet1 | 172.31.255.13/31 |
| switch01 | ethernet3 | 172.31.255.16/31 | switch05 | ethernet1 | 172.31.255.17/31 |
| switch01 | ethernet4 | 172.31.255.20/31 | switch06 | ethernet1 | 172.31.255.21/31 |
| switch01 | ethernet5 | 172.31.255.24/31 | switch07 | ethernet1 | 172.31.255.25/31 |
| switch01 | ethernet6 | 172.31.255.28/31 | switch08 | ethernet1 | 172.31.255.29/31 |
| switch02 | ethernet1 | 172.31.255.10/31 | switch03 | ethernet2 | 172.31.255.11/31 |
| switch02 | ethernet2 | 172.31.255.14/31 | switch04 | ethernet2 | 172.31.255.15/31 |
| switch02 | ethernet3 | 172.31.255.18/31 | switch05 | ethernet2 | 172.31.255.19/31 |
| switch02 | ethernet4 | 172.31.255.22/31 | switch06 | ethernet2 | 172.31.255.23/31 |
| switch02 | ethernet5 | 172.31.255.26/31 | switch07 | ethernet2 | 172.31.255.27/31 |
| switch02 | ethernet6 | 172.31.255.30/31 | switch08 | ethernet2 | 172.31.255.31/31 |

## Loopback Interfaces (BGP EVPN Peering)

| Loopback Pool | Available Addresses | Assigned addresses | Assigned Address % |
| ------------- | ------------------- | ------------------ | ------------------ |
| 192.168.1.0/24 | 256 | 8 | 3.13 % |

## Loopback0 Interfaces Node Allocation

| POD | Node | Loopback0 |
| --- | ---- | --------- |
| datacenter_fabric | switch01 | 192.168.1.1/32 |
| datacenter_fabric | switch02 | 192.168.1.2/32 |
| datacenter_fabric | switch03 | 192.168.1.5/32 |
| datacenter_fabric | switch04 | 192.168.1.6/32 |
| datacenter_fabric | switch05 | 192.168.1.7/32 |
| datacenter_fabric | switch06 | 192.168.1.8/32 |
| datacenter_fabric | switch07 | 192.168.1.9/32 |
| datacenter_fabric | switch08 | 192.168.1.10/32 |

## VTEP Loopback VXLAN Tunnel Source Interfaces (VTEPs Only)

| VTEP Loopback Pool | Available Addresses | Assigned addresses | Assigned Address % |
| --------------------- | ------------------- | ------------------ | ------------------ |
| 192.168.254.0/24 | 256 | 6 | 2.35 % |

## VTEP Loopback Node allocation

| POD | Node | Loopback1 |
| --- | ---- | --------- |
| datacenter_fabric | switch03 | 192.168.254.5/32 |
| datacenter_fabric | switch04 | 192.168.254.5/32 |
| datacenter_fabric | switch05 | 192.168.254.7/32 |
| datacenter_fabric | switch06 | 192.168.254.7/32 |
| datacenter_fabric | switch07 | 192.168.254.9/32 |
| datacenter_fabric | switch08 | 192.168.254.9/32 |
