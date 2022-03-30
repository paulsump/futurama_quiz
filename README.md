# Futurama Characters and Quiz

- Demonstration of basic Flutter UI of data fetched from a simple API.

| Fry  | Hypnotoad | Zapp |
| ------------- | ------------- | ------------- |
| <img src="https://github.com/paulsump/futurama_quiz/blob/5cb265aac059b56153f73e9c09201f0418134a24/images/fry.png" width="248"> | <img src="https://github.com/paulsump/futurama_quiz/blob/5cb265aac059b56153f73e9c09201f0418134a24/images/hypnotoad.png" width="248"> | <img src="https://github.com/paulsump/futurama_quiz/blob/5cb265aac059b56153f73e9c09201f0418134a24/images/zapp.png" width="248"> |

## How to build

- Open the project in Android Studio, connect an Android or iOS device, pub get, run.

## UI

This isn't supposed to be a serious, professional looking app!  
The animated image are deliberately silly, inspired by certain pulsating/throbbing animations on the
cartoon.  
I'm trying to go along wth the whole Futurama philosophy ;)  
Since the images come randomly from the API, I didn't try to keep to a color palette or even '
ColorFiltered' the images since it would detract from the bold cartoon-like feel.

## Implementation

Rather than Rows and Columns, I opted for positioning everything using Stack.

I would be more cautious of doing this in a professional app since it involves a lot of tweaking. I
have all the time in the world at the moment, so I had fun and enjoyed the freedom to feel like an
artist, but in order to ensure it works on all device sizes, it would be less work to rely on more
conventional methods e.g. Column and flex.

My other reason for using Stack is the complete freedom it gives you to animate the widgets on it.  
Sadly I've not had time to do this final step. I could throw something in, but it's too risky on the
last day.

I've left things like app icons and publishing, since this is supposed be compiled from source.

You can run dartdoc on the code.

## Bugs

- ListView drag gesture doesn't work in landscape on Biography e.g. Zoidberg.

## To do

- Replace screenAdjust with screenAdjustX and Y
- Animate text and image positions to illustrate the point in Stacking them rather than in
  Row/Columns.
- Fetch 'Try Again' button
- Use questionsErrorMessage and charactersErrorMessage in test. Maybe on ui too?
- Run on Android 7 (API 24) or greater. I can't seem to change back to Android 7, so fingers
  crossed. I'm using API 30/31

### Tests to do

- Page navigation in different orientations (at least no exceptions). See 'TODO Landscape tests'.
- Test exact field data after load.
- Quiz answer all questions widget test.
- ResultsPage widget test.
- More Empty List tests.
- More bad data tests.
- More bad internet tests.

### Ideas

- Add log for errors - see logError() - not worth the dependency on path_provider yet, let alone a
  cloud based solution.
- Click on text to choose answer too (not just radio). This might involved a Gesture handler which
  could cause more problems than it's worth.
- Tool tips. (not worth the time?)
- Fry starts big then animates small when haveInfo API. (Only worth it for when no internet)
