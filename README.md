WayFinder
=============

A fun app to help you explore the ease of use of ContextHub and the power of iBeacons!

## Purpose

Finding your way around indoors can be difficult.  With the introduction of iBeacons, Apple has made wayfinding solutions much easier to build.  In this sample application, we used ContextHub to implement a Wayfinding app that leads our customers around the office.

## ContextHub

ContextHub takes care of iBeacon monitoring and ranging which lets you focus on building your application.  We added the Beacon UUID on ContextHub and created a couple context rules. The SDK takes care of the rest.  It notifies the application when it enters a beacon region.  In addition, it posts notifications as the device moves closer further from the iBeacons.

ContextHub enabled us to focus on building the view controllers and business logic.  We didn't have to worry about location mangaers, delegates, region monitoring, and beacon ranging.

## Setup

Setting up WayFinder with iBeacons is easy. iOS devices with iOS 7 and Bluetooth 4.0 can be turned into beacons using apps like [Locate for iBeacon](https://itunes.apple.com/us/app/locate-for-ibeacon/id738709014?mt=8), or you can purchase beacons from a variety of vendors across the web. This demo was tested against KS Technologies [Particle Beacon](http://www.kstechnologies.com/products/particle).

Depending on whether you have physical beacons ready to be programmed or using your phone, you need to know about the information which each beacon stores:

Beacons have 4 important information fields that need to be programmed: UUID, major, minor, and name.
- UUID (Universally unique identifier): UUID is a 32-character hexadecimal id when used with iBeacon is typically set to be the same as a certain type or from a certain organization. For example, all iBeacons placed at a particular store location of your business would have the same UUID. UUIDs have a specific format and must be [generated](http://www.uuidgenerator.net).
- Major: This number identifies a group of beacons at a particular location. For example, all beacons on the 2nd floor or specific department of a particular location (with the same UUID) would have the same major value.
- Minor: This number uniquely identifies a specific beacon within a group of beacons with the same major value. For example, a beacon located next to the lobby would have a different minor value from a nearby elevator. Every beacon should have a unique combination of UUID, major, and minor value to distinguish between then. 
- Name: Beacons are given human-readable names to easily distinguish between them. Names are not required to be unique (as uniqueness is determined by the UUID, major and minor value) however they are not allowed to have spaces.

To use the WayFinder app out of the box, prepare 3 beacons with the following information using eithe real beacons or Locate for iBeacon:

*  UUID: B9407F30-F5F8-466E-AFF9-25556B57FE6D
- Major: 100
- Minor: 1
- Name: LOBBY
*  UUID: B9407F30-F5F8-466E-AFF9-25556B57FE6D
- Major: 100
- Minor: 2
- Name: IDEAWALL
*  UUID: B9407F30-F5F8-466E-AFF9-25556B57FE6D
- Major: 100
- Minor: 3
- Name: TEAMROOM


### Demo

Launch and run the app from your device (beacons do not work with the iOS Simulator). Here's how it works:

1. The app will wait until it detects any beacons are in range to display the welcome screen. 
2. The app will wait until it detects the first "LOBBY" beacon specifically in close range (~1-2 ft) before showing the "Start Tour" button.
3. The user should tap the "Start Tour" button to advance to a map of the next location.
4. The app should respond to the close proximity of the 2nd "IDEAWALL" beacon and advance automatically as if you were walking around our actual office.
5. The user again should tap the "Next Stop" button to advance to a map of the next location.
6. The app should respond to the close proximity of the 3rd "TEAMROOM" beacon and again advance automatically with info about the TEAM ROOM.
7. The user then finishes the tour and the app shows a screen with the number of times the tour has been completed.


### Code

WayFinder is an example of an app that demonstrates the use of iBeacons through the power of ContextHub and a few lines of code. To add this functionality to your own projects, follow the instructions below:

1. First make sure you sign up with [ContextHub](www.contexthub.com) and get an app id. This app id binds all activities with ContextHub to your specific project.
2. Then create a beacon with the following UUID `B9407F30-F5F8-466E-AFF9-25556B57FE6D`. Leave the major and minor values blank so you receive messages from any beacon with that UUID.
2. In your `application:didFinishLaunchingWithOptions:` method, register your app ID `[ContextHub registerWithAppId:@"YOUR-APP-ID-HERE"]`
3. Define a method called `- (void)handleEvent:(NSNotification *)notification` which will process these notifications.
4. Within that `handleEvent:` method, create a CCHBeacon object for the beacon you are interested in `CCHBeacon *interestingBeacon = CCHBeacon initWithData:@{@"name": @"LOBBY", @"uuid": "B9407F30-F5F8-466E-AFF9-25556B57FE6D", @"major":@"100", @"minor":1 }` then compare it with the notification that was just sent and the proximity you are looking for `BOOL beaconIsNear = [interestingBeacon isSameBeaconFromNotification:notification inProximity:kBeaconProximityNear]`.
5. Start listening for notifications by calling `[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleEvent:) name:CCHContextEventManagerDidPostEvent object:nil];`
6. Then remember to call `[[NSNotificationCenter defaultCenter]removeObserver:self];` to stop receiving notifications about beacon events.

That's it!


Note: Current demo is set up such that a response from a beacon is triggered when it is either "near" the device (6-12 inches) or "immediate" to the device (within 6 inches). It takes approximately 2-3 seconds to notice a transition in state from far (within 50 ft) to other states (near or immediate).
