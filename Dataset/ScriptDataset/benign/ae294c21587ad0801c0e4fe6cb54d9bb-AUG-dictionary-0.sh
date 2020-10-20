# -*- text -*-
# Copyright (C) 2011 The FreeRADIUS Server project and contributors
#
# Shiva dictionary.
#
#	Shiva Inc.
#	http://www.shiva.com/
#
#	For more information on magic values for Shiva-User-Attributes,
#	see their web page, at:
#
#	http://www.shiva.com/prod/kbase/mapping.html
#
#	Enable by putting the line "$INCLUDE dictionary.shiva" into
#	the main dictionary file.
#
# Version:	1.00  27-Apr-1999  contributed by Alan DeKok
#		$Id: e12ca33fcc56e4febd1f6f090a978a6abf02eaff $
#

VENDOR		Shiva				166

#	Shiva Extensions

#
#	This next attribute is Shiva's attempt to create their own
#	VSA in the main dictionary.  Don't use it.  It's a bad idea.
#
#ATTRIBUTE	Shiva-User-Attributes		51	string

BEGIN-VENDOR	Shiva

ATTRIBUTE	Shiva-User-Attributes			1	string
ATTRIBUTE	Shiva-Compression			30	integer
ATTRIBUTE	Shiva-Dialback-Delay			31	integer
ATTRIBUTE	Shiva-Call-Durn-Trap			32	integer
ATTRIBUTE	Shiva-Bandwidth-Trap			33	integer
ATTRIBUTE	Shiva-Minimum-Call			34	integer
ATTRIBUTE	Shiva-Default-Host			35	string
ATTRIBUTE	Shiva-Menu-Name				36	string
ATTRIBUTE	Shiva-User-Flags			37	string
ATTRIBUTE	Shiva-Termtype				38	string
ATTRIBUTE	Shiva-Break-Key				39	string
ATTRIBUTE	Shiva-Fwd-Key				40	string
ATTRIBUTE	Shiva-Bak-Key				41	string
ATTRIBUTE	Shiva-Dial-Timeout			42	integer
ATTRIBUTE	Shiva-LAT-Port				43	string
ATTRIBUTE	Shiva-Max-VCs				44	integer
ATTRIBUTE	Shiva-DHCP-Leasetime			45	integer
ATTRIBUTE	Shiva-LAT-Groups			46	string
ATTRIBUTE	Shiva-RTC-Timestamp			60	integer
ATTRIBUTE	Shiva-Circuit-Type			61	integer
ATTRIBUTE	Shiva-Called-Number			90	string
ATTRIBUTE	Shiva-Calling-Number			91	string
ATTRIBUTE	Shiva-Customer-Id			92	string
ATTRIBUTE	Shiva-Type-Of-Service			93	integer
ATTRIBUTE	Shiva-Link-Speed			94	integer
ATTRIBUTE	Shiva-Links-In-Bundle			95	integer
ATTRIBUTE	Shiva-Compression-Type			96	integer
ATTRIBUTE	Shiva-Link-Protocol			97	integer
ATTRIBUTE	Shiva-Network-Protocols			98	integer
ATTRIBUTE	Shiva-Session-Id			99	integer
ATTRIBUTE	Shiva-Disconnect-Reason			100	integer
ATTRIBUTE	Shiva-Acct-Serv-Switch			101	ipaddr
ATTRIBUTE	Shiva-Event-Flags			102	integer
ATTRIBUTE	Shiva-Function				103	integer
ATTRIBUTE	Shiva-Connect-Reason			104	integer

VALUE	Shiva-Compression		None			0
VALUE	Shiva-Compression		Negotiate		1
VALUE	Shiva-Compression		Spider			2
VALUE	Shiva-Compression		Predictor		3
VALUE	Shiva-Compression		STAC			4

VALUE	Shiva-Circuit-Type		Primary			1
VALUE	Shiva-Circuit-Type		Secondary-Backup	2
VALUE	Shiva-Circuit-Type		Secondary-Augment	3
VALUE	Shiva-Circuit-Type		Secondary-Switch	4
VALUE	Shiva-Circuit-Type		Listener		5
VALUE	Shiva-Circuit-Type		RADIUS			6

#	Shiva Type Of Service Values

VALUE	Shiva-Type-Of-Service		Analog			1
VALUE	Shiva-Type-Of-Service		Digitized-Analog	2
VALUE	Shiva-Type-Of-Service		Digital			3
VALUE	Shiva-Type-Of-Service		Digital-V110		4
VALUE	Shiva-Type-Of-Service		Digital-V120		5
VALUE	Shiva-Type-Of-Service		Digital-Leased-Line	6

#	Shiva Link Protocol Values

VALUE	Shiva-Link-Protocol		HDLC			1
VALUE	Shiva-Link-Protocol		ARAV1			2
VALUE	Shiva-Link-Protocol		ARAV2			3
VALUE	Shiva-Link-Protocol		SHELL			4
VALUE	Shiva-Link-Protocol		AALAP			5
VALUE	Shiva-Link-Protocol		SLIP			6

#	Shiva Connect Reason Values

VALUE	Shiva-Connect-Reason		Remote			1
VALUE	Shiva-Connect-Reason		Dialback		2
VALUE	Shiva-Connect-Reason		Virtual-Connection	3
VALUE	Shiva-Connect-Reason		Bandwidth-On-Demand	4

#	Shiva Disconnect Reason Values

VALUE	Shiva-Disconnect-Reason		Remote			1
VALUE	Shiva-Disconnect-Reason		Error			2
VALUE	Shiva-Disconnect-Reason		Idle-Timeout		3
VALUE	Shiva-Disconnect-Reason		Session-Timeout		4
VALUE	Shiva-Disconnect-Reason		Admin-Disconnect	5
VALUE	Shiva-Disconnect-Reason		Dialback		6
VALUE	Shiva-Disconnect-Reason		Virtual-Connection	7
VALUE	Shiva-Disconnect-Reason		Bandwidth-On-Demand	8
VALUE	Shiva-Disconnect-Reason		Failed-Authentication	9
VALUE	Shiva-Disconnect-Reason		Preempted		10
VALUE	Shiva-Disconnect-Reason		Blocked			11
VALUE	Shiva-Disconnect-Reason		Tariff-Management	12
VALUE	Shiva-Disconnect-Reason		Backup			13

#	Shiva Function Values

VALUE	Shiva-Function			Unknown			0
VALUE	Shiva-Function			Dialin			1
VALUE	Shiva-Function			Dialout			2
VALUE	Shiva-Function			Lan-To-Lan		3

END-VENDOR	Shiva
