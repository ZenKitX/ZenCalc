# ZenCalc 应用图标设计

## 设计理念

ZenCalc 的图标设计遵循"Zen Calculation"设计哲学，融合了：
- **禅意美学**：不完美的圆（ensō）象征禅宗的"空"与"圆满"
- **数学符号**：等号（=）代表计算的本质
- **自然配色**：沙色背景 + 竹绿色主体

## 图标文件

- `app_icon_1024.png` - 主图标文件（1024x1024）
- `icon_philosophy.md` - 设计哲学文档

## 生成应用图标

### 1. 安装依赖

```bash
flutter pub get
```

### 2. 生成图标

```bash
flutter pub run flutter_launcher_icons
```

这将自动生成：
- Android 各尺寸图标（mipmap-*/ic_launcher.png）
- iOS 各尺寸图标（Assets.xcassets/AppIcon.appiconset/）
- Android Adaptive Icon（前景 + 背景）

### 3. 验证

运行应用查看新图标：

```bash
flutter run
```

## 设计元素

### 颜色
- **背景色**：`#E8E4DC`（温暖的沙色）
- **主色调**：`#7C9885`（竹绿色）
- **符号色**：`#3A3A3A`（墨色）

### 形状
- **主体**：不完整的圆（ensō），象征禅宗的"不完美即完美"
- **符号**：等号（=），代表计算和平衡
- **线条**：变化的线宽，模拟手绘质感

## 自定义图标

如果需要修改图标，编辑 Python 脚本重新生成：

```python
python -c "
from PIL import Image, ImageDraw
import math

# 创建 1024x1024 的图标
size = 1024
img = Image.new('RGB', (size, size), color='#E8E4DC')
draw = ImageDraw.Draw(img)

# ... 绘制代码 ...

img.save('design/app_icon_1024.png')
"
```

然后重新运行 `flutter pub run flutter_launcher_icons`。
