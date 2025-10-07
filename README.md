# 🎨 Flutter Motion UI

A beautiful collection of 80+ animated Flutter components with smooth motions and modern design trends. Build stunning Flutter applications with pre-built, customizable animated widgets.


## ✨ Features

- 🎭 **80+ Components** - Buttons, cards, animations, navigation, and more
- 🚀 **Performance Optimized** - Smooth 60fps animations
- 🎨 **Fully Customizable** - Every color, size, and animation
- 📱 **Responsive** - Works on all screen sizes
- ♿ **Accessible** - Proper semantics and contrast
- 🎯 **Modern Design** - 2025 design trends (glassmorphism, gradients, smooth animations)

## 📦 Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_motion_ui: ^1.0.3
```

Then run:
```bash
flutter pub get
```

## 🚀 Quick Start

```dart
import 'package:flutter/material.dart';
import 'package:flutter_motion_ui/flutter_motion_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Motion UI Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MotionAppBar(
        title: const Text('Flutter Motion UI'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          MotionButton(
            onPressed: () {
              ModernToast.show(
                context,
                message: 'Hello Motion UI! 🎉',
                type: ToastType.success,
              );
            },
            child: const Text('Tap Me'),
          ),
          const SizedBox(height: 16),
          const MotionCard(
            child: ListTile(
              title: Text('Beautiful Card'),
              subtitle: Text('With smooth animations'),
            ),
          ),
        ],
      ),
    );
  }
}
```

## 🎭 Components

### 🎯 Buttons

#### MotionButton
```dart
MotionButton(
  onPressed: () {
    print('Button pressed!');
  },
  backgroundColor: Colors.blue,
  foregroundColor: Colors.white,
  animationDuration: const Duration(milliseconds: 300),
  child: const Text('Animated Button'),
)
```

#### GradientButton
```dart
GradientButton(
  onPressed: () {},
  gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
  child: const Text('Gradient Button'),
)
```

### 🃏 Cards

#### MotionCard
```dart
MotionCard(
  onTap: () {
    print('Card tapped!');
  },
  enableAnimation: true,
  child: const ListTile(
    leading: Icon(Icons.star),
    title: Text('Interactive Card'),
    subtitle: Text('Tap for animation'),
  ),
)
```

#### GlassmorphicCard
```dart
GlassmorphicCard(
  blur: 15.0,
  borderRadius: 25.0,
  child: const Padding(
    padding: EdgeInsets.all(20),
    child: Column(
      children: [
        Text('Glass Effect', style: TextStyle(fontSize: 24)),
        Text('Beautiful glass morphism'),
      ],
    ),
  ),
)
```

### 🎬 Animations

#### FadeAnimation
```dart
FadeAnimation(
  duration: const Duration(milliseconds: 800),
  delay: const Duration(milliseconds: 200),
  child: const Text('Fading Text'),
)
```

#### ScaleAnimation
```dart
ScaleAnimation(
  beginScale: 0.5,
  endScale: 1.0,
  child: const Text('Scaling Text'),
)
```

#### SlideAnimation
```dart
SlideAnimation(
  beginOffset: const Offset(1.0, 0.0),
  endOffset: Offset.zero,
  child: const Text('Sliding Text'),
)
```

### 📱 Navigation

#### AwesomeBottomNav
```dart
AwesomeBottomNav(
  items: [
    BottomNavItem(icon: Icons.home, label: 'Home'),
    BottomNavItem(icon: Icons.search, label: 'Search'),
    BottomNavItem(icon: Icons.person, label: 'Profile'),
  ],
  currentIndex: _currentIndex,
  onTap: (index) {
    setState(() {
      _currentIndex = index;
    });
  },
  selectedColor: Colors.blue,
  height: 80,
)
```

#### MotionAppBar
```dart
MotionAppBar(
  title: const Text('My App'),
  backgroundColor: Colors.blue,
  foregroundColor: Colors.white,
  actions: [
    IconButton(icon: const Icon(Icons.search), onPressed: () {}),
  ],
)
```

### 📄 Bottom Sheets

#### MotionBottomSheet
```dart
MotionBottomSheet.show(
  context: context,
  title: 'Options',
  child: ListView(
    shrinkWrap: true,
    children: [
      ListTile(leading: Icon(Icons.share), title: Text('Share')),
      ListTile(leading: Icon(Icons.download), title: Text('Download')),
      ListTile(leading: Icon(Icons.delete), title: Text('Delete')),
    ],
  ),
)
```

### 📋 Lists

#### AnimatedListItem
```dart
ListView.builder(
  itemCount: 10,
  itemBuilder: (context, index) {
    return AnimatedListItem(
      index: index,
      child: ListTile(
        title: Text('Item $index'),
        subtitle: Text('With stagger animation'),
      ),
    );
  },
)
```

#### SwipeableListItem
```dart
SwipeableListItem(
  onLeftSwipe: () {
    ModernToast.show(context, message: 'Left swipe!');
  },
  onRightSwipe: () {
    ModernToast.show(context, message: 'Right swipe!');
  },
  leftAction: Container(color: Colors.green, child: Icon(Icons.check)),
  rightAction: Container(color: Colors.red, child: Icon(Icons.delete)),
  child: ListTile(title: Text('Swipe me!')),
)
```

### 🔔 Toasts & Dialogs

#### ModernToast
```dart
ModernToast.show(
  context,
  message: 'Operation successful!',
  type: ToastType.success,
  duration: const Duration(seconds: 3),
)

// Available types:
// ToastType.success, ToastType.error, ToastType.warning, ToastType.info
```

#### MotionDialog
```dart
MotionDialog.show(
  context: context,
  title: 'Confirmation',
  content: 'Are you sure you want to delete this item?',
  actions: [
    TextButton(
      onPressed: () => Navigator.pop(context),
      child: const Text('Cancel'),
    ),
    MotionButton(
      onPressed: () {
        Navigator.pop(context);
        // Handle confirmation
      },
      child: const Text('Delete'),
    ),
  ],
)
```

### ⌨️ Inputs

#### MotionTextField
```dart
MotionTextField(
  controller: _textController,
  labelText: 'Email',
  prefixIcon: Icons.email,
  validator: (value) {
    if (value?.isEmpty ?? true) return 'Please enter email';
    return null;
  },
  onChanged: (value) {
    print('Text changed: $value');
  },
)
```

### 🏷️ Chips & Badges

#### MotionChip
```dart
MotionChip(
  label: 'Flutter',
  backgroundColor: Colors.blue,
  textColor: Colors.white,
  onTap: () {
    print('Chip tapped!');
  },
)
```

#### NotificationBadge
```dart
NotificationBadge(
  count: 5,
  child: IconButton(
    icon: const Icon(Icons.notifications),
    onPressed: () {},
  ),
)
```

## 🎨 Complete Example App

```dart
import 'package:flutter/material.dart';
import 'package:flutter_motion_ui/flutter_motion_ui.dart';

void main() {
  runApp(const MotionUIApp());
}

class MotionUIApp extends StatelessWidget {
  const MotionUIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Motion UI Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const HomePage(),
    const ProfilePage(),
    const SettingsPage(),
  ];

  final List<BottomNavItem> _navItems = [
    BottomNavItem(icon: Icons.home, label: 'Home'),
    BottomNavItem(icon: Icons.person, label: 'Profile'),
    BottomNavItem(icon: Icons.settings, label: 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: AwesomeBottomNav(
        items: _navItems,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MotionAppBar(
        title: const Text('Home'),
        actions: [
          NotificationBadge(
            count: 3,
            child: IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          FadeAnimation(
            child: ScaleAnimation(
              child: const MotionCard(
                child: ListTile(
                  title: Text('Welcome!'),
                  subtitle: Text('Double animation effect'),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          MotionButton(
            onPressed: () {
              MotionBottomSheet.show(
                context: context,
                title: 'Options',
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.info),
                      title: const Text('About'),
                      onTap: () {
                        Navigator.pop(context);
                        ModernToast.show(
                          context,
                          message: 'About clicked!',
                          type: ToastType.info,
                        );
                      },
                    ),
                  ],
                ),
              );
            },
            child: const Text('Show Bottom Sheet'),
          ),
        ],
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MotionAppBar(title: const Text('Profile')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            GlassmorphicCard(
              child: Row(
                children: [
                  CircleAvatar(radius: 30),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('John Doe', style: TextStyle(fontSize: 20)),
                      Text('Flutter Developer'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MotionAppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AnimatedListItem(
            index: 0,
            child: const MotionCard(child: ListTile(title: Text('Theme'))),
          ),
          AnimatedListItem(
            index: 1,
            child: const MotionCard(child: ListTile(title: Text('Notifications'))),
          ),
          AnimatedListItem(
            index: 2,
            child: const MotionCard(child: ListTile(title: Text('Privacy'))),
          ),
        ],
      ),
    );
  }
}
```

## 🎯 Advanced Usage

### Custom Animation Combinations
```dart
SlideAnimation(
  beginOffset: const Offset(0.0, 1.0),
  child: FadeAnimation(
    delay: const Duration(milliseconds: 200),
    child: ScaleAnimation(
      beginScale: 0.8,
      child: const MotionCard(
        child: Text('Combined Animations'),
      ),
    ),
  ),
)
```

### Custom Theme Configuration
```dart
// Create a custom theme wrapper
class MotionTheme extends StatelessWidget {
  final Widget child;
  
  const MotionTheme({super.key, required this.child});
  
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light().copyWith(
        extensions: [
          MotionConfig(
            primaryColor: Colors.purple,
            animationDuration: const Duration(milliseconds: 500),
            borderRadius: 16.0,
          ),
        ],
      ),
      child: child,
    );
  }
}
```

## 🔧 Customization

Every component is fully customizable:

```dart
MotionButton(
  onPressed: () {},
  // Colors
  backgroundColor: Colors.purple,
  foregroundColor: Colors.white,
  // Animation
  animationDuration: const Duration(milliseconds: 500),
  animationCurve: Curves.bounceOut,
  // Layout
  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
  borderRadius: BorderRadius.circular(25),
  child: const Text('Custom Button'),
)
```

## 📚 API Reference

### Common Properties

| Property | Type | Description |
|----------|------|-------------|
| `duration` | `Duration` | Animation duration |
| `curve` | `Curve` | Animation curve |
| `backgroundColor` | `Color` | Background color |
| `onTap` | `Function` | Tap callback |
| `child` | `Widget` | Child widget |

## 🐛 Troubleshooting

### Common Issues

1. **Animation not working?**
    - Ensure widget is mounted before starting animation
    - Check animation duration and delay

2. **Import errors?**
   ```dart
   // Correct import
   import 'package:flutter_motion_ui/flutter_motion_ui.dart';
   
   // Not this:
   // import 'flutter_motion_ui.dart';
   ```

3. **Performance issues?**
    - Use `const` constructors where possible
    - Avoid rebuilding entire trees during animations

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guide](https://github.com/lyhorngcnb/flutter_motion_ui/blob/main/CONTRIBUTING.md) for details.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/lyhorngcnb/flutter_motion_ui/blob/main/LICENSE) file for details.

## 🔗 Links

- [📖 Documentation](https://github.com/lyhorngcnb/flutter_motion_ui/wiki)
- [🐛 Report Issues](https://github.com/lyhorngcnb/flutter_motion_ui/issues)
- [💡 Feature Requests](https://github.com/lyhorngcnb/flutter_motion_ui/issues)
- [⭐ Star on GitHub](https://github.com/lyhorngcnb/flutter_motion_ui)

## 🚀 Getting Help

If you need help implementing any component or have questions:

1. Check the [examples](https://github.com/lyhorngcnb/flutter_motion_ui/tree/main/example) folder
2. Open an [issue](https://github.com/lyhorngcnb/flutter_motion_ui/issues)
3. Check existing [discussions](https://github.com/lyhorngcnb/flutter_motion_ui/discussions)

---

**Happy Coding! 🎉** Build amazing Flutter apps with beautiful animations!