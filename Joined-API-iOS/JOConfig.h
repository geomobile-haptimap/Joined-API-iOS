//
//  JOConfig.h
//  Joined-API-iOS
//
//  Created by Bastian Baranski on 07.05.12.
//  Copyright (c) 2012 GeoMobile GmbH. All rights reserved.
//

#ifndef Joined_API_iOS_JOConfig_h
#define Joined_API_iOS_JOConfig_h

/**
 * The URL of the Joined server.
 */
#define JOINED_SERVER  @"http://joinedserver.geomobile.de:8011/friendfinder"

/**
 * The unqique identifier for the public Joined API.
 */
#define JOINED_API_KEY @"2234567890"

/* UNIT TEST */

/**
 * The name and password for the first user to be created during JUnit tests.
 */
#define TEST_USER_1 @"dummy-1"

/**
 * The name and password for the second user to be created during JUnit tests.
 */
#define TEST_USER_2 @"dummy-2"

/* STATUS CODES */

/**
 * This variable indicates that there is no friend relationship to another user ({@see Friend}).
 */
#define FRIEND_STATUS_NO = 0

/**
 * This variable indicates that there is an active friend relationship to another user ({@see Friend}).
 */
#define FRIEND_STATUS_YES = 1

/**
 * This variable indicates that there is a pending friend invitation for another user ({@see Friend}).
 */
#define FRIEND_STATUS_PENDING = 2

/* MESSAGES */

/**
 * This variable is not documented and for internal use only.
 */
#define TEXT_MSG @"text"

/**
 * This variable is not documented and for internal use only.
 */
#define MESSAGE_FROM = 0

/**
 * This variable is not documented and for internal use only.
 */
#define MESSAGE_TO = 1

/* RESOURCES */

/**
 * This variable is not documented and for internal use only.
 */
#define FF_REGISTER @"/ffregister"

/**
 * This variable is not documented and for internal use only.
 */
#define FF_LOGIN @"/fflogin"

/**
 * This variable is not documented and for internal use only.
 */
#define FF_FRIENDS @"/user"

/**
 * This variable is not documented and for internal use only.
 */
#define FF_MESSAGE @"/message"

/**
 * This variable is not documented and for internal use only.
 */
#define FRIENDS @"/friends"

/**
 * This variable is not documented and for internal use only.
 */
#define FRIEND @"/friend/"

/**
 * This variable is not documented and for internal use only.
 */
#define SEARCH @"/search/"

/**
 * This variable is not documented and for internal use only.
 */
#define IMAGE @"/image/"

/**
 * This variable is not documented and for internal use only.
 */
#define HASH @"?hash="

/* DOCUMENT ELEMENTS */

/**
 * This variable is not documented and for internal use only.
 */
#define NICKNAME @"nickname"

/**
 * This variable is not documented and for internal use only.
 */
#define PASSWORD @"password"

/**
 * This variable is not documented and for internal use only.
 */
#define REGISTRATION_ID @"registrationId"

/**
 * This variable is not documented and for internal use only.
 */
#define FB_ID @"fbId"

/**
 * This variable is not documented and for internal use only.
 */
#define SECURE_TOKEN @"secureToken"

/**
 * This variable is not documented and for internal use only.
 */
#define ID @"id"

/**
 * This variable is not documented and for internal use only.
 */
#define ATTACHMENT @"attachment"

/**
 * This variable is not documented and for internal use only.
 */
#define TITLE @"title"

/**
 * This variable is not documented and for internal use only.
 */
#define IMAGE_HASH @"imageHash"

/**
 * This variable is not documented and for internal use only.
 */
#define ACTIVE @"active"

/**
 * This variable is not documented and for internal use only.
 */
#define STATUS @"status"

/**
 * This variable is not documented and for internal use only.
 */
#define LAST_POS_UPDATE @"lastPosUpdate"

/**
 * This variable is not documented and for internal use only.
 */
#define LATITUDE @"latitude"

/**
 * This variable is not documented and for internal use only.
 */
#define LONGITUDE @"longitude"

/**
 * This variable is not documented and for internal use only.
 */
#define CREATION_DATE @"creationDate"

/**
 * This variable is not documented and for internal use only.
 */
#define SENDER_ID @"senderId"

/**
 * This variable is not documented and for internal use only.
 */
#define IMAGE_KEY @"image"

/**
 * This variable is not documented and for internal use only.
 */
#define IS_ACTIVE @"isActive"

/* CONSTANTS */

/**
 * This variable is not documented and for internal use only.
 */
#define UTF_8 @"UTF-8"

/**
 * This variable is not documented and for internal use only.
 */
#define TEXT @"text"

/**
 * This variable is not documented and for internal use only.
 */
#define TEXT_PLAIN @"text/plain"

/**
 * This variable is not documented and for internal use only.
 */
#define SHA_1 @"SHA-1"

/**
 * This variable is not documented and for internal use only.
 */
#define ISO_8859 @"iso-8859-1"

/**
 * This variable is not documented and for internal use only.
 */
#define MD5 @"MD5"

#endif
