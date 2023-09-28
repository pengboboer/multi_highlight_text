juejin：https://juejin.cn/post/7283749823428214821

# multi_highlight_text
Used to achieve multiple styles of text highlighting, including cross highlighting

### Example

#### Simple display
<img src="https://raw.githubusercontent.com/pengboboer/multi_highlight_text/master/demo_simple.png" width=600 />

#### Content error correction display
<img src="https://raw.githubusercontent.com/pengboboer/multi_highlight_text/master/demo_correct.png" width=600 />

### Features
* multiple highlight styles
* highlight style crossing
* custom cross style
* supports both words and positions
* custom decoration of highlight text

### Usage

#### Simple
```
MultiHighLightText(
    text: chText,
    textStyle: _textStyle,
    highlights: [
      HighlightItem(
          text: "xxx",
          textStyle: _textStyle.copyWith(color: Colors.green)),
      HighlightItem(
          text: "xxx",
          textStyle: _textStyle.copyWith(color: Colors.yellow)),
      HighlightItem(
          range: const TextRange(start: 0, end: 1),
          textStyle: _textStyle.copyWith(color: Colors.red)),
    ],
)
```
#### Custom
```
MultiHighLightText(
    text: chText,
    textStyle: _textStyle,
    highlights: [
      HighlightItem(
          text: "xxx",
          textStyle: _textStyle.copyWith(color: Colors.green)),
      HighlightItem(
          text: "xxx",
          textStyle: _textStyle.copyWith(color: Colors.yellow)),
      HighlightItem(
          range: const TextRange(start: 0, end: 1),
          textStyle: _textStyle.copyWith(color: Colors.red)),
    ],
    onMixStyleBuilder: _onMixCorrectErrorTextStyleBuilder, // custom cross style
    onDecorateTextSpanBuilder: _onDecorateBuilder, // decorate the collection of the final textspan
)
```
### Existing providers 
| name     | description                                   |
| ------------ | ---------------------------------|
| text          | The text you want to show                    |
| textStyle | The text style |
| highlights | List with the word you need to highlight |
| onMixStyleBuilder | The builder of custom cross highlight style |
| onDecorateTextSpanBuilder | The builder of decorate the textSpans |

### Other
If it helps you, please give me a star, thank you.

Currently, the library supports the above functions. If you have other requirements or bugs, please raise an issue and I will try our best to help everyone solve it.
