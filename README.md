# Futurama Characters and Quiz

- Demonstration of basic Flutter UI of data fetched from a simple API.

| Fry  | Hypnotoad | Zapp |
| ------------- | ------------- | ------------- |
| <img src="https://github.com/paulsump/futurama_quiz/blob/5cb265aac059b56153f73e9c09201f0418134a24/images/fry.png" width="248"> | <img src="https://github.com/paulsump/futurama_quiz/blob/5cb265aac059b56153f73e9c09201f0418134a24/images/hypnotoad.png" width="248"> | <img src="https://github.com/paulsump/futurama_quiz/blob/5cb265aac059b56153f73e9c09201f0418134a24/images/zapp.png" width="248"> |

## How to build

- Open the project in Android Studio, connect an Android or iOS device, run.

## Bugs

- Back button gesture clip? It's area seams bigger than it should be. Reproduce: ResultsPage.
- ListView gestures don't work in landscape. Reproduce: Biography/Zoidberg.


## To do now

- Handle exceptions (at least with http) e.g. Display proper error, not just "Please connect to the
  internet" on screen if request failed. Modify the test if appropriate.
- Don't add any info, characters or questions that have bad data (try/catch each one).

## To do

- Borders.
- More obvious Character and Quiz buttons.
- Check all TODOs
- Check able to run on any device
- Running Android 7 (API 24) or greater.
- //Font sizes and bold.

### Tests to do

- Page navigation in different orientations (at least no exceptions).
- Test exact field data after load.
- Quiz answer all questions widget test.
- ResultsPage widget test.

### Ideas

- Tool tips
- [Dark theme](https://stackoverflow.com/questions/56304215/how-to-check-if-dark-mode-is-enabled-on-ios-android-using-flutter)
- Click on text to choose answer too (not just radio).
- Fry starts big then animates small when haveInfo API. (Only worth it for when no internet)
