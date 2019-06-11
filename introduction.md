# OCPI

## OCPI 2.1.1

During implementation of OCPI 2.1, a number of bugs in the message definition were found.
This forced us to release a bug fix: OCPI 2.1.1. 
With the release of OCPI 2.1.1: OCPI 2.1 is deprecated, 2.1 should no longer used and replaced by 2.1.1.
It should be a small effort to upgrade an existing 2.1 implementation to 2.1.1. 

For more information on message level changes see [changelog](changelog.md#changelog).

### OCPI 2.1.1-d2

The original documentation of OCPI 2.1.1 contained some unclarities in the [command module](mod_command.md#commands-module).
This resulted in incompatible implementations of the OCPI 2.1.1 [command module](mod_command.md#commands-module). 
This updated documentation should clarify the usage of commands and prevent incompatibilities. 

Note that although the protocol version remains 2.1.1, this update might translate into a breaking change for some existing implementations, albeit a very minor one. 

This new documentation of OCPI 2.1.1 also contains 
a lot of minor fixes to JSON examples texts that have been contributed by the OCPI community.
Many thanks to all that have taken the time and effort to commit issues. 
 
For more details see: changes see [changelog](changelog.md#changelog).


## Introduction and background
The Open Charge Point Interface (OCPI) enables a scalable, automated EV roaming setup between Charge Point Operators and e-Mobility Service Providers. It supports authorization, charge point information exchange (including live status updates and transaction events), charge detail record exchange, remote charge point commands and, finally, the exchange of smart-charging commands between parties.

It offers market participants in EV an attractive and scalable solution for (international) roaming between networks, avoiding the costs and innovation-limiting complexities involved with today's non-automated solutions or with central roaming hubs.
As such it helps to enable EV drivers to charge everywhere in a fully-informed way, helps the market to develop quickly and helps market players to execute their business models in the best way.

What does it offer (main functionalities):
* A good roaming system (for bilateral usage and/or via a hub).
* Real-time information about location, availability and price.
* A uniform way of exchanging data (Notification Data Records and Charge Data Records), before during and after the transaction.
* Remote mobile support to access any charge station without pre-registration.

Starting in 2009, e-laad foundation and the predecessor of the eViolin association specified 2 standards in order to retrieve charge point details and active state. These are called the VAS interface and the Amsterdam interface. In this same period, a CDR format for the exchange of charge sessions between eViolin members was defined. This format is currently in use by the majority of the eViolin members. (eViolin is the branch organisation for EV operators and service providers in NL and responsible for national roaming and issuing of ID’s). This resulted in 2014 in the development of OCPI.

An international group of companies already supports OCPI. Initiators are EV Box, The New Motion, ElaadNL, BeCharged, Greenflux and Last Mile Solutions. Other participants include Next Charge, Freshmile, Plugsurfing, Charge-partner, Hubject, e-clearing.net, IHomer and Siemens. Several other major organizations and roaming platforms are interested in participating. The Netherlands Knowledge Platform for Charging Infrastructure (NKL) facilitates and coordinates this project to guarantee progress and ensure development and results. Part of this project is to find a place to continue development in the future.

This document describes a combined set of standards based on the work done in the past. Next to that, the evolution of these standards and their use is taken into account and some elements have been updated to match nowadays use.

The latest version of this specification can be found here: https://github.com/ocpi/ocpi
