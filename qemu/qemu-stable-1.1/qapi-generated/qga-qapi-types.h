/* AUTOMATICALLY GENERATED, DO NOT MODIFY */

/*
 * schema-defined QAPI types
 *
 * Copyright IBM, Corp. 2011
 *
 * Authors:
 *  Anthony Liguori   <aliguori@us.ibm.com>
 *
 * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
 * See the COPYING.LIB file in the top-level directory.
 *
 */

#ifndef QGA_QAPI_TYPES_H
#define QGA_QAPI_TYPES_H

#include "qapi/qapi-types-core.h"

typedef struct GuestAgentCommandInfo GuestAgentCommandInfo;

typedef struct GuestAgentCommandInfoList
{
    GuestAgentCommandInfo *value;
    struct GuestAgentCommandInfoList *next;
} GuestAgentCommandInfoList;

typedef struct GuestAgentInfo GuestAgentInfo;

typedef struct GuestAgentInfoList
{
    GuestAgentInfo *value;
    struct GuestAgentInfoList *next;
} GuestAgentInfoList;

typedef struct GuestFileRead GuestFileRead;

typedef struct GuestFileReadList
{
    GuestFileRead *value;
    struct GuestFileReadList *next;
} GuestFileReadList;

typedef struct GuestFileWrite GuestFileWrite;

typedef struct GuestFileWriteList
{
    GuestFileWrite *value;
    struct GuestFileWriteList *next;
} GuestFileWriteList;

typedef struct GuestFileSeek GuestFileSeek;

typedef struct GuestFileSeekList
{
    GuestFileSeek *value;
    struct GuestFileSeekList *next;
} GuestFileSeekList;

extern const char *GuestFsfreezeStatus_lookup[];
typedef enum GuestFsfreezeStatus
{
    GUEST_FSFREEZE_STATUS_THAWED = 0,
    GUEST_FSFREEZE_STATUS_FROZEN = 1,
    GUEST_FSFREEZE_STATUS_MAX = 2,
} GuestFsfreezeStatus;

extern const char *GuestIpAddressType_lookup[];
typedef enum GuestIpAddressType
{
    GUEST_IP_ADDRESS_TYPE_IPV4 = 0,
    GUEST_IP_ADDRESS_TYPE_IPV6 = 1,
    GUEST_IP_ADDRESS_TYPE_MAX = 2,
} GuestIpAddressType;

typedef struct GuestIpAddress GuestIpAddress;

typedef struct GuestIpAddressList
{
    GuestIpAddress *value;
    struct GuestIpAddressList *next;
} GuestIpAddressList;

typedef struct GuestNetworkInterface GuestNetworkInterface;

typedef struct GuestNetworkInterfaceList
{
    GuestNetworkInterface *value;
    struct GuestNetworkInterfaceList *next;
} GuestNetworkInterfaceList;

struct GuestAgentCommandInfo
{
    char * name;
    bool enabled;
};

void qapi_free_GuestAgentCommandInfoList(GuestAgentCommandInfoList * obj);
void qapi_free_GuestAgentCommandInfo(GuestAgentCommandInfo * obj);

struct GuestAgentInfo
{
    char * version;
    GuestAgentCommandInfoList * supported_commands;
};

void qapi_free_GuestAgentInfoList(GuestAgentInfoList * obj);
void qapi_free_GuestAgentInfo(GuestAgentInfo * obj);

struct GuestFileRead
{
    int64_t count;
    char * buf_b64;
    bool eof;
};

void qapi_free_GuestFileReadList(GuestFileReadList * obj);
void qapi_free_GuestFileRead(GuestFileRead * obj);

struct GuestFileWrite
{
    int64_t count;
    bool eof;
};

void qapi_free_GuestFileWriteList(GuestFileWriteList * obj);
void qapi_free_GuestFileWrite(GuestFileWrite * obj);

struct GuestFileSeek
{
    int64_t position;
    bool eof;
};

void qapi_free_GuestFileSeekList(GuestFileSeekList * obj);
void qapi_free_GuestFileSeek(GuestFileSeek * obj);

struct GuestIpAddress
{
    char * ip_address;
    GuestIpAddressType ip_address_type;
    int64_t prefix;
};

void qapi_free_GuestIpAddressList(GuestIpAddressList * obj);
void qapi_free_GuestIpAddress(GuestIpAddress * obj);

struct GuestNetworkInterface
{
    char * name;
    bool has_hardware_address;
    char * hardware_address;
    bool has_ip_addresses;
    GuestIpAddressList * ip_addresses;
};

void qapi_free_GuestNetworkInterfaceList(GuestNetworkInterfaceList * obj);
void qapi_free_GuestNetworkInterface(GuestNetworkInterface * obj);

#endif
