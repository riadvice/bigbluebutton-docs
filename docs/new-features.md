---
layout: page
title: "What's New"
category: 2.6
date: 2021-06-09 11:42:28
order: 1
---

<p align="center">
  <img src="/images/26_BBB_header.png" alt="BigBlueButton 2.6 runs on Ubuntu 20.04"/>
</p><br/>

# Overview

This document gives you an overview of BigBlueButton 2.6, the latest version of BigBlueButton now in development.

*Note:* This document is DRAFT and will be expanded upon as 2.6 development goes through alpha, beta, and release.

BigBlueButton 2.6 offers users improved usability, increased engagement, and more performance.

- **Usability** - making common functions (such as raise hand) easier
- **Engagement** - giving the instructor more ways to engage students
- **Performance** - increasing overall performance and scalability

Here's a breakdown of what's new in 2.6.

## Usability

### Dark theme

BigBlueButton supports dark theme. To enable it just navigate to the Settings.

<img src="/images/26-dark-theme-setting.png" alt="The toggle for dark theme is located in the main settings panel" style="max-width: 60%; height: auto;"/>
<br /><br />

<img src="/images/26-dark-theme-in-action.png" alt="Dark theme in action - typically pale elements like the participants list are displayed in dark palette" style="max-width: 60%; height: auto;"/>
<br /><br />

### Improved Echo Test dialog
The echo test modal has added a new audio stream volume indicator in place of the
separate confirmation screen. This reduced the number of views and interactions required for audio confirmation.
<img src="/images/26-echo-test.png" alt="Updated echo test modal with added " style="max-width: 60%; height: auto;"/>

### Improved notification of recording start

The indicator for whether the recording is on has been made bigger. Additionally if you create your meeting with an optional parameter `notifyRecordingIsOn=true`, you users will see the following dialog when the recording commenses and also when joining a session that is already actively being recorded. You can choose to either continue or leave the session.

<img src="/images/26-recording-indicator.png" alt="A big red square used as a recording indicator, used to be more subtle" style="max-width: 60%; height: auto;"/>
<br /><br />

<img src="/images/26-recording-popup.png" alt="A blocking dialog shows up if the session is being recorded" style="max-width: 60%; height: auto;"/>
<br /><br />

### Allow pinning of more than one webcam

The pinning feature prevents the webcams from being rotated out when audio floor switching is activated.
This functionality is specially important for document and/or interpreter cameras. It has also been improved
to support miltiple pinned cameras.

<img src="/images/26-cam-pin.gif" alt="Animation selecting webcam dropdown menu and pin option item" style="max-width: 60%; height: auto;"/>

### Upload your own webcam background

This new feature allows a user to upload virtual background image's for their webcam. The user can upload
and delete images at will.

<img src="/images/26-bg-upload.gif" alt="Animation of user uploading webcam custom background image" style="max-width: 60%; height: auto;"/>

### Set webcam image brightness

Allows the ability to adjust the brightness levels of their webcam (or) webcam and background image.

This is done via the webcam settings modal using the brightness slider at the bottom.

<img src="/images/26-webcam-brightness.gif" alt="Animation of webcam brightness slider interaction" style="max-width: 60%; height: auto;"/>

### Improved layouts manager selection

Layout selection can now be done via the updated layout selection modal located in the actions (+) button.

<img src="/images/26layout-selection.gif" alt="Animation selecting actions button and layout selection item" style="max-width: 60%; height: auto;"/>

### Live Automatic Closed Captions

Note: The automatic transcription is only available for browsers that support SpeechRecognition (Google Chrome, MS Edge and Safari). So those who join a meeting using other browsers will see a warning in the audio modal.

<img src="/images/26-no-voice-rec.png" alt="audio modal with speech recognition error" style="max-width: 60%; height: auto;"/>

By default, automatic transcription language selector is disabled. This can be changed in the settings file.  Users who want to have their voices transcribed must enable it by selecting the desired language from the drop-down selector in the join audio dialog.

<img src="/images/26-auto-transcription.png" alt="audio modal with automatic transcription dropdown" style="max-width: 60%; height: auto;"/>

When the user selects a language for automatic transcription, BigBlueButton will display a CC icon next to their name in the "who is talking" indicator.

<img src="/images/26-cc-talking-indicator.png" alt="Talking indicator with closed caption icon" style="max-width: 60%; height: auto;"/>

When one or more users have enabled transcription, BigBlueButton will display a 'CC' button to display the transcriptions. You don't need to have selected transcription of your audio to view the transcriptions for others.

To view the transcriptions for those with 'CC' in their "who is talking" icon, select the CC button.

The placement of the 'CC' button depends on your device.  For desktop, the 'CC' button is in the bottom left.


  <img src="/images/26-cc-desktop-btn.png" alt="closed captions button on action bar" style="max-width: 60%; height: auto;"/>

For mobile devices, The 'CC' button is in the three dots at the top right corner.

  <img src="/images/26-cc-mobile-btn.png" alt="closed captions button on mobile in app options menu" style="max-width: 60%; height: auto;"/>

To enable the option for automatic translations for users of Google Chrome, Microsoft Edge, and Safari, edit the `/etc/bigbluebutton/bbb-html5.yml` and add the following to the `public:` section and restart BigBlueButton.

```
public:
  app:
    audioCaptions:
      enabled: true
```

### Downloading presentation with whiteboard annotations included

Teachers can now export their slide decks with the annotations added during a lesson.
Selecting "Send to chat" in the presentation upload modal sends a link in the public chat from which meeting participants can download the file.

<img src="/images/26-send-to-chat.png" alt="BigBlueButton's upload modal with a button to export the presentation with annotations" style="max-width: auto; height: auto;"/>

### Upload a presentation straight from NextCloud

Two new create parameters: uploadExternalDescription and uploadExternalUrl have been introduced.

The client supports these parameters, displaying a message in the presentation upload modal when both values are set at meeting creation.

<img src="/images/26-next-cloud.png" alt="Upload presentation modal with next cloud message" style="max-width: auto; height: auto;"/>

### Easier moving of users between breakout rooms

There is a new option for the breakout room controls called Manage users.

<img src="/images/26-manage-users.png" alt="Manage users" style="max-width: auto; height: auto;"/>

This dialog lets you drag-and-drop users between different breakout rooms.


<img src="/images/26-move-user.gif" alt="Move users dialog" style="max-width: auto; height: auto;"/>

When you click Apply, BigBlueButton well send prompts to each user to move them to the target breakout room.

<img src="/images/26-move-prompt.png" alt="Move users prompt" style="max-width: auto; height: auto;"/>

### Recording in MP4 format

This release will introduce a new recording format that creates a single video file from audio, video, screen share, presentation, and whiteboard marks recorded during the session.  The file format will be .vp8 (with configuration options to alternatively create an .mp4 file as well).

## Engagement

### Fully reimplemented whiteboard (tl;draw)

The whiteboard has been updated with TLdraw, a small application which supports improved drawing features.

For more details see <https://github.com/tldraw/tldraw>.

<img src="/images/26-tldraw.png" alt="BigBlueButton whiteboard using tldraw" style="max-width: auto; height: auto;"/>

### Exporting Shared notes to the whiteboard

Instructors can move the shared notes to the whiteboard presentation area for further collaborative work among students.

<img src="/images/26-shared-notes-import.png" alt="BigBlueButton's whiteboard with annotations, with imported shared notes as the presentation" style="max-width: auto; height: auto;"/>

### Exporting breakout rooms' shared notes as a presentation to the main room

### Exporting breakout rooms' whiteboard annotations to the main room

### Easier setup of polling

Polling has been updated to allow for polls when prepared in advance using the custom input option.

<img src="/images/26-custom-poll.gif" alt="Animation of user opening poll panel and toggle custom input" style="max-width: auto; height: auto;"/>

## Analytics


## Performance

### Recording API improvements

Allows for quicker, more efficient search and retrieval of recording data.

## Experimental


## Upgraded components

For full details on what is new in BigBlueButton 2.6, see the release notes. Recent releases:

- [beta.2](https://github.com/bigbluebutton/bigbluebutton/releases/tag/v2.6.0-beta.2)
- [beta.1](https://github.com/bigbluebutton/bigbluebutton/releases/tag/v2.6.0-beta.1)
- [alpha.4](https://github.com/bigbluebutton/bigbluebutton/releases/tag/v2.6.0-alpha.4)
- [alpha.3](https://github.com/bigbluebutton/bigbluebutton/releases/tag/v2.6.0-alpha.3)
- [alpha.2](https://github.com/bigbluebutton/bigbluebutton/releases/tag/v2.6.0-alpha.2)
- [alpha.1](https://github.com/bigbluebutton/bigbluebutton/releases/tag/v2.6.0-alpha.1)

## Other notable changes

### We have retired the `bbb-demo` API Demos development only package

We recommend using API MATE or Greenlight - see the [development setup section](/2.6/dev.html) for more information.

## Development

For information on developing in BigBlueButton, see [setting up a development environment for 2.6](/2.6/dev.html).

The build scripts for packaging 2.6 (using fpm) are located in the GitHub repository [here](https://github.com/bigbluebutton/bigbluebutton/tree/v2.6.x-release/build).

## Contribution

We welcome contributors to BigBlueButton 2.6!  The best ways to contribute at the current time are:

- Help localize BigBlueButton 2.6 on [Transifex project for BBB 2.6](https://www.transifex.com/bigbluebutton/bigbluebutton-v26-html5-client/dashboard/)

- Try out [installing BigBlueButton 2.6](/2.6/install.html) and see if you spot any issues.
- Help test a [2.6 pull request](https://github.com/bigbluebutton/bigbluebutton/pulls?q=is%3Aopen+is%3Apr+milestone%3A%22Release+2.6%22) in your development environment.
  <!-- TODO create a GitHub label for contributions-welcome and link here -->
