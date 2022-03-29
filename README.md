# Futurama Characters and Quiz

- Demonstration of basic Flutter UI of data fetched from a simple API.

| Fry  | Hypnotoad | Zapp |
| ------------- | ------------- | ------------- |
| <img src="https://github.com/paulsump/futurama_quiz/blob/5cb265aac059b56153f73e9c09201f0418134a24/images/fry.png" width="248"> | <img src="https://github.com/paulsump/futurama_quiz/blob/5cb265aac059b56153f73e9c09201f0418134a24/images/hypnotoad.png" width="248"> | <img src="https://github.com/paulsump/futurama_quiz/blob/5cb265aac059b56153f73e9c09201f0418134a24/images/zapp.png" width="248"> |

## How to build

- Open the project in Android Studio, connect an Android or iOS device, pub get, run.

## Bugs

- Back button gesture clip? It's area seams bigger than it should be. Reproduce: ResultsPage.
- Or maybe that was just the bug that happens when you tap too fast after it starts to navigate to
  the ResultsPage?
- ListView drag gesture doesn't work in landscape on Biography/Zoidberg.

## To do

- More obvious Character, Quiz and Restart Quiz buttons.
- Run on Android 7 (API 24) or greater.

## Last minute checks

- Check all TODOs
- Check able to run on any device.

### Tests to do

- Page navigation in different orientations (at least no exceptions).
- Test exact field data after load.
- Quiz answer all questions widget test.
- ResultsPage widget test.
- More bad data.
- More bad internet.

### Ideas

- Add log for errors - see logError() - not worth the dependency on path_provider yet.
- Click on text to choose answer too (not just radio).
- Tool tips. (not worth the time?)
- Fry starts big then animates small when haveInfo API. (Only worth it for when no internet)
