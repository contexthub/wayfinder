Wayfinder
=============

A fun app to help you explore the ChaiONE office and win prizes!!

## Purpose

Finding your way around indoors can be difficult.  With the introduction of iBeacons, Apple has made wayfinding solutions much easier to build.  In this sample application, we used ContextHub to implement a Wayfinding app that leades our customer around the office.

## ContextHub

ContextHub takes care of iBeacon monitoring and ranging which lets you focus on building your application.  We added the Beacon UUID on ContextHub and created a couple context rules. The SDK takes care of the rest.  It notifies the application when it enters a beacon region.  In addition, it posts notifications as the device moves closer further from the iBeacons.

ContextHub enabled us to focus on building the view controllers and business logic.  We didn't have to worry about location mangaers, delegates, region monitoring, and beacon ranging.
