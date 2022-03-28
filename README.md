# Futurama Characters and Quiz

- Demonstration of basic Flutter UI of data fetched from a simple API.

## How to build

- Open the project in Android Studio, connect an Android or iOS device, run.

## Bugs

- ListView gestures don't work in landscape. Reproduce: Biography/Zoidberg.

## To do now Quiz Layout

- Stateless QuizPage
- Always use maxquestions space
- More params for ScreenAdjust (portrait and sizedbox)
- Fill up bottom of screen in Biography and Quiz (maybe use a Column)

## To do now

- Handle exceptions (at least with http) e.g. Display proper error, not just "Please connect to the
  internet" on screen if request failed. Modify the test if appropriate.
- Don't add any info, characters or questions that have bad data (try/catch them).
- //Adjust Font size for different screens. e.g. answers.

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
- Dark theme
- Click on text to choose answer too (not just radio).
- Fry starts big then animates small when haveInfo API.
