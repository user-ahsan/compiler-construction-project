# EaseCode Language Specification

## 1. Language Overview

**Language Name:** EaseCode

**Theme:** Simple, plain English, to avoid confusing syntax or symbols. Uses well-known words.

**Purpose:** To make the programming learning path easier without needing to remember difficult syntax. It's intended for basic concepts like variables, loops, etc.

## 2. Keywords

| Keyword | Meaning/Equivalent (C++) | Example Usage |
|---------|-------------------------|---------------|
| `start` | `main` | `start...` |
| `finish` | `return 0` | `finish;` |
| `number` | `int` | `number x = 10;` |
| `decimal` | `float` | `decimal y = 5.5;` |
| `text` | `string` | `text name = "Ahsan";` |
| `show` | `cout` | `show "Hello";` |
| `get` | `cin` | `get x;` |
| `check` | `if` | `check (x > 5) {...}` |
| `otherwise` | `else` | `otherwise ...` |
| `loop` | `while` | `loop (x < 10) {...}` |
| `nothing` | `void` | `nothing myfunction` |
| `giveback` | `return` | `giveback 5;` |
| `yes` | `true` | `number check = yes;` |
| `no` | `false` | `number check = no;` |
| `new` | `new` | to create new things |

## 3. Operators

| Symbol | Description |
|--------|-------------|
| `+` | for adding numbers |
| `-` | for subtracting |
| `*` | multiplying |
| `=` | assigning a value |

## 4. Punctuations

| Symbol | Description |
|--------|-------------|
| `;` | Ends a statement |
| `(` | starts a condition |
| `)` | Ends a condition |
| `{` | starts a code block |
| `}` | Ends a code block |

## 5. Regular Expressions (RE)

| Token Type | Regular Expression |
|------------|-------------------|
| `identifier` | `[a-zA-Z]+` |
| `integer` | `[0-9]+` |
| `float` | `[0-9]+\.[0-9]+` |
| `keyword` | `start` / `finish` / `number` / `decimal` / `text` / `show` / `get` / `check` / `otherwise` / `loop` / `nothing` / `giveback` / `yes` / `no` / `new` |

## 6. Additional Notes

### Identifiers
- Must start with a letter
- Can contain only letters (a-z, A-Z)
- Case-sensitive

### Numbers
- **Integers:** Sequences of digits (0-9)
- **Floats:** Sequences of digits, followed by a decimal point, followed by more digits

### Strings
- Text literals should be enclosed in double quotes: `"example text"`

### Comments
- (Note: Comment syntax should be specified if needed)

### Examples

#### Variable Declaration
```
number x = 10;
decimal y = 5.5;
text name = "Ahsan";
```

#### Conditional Statements
```
check (x > 5) {
    show "Greater than 5";
}
otherwise {
    show "Less than or equal to 5";
}
```

#### Loops
```
loop (x < 10) {
    show x;
    x = x + 1;
}
```

#### Main Function
```
start {
    number x = 10;
    show "Hello World";
    finish;
}
```

