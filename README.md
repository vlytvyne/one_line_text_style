## Overview
Simplify your TextStyle declarations with the `one_line_text_style` package, which generates convenient extensions for TextStyle, enabling you to write verbose text styles in a single line of code.

**Write:**
```dart
return Text(
  'Title',
  style: ts.size48.white.semibold.italic.nocturne,
);
```
**Instead of:**
```dart
return Text(  
  'Title',  
   style: TextStyle(
     fontSize: 48,
     color: Colors.white,
     fontWeight: FontWeight.w600,
     fontStyle: FontStyle.italic,
     fontFamily: 'NocturneSerif',
  ),  
);
```


## Getting started

Include `one_line_text_style` as a dev_dependency in your pubspec.yaml file.
```yaml
dev_dependencies:
  one_line_text_style: ^0.6.0
```

## Usage

Run the following command in the terminal:

`dart run one_line_text_style:generate`

This generates a `one_line_text_style.dart` file at your project's lib folder. You can change the output file with the `--result-path` argument.

Now, leverage the generated extensions to simplify your TextStyles:

```dart
import '<your_path>/one_line_text_style.dart';

/// Define default app/screen/widget TextStyle
final ts = TextStyle(
  fontSize: 14,
  color: Colors.black,
);

/// Then use it like this
return Text(  
  'Title',
  style: ts.size48.white.semibold.italic.nocturne,  
);
...
return Text(  
  'Description',
  style: ts.size20.black.dmsans.overflowEllipsis,  
);
...
return Text(  
  'Clickable link',
  style: ts.size16.yellow.underline,  
);
...
return Text(  
  'Error',
  style: ts.size20.red.bold,  
);
```

**Note:** generated file doesn't have `.g.dart` extension and will not be rebuilt with build_runner commands. You are free to change the file per your needs if you don't intend to re-generate it.

## Configuration (optional)
Customize TextStyle extensions in `one_line_text_style.yaml`, `pubspec.yaml`, or specify the config file with the `--config-path` argument. Here's an example of the `one_line_text_style.yaml`:

```yaml
# Contains all possible configurations. All properties are optional.

one_line_text_style:
  size:                                   # fontSize
    prefix: size                          # Prefix of an extension property. [size] is used by default as a name can't start with a digit
    step: 2                               # size step e.g. 8, 10, 12, etc. 2 is a default value
    min: 8                                # minimum size. 8 is default value
    max: 30                               # maximum size. 60 is default value
    apply_prefix_to_custom_values: true   # whether to apply prefix to custom values. Default value is false
    custom_values:                        # custom values of extension
      medium: 30
      large: 40
  color:                                  # color
    prefix: color
    custom_values:                        # Default values for color are white, black, grey, red. You can override those here or add other if needed. Both 0xFF000000 and #000000 syntax is appropriate.
      yellow: '#AAAAAA'
  weight:                                 # fontWeight
    prefix: weight                        # [w] is used by default as a name can't start with a digit
    apply_prefix_to_custom_values: false
    custom_values:                        # Default values for weight are semibold, bold. You can override those here or add other if needed.
      extraThin: 100
  font_family:                            # fontFamily
    prefix: ''
    custom_values:
      dmsans: 'DM Sans'
  overflow:                               # overflow
    prefix: 'overflow'                    # [overflow] is used by default
  style:                                  # fontStyle
    prefix: ''
  decoration:                             # decoration
    prefix: ''
  decoration_style:                       # decorationStyle
    prefix: ''
```


## Future plans

- Implement a linter for `one_line_text_style`.
- Develop a script to substitute TextStyles using extensions with constant constructors.