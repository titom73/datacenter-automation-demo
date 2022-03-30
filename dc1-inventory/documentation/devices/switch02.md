# switch02
# Table of Contents

- [Management](#management)
  - [Management Interfaces](#management-interfaces)
  - [Name Servers](#name-servers)
  - [Clock Settings](#clock-settings)
  - [NTP](#ntp)
  - [Management SSH](#management-ssh)
  - [Management API HTTP](#management-api-http)
- [Authentication](#authentication)
  - [Local Users](#local-users)
  - [AAA Authorization](#aaa-authorization)
- [Monitoring](#monitoring)
  - [TerminAttr Daemon](#terminattr-daemon)
  - [SNMP](#snmp)
- [Spanning Tree](#spanning-tree)
  - [Spanning Tree Summary](#spanning-tree-summary)
  - [Spanning Tree Device Configuration](#spanning-tree-device-configuration)
- [Internal VLAN Allocation Policy](#internal-vlan-allocation-policy)
  - [Internal VLAN Allocation Policy Summary](#internal-vlan-allocation-policy-summary)
  - [Internal VLAN Allocation Policy Configuration](#internal-vlan-allocation-policy-configuration)
- [Interfaces](#interfaces)
  - [Ethernet Interfaces](#ethernet-interfaces)
  - [Loopback Interfaces](#loopback-interfaces)
- [Routing](#routing)
  - [Service Routing Protocols Model](#service-routing-protocols-model)
  - [IP Routing](#ip-routing)
  - [IPv6 Routing](#ipv6-routing)
  - [Static Routes](#static-routes)
  - [Router BGP](#router-bgp)
- [BFD](#bfd)
  - [Router BFD](#router-bfd)
- [Multicast](#multicast)
- [Filters](#filters)
  - [Prefix-lists](#prefix-lists)
  - [Route-maps](#route-maps)
- [ACL](#acl)
- [VRF Instances](#vrf-instances)
  - [VRF Instances Summary](#vrf-instances-summary)
  - [VRF Instances Device Configuration](#vrf-instances-device-configuration)
- [Quality Of Service](#quality-of-service)

# Management

## Management Interfaces

### Management Interfaces Summary

#### IPv4

| Management Interface | description | Type | VRF | IP Address | Gateway |
| -------------------- | ----------- | ---- | --- | ---------- | ------- |
| Management1 | oob_management | oob | MGMT | 10.73.254.2/24 | 10.73.254.253 |

#### IPv6

| Management Interface | description | Type | VRF | IPv6 Address | IPv6 Gateway |
| -------------------- | ----------- | ---- | --- | ------------ | ------------ |
| Management1 | oob_management | oob | MGMT | -  | - |

### Management Interfaces Device Configuration

```eos
!
interface Management1
   description oob_management
   no shutdown
   vrf MGMT
   ip address 10.73.254.2/24
```

## Name Servers

### Name Servers Summary

| Name Server | Source VRF |
| ----------- | ---------- |
| 10.73.1.251 | MGMT |

### Name Servers Device Configuration

```eos
ip name-server vrf MGMT 10.73.1.251
```

## Clock Settings

### Clock Timezone Settings

Clock Timezone is set to **Europe/Paris**.

### Clock Configuration

```eos
!
clock timezone Europe/Paris
```

## NTP

### NTP Summary

#### NTP Servers

| Server | VRF | Preferred | Burst | iBurst | Version | Min Poll | Max Poll | Local-interface | Key |
| ------ | --- | --------- | ----- | ------ | ------- | -------- | -------- | --------------- | --- |
| 10.73.1.254 | MGMT | True | - | - | - | - | - | - | - |
| 10.73.254.253 | MGMT | - | - | - | - | - | - | - | - |

### NTP Device Configuration

```eos
!
ntp server vrf MGMT 10.73.1.254 prefer
ntp server vrf MGMT 10.73.254.253
```

## Management SSH


 ### SSH timeout and management

| Idle Timeout | SSH Management |
| ------------ | -------------- |
| 0 |  Enabled  |

### Max number of SSH sessions limit and per-host limit

| Connection Limit | Max from a single Host |
| ---------------- | ---------------------- |
| - | - |

### Ciphers and algorithms

| Ciphers | Key-exchange methods | MAC algorithms | Hostkey server algorithms |
|---------|----------------------|----------------|---------------------------|
| default | default | default | default |

### VRFs

| VRF | Status |
| --- | ------ |
| MGT |  Enabled  |

### Management SSH Configuration

```eos
!
management ssh
   idle-timeout 0
   no shutdown
   vrf MGT
      no shutdown
```

## Management API HTTP

### Management API HTTP Summary

| HTTP | HTTPS |
| ---- | ----- |
| False | True |

### Management API VRF Access

| VRF Name | IPv4 ACL | IPv6 ACL |
| -------- | -------- | -------- |
| MGMT | - | - |

### Management API HTTP Configuration

```eos
!
management api http-commands
   protocol https
   no shutdown
   !
   vrf MGMT
      no shutdown
```

# Authentication

## Local Users

### Local Users Summary

| User | Privilege | Role |
| ---- | --------- | ---- |
| admin | 15 | network-admin |
| ansible | 15 | network-admin |
| cvpadmin | 15 | network-admin |
| demo | 15 | network-admin |

### Local Users Device Configuration

```eos
!
username admin privilege 15 role network-admin nopassword
username ansible privilege 15 role network-admin secret sha512 $6$Dzu11L7yp9j3nCM9$FSptxMPyIL555OMO.ldnjDXgwZmrfMYwHSr0uznE5Qoqvd9a6UdjiFcJUhGLtvXVZR1r.A/iF5aAt50hf/EK4/
username cvpadmin privilege 15 role network-admin secret sha512 $6$rZKcbIZ7iWGAWTUM$TCgDn1KcavS0s.OV8lacMTUkxTByfzcGlFlYUWroxYuU7M/9bIodhRO7nXGzMweUxvbk8mJmQl8Bh44cRktUj.
username demo privilege 15 role network-admin secret sha512 $6$Dzu11L7yp9j3nCM9$FSptxMPyIL555OMO.ldnjDXgwZmrfMYwHSr0uznE5Qoqvd9a6UdjiFcJUhGLtvXVZR1r.A/iF5aAt50hf/EK4/
```

## AAA Authorization

### AAA Authorization Summary

| Type | User Stores |
| ---- | ----------- |
| Exec | local |

Authorization for configuration commands is disabled.

### AAA Authorization Device Configuration

```eos
!
aaa authorization exec default local
!
```

# Monitoring

## TerminAttr Daemon

### TerminAttr Daemon Summary

| CV Compression | CloudVision Servers | VRF | Authentication | Smash Excludes | Ingest Exclude | Bypass AAA |
| -------------- | ------------------- | --- | -------------- | -------------- | -------------- | ---------- |
| gzip | 10.73.254.254:9910 | MGMT | key,telarista | ale,flexCounter,hardware,kni,pulse,strata | /Sysdb/cell/1/agent,/Sysdb/cell/2/agent | False |

### TerminAttr Daemon Device Configuration

```eos
!
daemon TerminAttr
   exec /usr/bin/TerminAttr -cvaddr=10.73.254.254:9910 -cvauth=key,telarista -cvvrf=MGMT -smashexcludes=ale,flexCounter,hardware,kni,pulse,strata -ingestexclude=/Sysdb/cell/1/agent,/Sysdb/cell/2/agent -taillogs
   no shutdown
```

## SNMP

### SNMP Configuration Summary

| Contact | Location | SNMP Traps | State |
| ------- | -------- | ---------- | ----- |
| - | - | All | Disabled |

### SNMP Communities

| Community | Access | Access List IPv4 | Access List IPv6 | View |
| --------- | ------ | ---------------- | ---------------- | ---- |
| inetsix-ro | rw | inetsix-snmp-acl | - | test |

### SNMP Device Configuration

```eos
!
snmp-server community inetsix-ro view test rw inetsix-snmp-acl
```

# Spanning Tree

## Spanning Tree Summary

STP mode: **none**

## Spanning Tree Device Configuration

```eos
!
spanning-tree mode none
```

# Internal VLAN Allocation Policy

## Internal VLAN Allocation Policy Summary

| Policy Allocation | Range Beginning | Range Ending |
| ------------------| --------------- | ------------ |
| ascending | 1006 | 1199 |

## Internal VLAN Allocation Policy Configuration

```eos
!
vlan internal order ascending range 1006 1199
```

# Interfaces

## Ethernet Interfaces

### Ethernet Interfaces Summary

#### L2

| Interface | Description | Mode | VLANs | Native VLAN | Trunk Group | Channel-Group |
| --------- | ----------- | ---- | ----- | ----------- | ----------- | ------------- |

*Inherited from Port-Channel Interface

#### IPv4

| Interface | Description | Type | Channel Group | IP Address | VRF |  MTU | Shutdown | ACL In | ACL Out |
| --------- | ----------- | -----| ------------- | ---------- | ----| ---- | -------- | ------ | ------- |
| ethernet1 | P2P_LINK_TO_SWITCH03_ethernet2 | routed | - | 172.31.255.10/31 | default | 9000 | false | - | - |
| ethernet2 | P2P_LINK_TO_SWITCH04_ethernet2 | routed | - | 172.31.255.14/31 | default | 9000 | false | - | - |
| ethernet3 | P2P_LINK_TO_SWITCH05_ethernet2 | routed | - | 172.31.255.18/31 | default | 9000 | false | - | - |
| ethernet4 | P2P_LINK_TO_SWITCH06_ethernet2 | routed | - | 172.31.255.22/31 | default | 9000 | false | - | - |
| ethernet5 | P2P_LINK_TO_SWITCH07_ethernet2 | routed | - | 172.31.255.26/31 | default | 9000 | false | - | - |
| ethernet6 | P2P_LINK_TO_SWITCH08_ethernet2 | routed | - | 172.31.255.30/31 | default | 9000 | false | - | - |

### Ethernet Interfaces Device Configuration

```eos
!
interface ethernet1
   description P2P_LINK_TO_SWITCH03_ethernet2
   no shutdown
   mtu 9000
   no switchport
   ip address 172.31.255.10/31
!
interface ethernet2
   description P2P_LINK_TO_SWITCH04_ethernet2
   no shutdown
   mtu 9000
   no switchport
   ip address 172.31.255.14/31
!
interface ethernet3
   description P2P_LINK_TO_SWITCH05_ethernet2
   no shutdown
   mtu 9000
   no switchport
   ip address 172.31.255.18/31
!
interface ethernet4
   description P2P_LINK_TO_SWITCH06_ethernet2
   no shutdown
   mtu 9000
   no switchport
   ip address 172.31.255.22/31
!
interface ethernet5
   description P2P_LINK_TO_SWITCH07_ethernet2
   no shutdown
   mtu 9000
   no switchport
   ip address 172.31.255.26/31
!
interface ethernet6
   description P2P_LINK_TO_SWITCH08_ethernet2
   no shutdown
   mtu 9000
   no switchport
   ip address 172.31.255.30/31
```

## Loopback Interfaces

### Loopback Interfaces Summary

#### IPv4

| Interface | Description | VRF | IP Address |
| --------- | ----------- | --- | ---------- |
| Loopback0 | EVPN_Overlay_Peering | default | 192.168.1.2/32 |

#### IPv6

| Interface | Description | VRF | IPv6 Address |
| --------- | ----------- | --- | ------------ |
| Loopback0 | EVPN_Overlay_Peering | default | - |


### Loopback Interfaces Device Configuration

```eos
!
interface Loopback0
   description EVPN_Overlay_Peering
   no shutdown
   ip address 192.168.1.2/32
```

# Routing
## Service Routing Protocols Model

Multi agent routing protocol model enabled

```eos
!
service routing protocols model multi-agent
```

## IP Routing

### IP Routing Summary

| VRF | Routing Enabled |
| --- | --------------- |
| default | true |
| MGMT | false |

### IP Routing Device Configuration

```eos
!
ip routing
no ip routing vrf MGMT
```
## IPv6 Routing

### IPv6 Routing Summary

| VRF | Routing Enabled |
| --- | --------------- |
| default | false |
| MGMT | false |

## Static Routes

### Static Routes Summary

| VRF | Destination Prefix | Next Hop IP             | Exit interface      | Administrative Distance       | Tag               | Route Name                    | Metric         |
| --- | ------------------ | ----------------------- | ------------------- | ----------------------------- | ----------------- | ----------------------------- | -------------- |
| MGMT  | 0.0.0.0/0 |  10.73.254.253  |  -  |  1  |  -  |  -  |  - |

### Static Routes Device Configuration

```eos
!
ip route vrf MGMT 0.0.0.0/0 10.73.254.253
```

## Router BGP

### Router BGP Summary

| BGP AS | Router ID |
| ------ | --------- |
| 65001|  192.168.1.2 |

| BGP Tuning |
| ---------- |
| no bgp default ipv4-unicast |
| distance bgp 20 200 200 |
| graceful-restart restart-time 300 |
| graceful-restart |
| maximum-paths 4 ecmp 4 |

### Router BGP Peer Groups

#### EVPN-OVERLAY-PEERS

| Settings | Value |
| -------- | ----- |
| Address Family | evpn |
| Next-hop unchanged | True |
| Source | Loopback0 |
| BFD | True |
| Ebgp multihop | 3 |
| Send community | all |
| Maximum routes | 0 (no limit) |

#### IPv4-UNDERLAY-PEERS

| Settings | Value |
| -------- | ----- |
| Address Family | ipv4 |
| Send community | all |
| Maximum routes | 12000 |

### BGP Neighbors

| Neighbor | Remote AS | VRF | Shutdown | Send-community | Maximum-routes | Allowas-in | BFD |
| -------- | --------- | --- | -------- | -------------- | -------------- | ---------- | --- |
| 172.31.255.11 | 65101 | default | - | Inherited from peer group IPv4-UNDERLAY-PEERS | Inherited from peer group IPv4-UNDERLAY-PEERS | - | - |
| 172.31.255.15 | 65101 | default | - | Inherited from peer group IPv4-UNDERLAY-PEERS | Inherited from peer group IPv4-UNDERLAY-PEERS | - | - |
| 172.31.255.19 | 65102 | default | - | Inherited from peer group IPv4-UNDERLAY-PEERS | Inherited from peer group IPv4-UNDERLAY-PEERS | - | - |
| 172.31.255.23 | 65102 | default | - | Inherited from peer group IPv4-UNDERLAY-PEERS | Inherited from peer group IPv4-UNDERLAY-PEERS | - | - |
| 172.31.255.27 | 65103 | default | - | Inherited from peer group IPv4-UNDERLAY-PEERS | Inherited from peer group IPv4-UNDERLAY-PEERS | - | - |
| 172.31.255.31 | 65103 | default | - | Inherited from peer group IPv4-UNDERLAY-PEERS | Inherited from peer group IPv4-UNDERLAY-PEERS | - | - |
| 192.168.1.5 | 65101 | default | - | Inherited from peer group EVPN-OVERLAY-PEERS | Inherited from peer group EVPN-OVERLAY-PEERS | - | Inherited from peer group EVPN-OVERLAY-PEERS |
| 192.168.1.6 | 65101 | default | - | Inherited from peer group EVPN-OVERLAY-PEERS | Inherited from peer group EVPN-OVERLAY-PEERS | - | Inherited from peer group EVPN-OVERLAY-PEERS |
| 192.168.1.7 | 65102 | default | - | Inherited from peer group EVPN-OVERLAY-PEERS | Inherited from peer group EVPN-OVERLAY-PEERS | - | Inherited from peer group EVPN-OVERLAY-PEERS |
| 192.168.1.8 | 65102 | default | - | Inherited from peer group EVPN-OVERLAY-PEERS | Inherited from peer group EVPN-OVERLAY-PEERS | - | Inherited from peer group EVPN-OVERLAY-PEERS |
| 192.168.1.9 | 65103 | default | - | Inherited from peer group EVPN-OVERLAY-PEERS | Inherited from peer group EVPN-OVERLAY-PEERS | - | Inherited from peer group EVPN-OVERLAY-PEERS |
| 192.168.1.10 | 65103 | default | - | Inherited from peer group EVPN-OVERLAY-PEERS | Inherited from peer group EVPN-OVERLAY-PEERS | - | Inherited from peer group EVPN-OVERLAY-PEERS |

### Router BGP EVPN Address Family

#### EVPN Peer Groups

| Peer Group | Activate |
| ---------- | -------- |
| EVPN-OVERLAY-PEERS | True |

### Router BGP Device Configuration

```eos
!
router bgp 65001
   router-id 192.168.1.2
   no bgp default ipv4-unicast
   distance bgp 20 200 200
   graceful-restart restart-time 300
   graceful-restart
   maximum-paths 4 ecmp 4
   neighbor EVPN-OVERLAY-PEERS peer group
   neighbor EVPN-OVERLAY-PEERS next-hop-unchanged
   neighbor EVPN-OVERLAY-PEERS update-source Loopback0
   neighbor EVPN-OVERLAY-PEERS bfd
   neighbor EVPN-OVERLAY-PEERS ebgp-multihop 3
   neighbor EVPN-OVERLAY-PEERS send-community
   neighbor EVPN-OVERLAY-PEERS maximum-routes 0
   neighbor IPv4-UNDERLAY-PEERS peer group
   neighbor IPv4-UNDERLAY-PEERS send-community
   neighbor IPv4-UNDERLAY-PEERS maximum-routes 12000
   neighbor 172.31.255.11 peer group IPv4-UNDERLAY-PEERS
   neighbor 172.31.255.11 remote-as 65101
   neighbor 172.31.255.11 description switch03_ethernet2
   neighbor 172.31.255.15 peer group IPv4-UNDERLAY-PEERS
   neighbor 172.31.255.15 remote-as 65101
   neighbor 172.31.255.15 description switch04_ethernet2
   neighbor 172.31.255.19 peer group IPv4-UNDERLAY-PEERS
   neighbor 172.31.255.19 remote-as 65102
   neighbor 172.31.255.19 description switch05_ethernet2
   neighbor 172.31.255.23 peer group IPv4-UNDERLAY-PEERS
   neighbor 172.31.255.23 remote-as 65102
   neighbor 172.31.255.23 description switch06_ethernet2
   neighbor 172.31.255.27 peer group IPv4-UNDERLAY-PEERS
   neighbor 172.31.255.27 remote-as 65103
   neighbor 172.31.255.27 description switch07_ethernet2
   neighbor 172.31.255.31 peer group IPv4-UNDERLAY-PEERS
   neighbor 172.31.255.31 remote-as 65103
   neighbor 172.31.255.31 description switch08_ethernet2
   neighbor 192.168.1.5 peer group EVPN-OVERLAY-PEERS
   neighbor 192.168.1.5 remote-as 65101
   neighbor 192.168.1.5 description switch03
   neighbor 192.168.1.6 peer group EVPN-OVERLAY-PEERS
   neighbor 192.168.1.6 remote-as 65101
   neighbor 192.168.1.6 description switch04
   neighbor 192.168.1.7 peer group EVPN-OVERLAY-PEERS
   neighbor 192.168.1.7 remote-as 65102
   neighbor 192.168.1.7 description switch05
   neighbor 192.168.1.8 peer group EVPN-OVERLAY-PEERS
   neighbor 192.168.1.8 remote-as 65102
   neighbor 192.168.1.8 description switch06
   neighbor 192.168.1.9 peer group EVPN-OVERLAY-PEERS
   neighbor 192.168.1.9 remote-as 65103
   neighbor 192.168.1.9 description switch07
   neighbor 192.168.1.10 peer group EVPN-OVERLAY-PEERS
   neighbor 192.168.1.10 remote-as 65103
   neighbor 192.168.1.10 description switch08
   redistribute connected route-map RM-CONN-2-BGP
   !
   address-family evpn
      neighbor EVPN-OVERLAY-PEERS activate
   !
   address-family ipv4
      no neighbor EVPN-OVERLAY-PEERS activate
      neighbor IPv4-UNDERLAY-PEERS activate
```

# BFD

## Router BFD

### Router BFD Multihop Summary

| Interval | Minimum RX | Multiplier |
| -------- | ---------- | ---------- |
| 1200 | 1200 | 3 |

### Router BFD Device Configuration

```eos
!
router bfd
   multihop interval 1200 min-rx 1200 multiplier 3
```

# Multicast

# Filters

## Prefix-lists

### Prefix-lists Summary

#### PL-LOOPBACKS-EVPN-OVERLAY

| Sequence | Action |
| -------- | ------ |
| 10 | permit 192.168.1.0/24 eq 32 |

### Prefix-lists Device Configuration

```eos
!
ip prefix-list PL-LOOPBACKS-EVPN-OVERLAY
   seq 10 permit 192.168.1.0/24 eq 32
```

## Route-maps

### Route-maps Summary

#### RM-CONN-2-BGP

| Sequence | Type | Match and/or Set |
| -------- | ---- | ---------------- |
| 10 | permit | match ip address prefix-list PL-LOOPBACKS-EVPN-OVERLAY |

### Route-maps Device Configuration

```eos
!
route-map RM-CONN-2-BGP permit 10
   match ip address prefix-list PL-LOOPBACKS-EVPN-OVERLAY
```

# ACL

# VRF Instances

## VRF Instances Summary

| VRF Name | IP Routing |
| -------- | ---------- |
| MGMT | disabled |

## VRF Instances Device Configuration

```eos
!
vrf instance MGMT
```

# Quality Of Service
