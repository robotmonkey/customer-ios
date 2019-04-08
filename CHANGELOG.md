# Changelog for Kustomer iOS SDK

## 0.1.39

Release Date: 04/05/2019

* Minor refactoring. 

## 0.1.38

Release Date: 03/28/2019

* Protect data to ensure HIPAA compliance
* Added numbers option support in option list
* Handle the message body text after inline image
* Update chat setting test cases

## 0.1.37

Release Date: 03/13/2019

* Silent a crash in image picker

## 0.1.36

Release Date: 03/08/2019

* Keeping conversational assistant form state when exiting away from the chat sdk
* Hide attachment icon on volume control input prompts
* Allowed chat messages with only attachments, message body not required 
* Update Romanian translation for 'Chat Has Ended'

## 0.1.35

Release Date: 02/21/2019

* Fixed the multiple business hours issue

## 0.1.34

Release Date: 02/17/2019

* Updated NYTPhotoViewer library dependency to 2.0.0
* Updated Pusher connection logic to maximum rely on pusher and removed the unnecessary API calls
* Fixed the input field issue in case of non-business hours and chat is temporarily closed and message received from the agent

## 0.1.33

* Fixed the pod issue

## 0.1.32

* Added a callback handler for identify method
* Fixed pusher logic

## 0.1.31

* Added `presentSupportWithMessage` functionality
* Fixed the background music stop issue

## 0.1.30

* Added option values support in form messaging
* Added 'Twi' language support
* Updated End Chat button translation in various languages

## 0.1.29

* Fixed upfront volume control polling issue
* Update upfront volume control display message
* Added localization support for volume control and upfront volume control forms

## 0.1.28

* Fixed pusher logic
* Fixed 'End Chat' button translation in Spanish

## 0.1.27

* Added 'swahili' language support
* Updated documentation

## 0.1.26

* Added upfront volume control tracking support

## 0.1.25

* Added hide new conversation button in closed chat listing

## 0.1.24

* Added multi-level form messaging support

## 0.1.23

* Added business hours feature

## 0.1.22

* Added un-localized strings
* Fixed describe next conversation issue with forms

## 0.1.21

* Added new method to describe next conversation
* Fixed conversation team issue

## 0.1.20

* Added new method to get open conversations count

## 0.1.19

* Fixed Kustomer controller presentation style

## 0.1.18

* Fixed polling logic

## 0.1.17

* Fixed framework dependency issue for carthage

## 0.1.16

* Fixed scope of header files

## 0.1.15

* Fixed carthage issue

## 0.1.14

* Added no history feature

## 0.1.13

* Removed autoreply logic
* Fixed back to chat issue

## 0.1.12

* Added single chat functionality

## 0.1.11

* Added end chat functionality
* Added custom form selection mechanism

## 0.1.10

* Fixed Localization files issue

## 0.1.9

* Added Localization features to support devices of different languages.
* Added support for chat volume control features. 


## 0.1.8

* Added async method `isChatAvailable` for getting the current online/offline state of your chat settings
* fixed bug where the chat assistant would prompt customer for email even though already being passed via customer `[Kustomer describeCustomer]`

## 0.1.7
* Fixed bug where conversational forms would crash if a question asked for a response but did not set a property

## 0.1.6

* Created a new method to present specific web page interface using the
* following format: [Kustomer presentCustomWebPage:@"url"];

## 0.1.5

* Fix in-app notification window layout issue on iPhone X.

## 0.1.4

* Exposed the current count of unread messages via `+[Kustomer unreadMessageCount]`.
* Changed initial screen behavior to open directly to the most recent chat when there are multiple chats for the user.

## 0.1.3

* Fixed a bug that would prevent time-based conversational campaigns from properly triggering.
* Mitigated a race condition that would cause campaign messages to be received with a large delay.

## 0.1.2

* Added support for tracking current page names; support conversational campaigns.
* Fixed retain cycle due to `NSTimer`.
* Improved tolerance settings on `NSTimer` to improve system performance.
* Fixed crash due to conversational forms with a no response values.
* Fixed conversational forms only working on first conversation per app launch.

## 0.1.1

* Added support for transparent gravatar images to match web SDK behavior.
* Improved socket connection behavior for new users.
* Made Kustomer `User-Agent` header reflect that of the container app.

## 0.1.0

* Significantly improved retry logic for failed message sends.
* Improved debug logging for network requests.
* Added support for displaying multiple avatars in chat headers.
* Reduced the main thread usage of paginated datasources to improve performance.
* Added unread count badge to the back button when in a chat.
