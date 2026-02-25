---
nav_order: 99
---

# Mermaid 测试页面

## 测试 Mermaid 图表

这是一个测试页面，用于验证 Mermaid 是否能正常工作。

### 简单流程图

<div class="mermaid">
graph TD
    A[开始] --> B[过程]
    B --> C{判断}
    C -->|是| D[结果1]
    C -->|否| E[结果2]
</div>

### 序列图

<div class="mermaid">
sequenceDiagram
    participant A as Alice
    participant B as Bob
    A->>B: Hello Bob!
    B-->>A: Hi Alice!
</div>

### 类图

<div class="mermaid">
classDiagram
    class Animal {
        +String name
        +makeSound()
    }
    class Dog {
        +bark()
    }
    Animal <|-- Dog
</div>
