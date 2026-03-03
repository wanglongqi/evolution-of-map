---
nav_order: 8
---

# 第八章 现代误差分析与质量度量

## 8.1 引言

地图投影本质上是一种从三维球面（或椭球面）到二维平面的数学变换。由于维度差异，这种变换不可避免地引入失真（distortion）。传统的误差分析主要依赖几何指标和经验法则，而现代误差分析则引入了更严谨的数学框架、计算方法和质量度量体系。

本章将从三个方面探讨现代误差分析与质量度量理论的发展：首先，建立系统的定量失真指标体系，实现对投影失真的精确评估；其次，探讨机器学习技术在投影优化中的应用，展示数据驱动方法如何突破传统理论限制；最后，分析现代数学技术（如小波分析、分数阶微积分等）在经典投影改进中的创新应用。

现代误差分析的目标不仅是量化失真，更是建立可计算、可预测、可优化的质量管理体系，使制图者能够在精度要求、计算效率和可视化效果之间做出最优决策。

---

## 8.2 定量失真指标

### 8.2.1 基本失真类型

地图投影的失真可以分为三大基本类型，每种都有其特定的数学表征：

#### 长度失真（Length Distortion）

长度失真指地图上两点间的距离与地球表面实际距离的比值。

设投影变换为 $T: (\lambda, \phi) \rightarrow (x, y)$ ，其中 $(\lambda, \phi)$ 为经纬度， $(x, y)$ 为平面坐标。

**数学表述：**

在任意点 $P$ 处，设沿经线方向（ $\phi$ 方向）的长度比（scale factor）为 $k$ ，沿纬线方向（ $\lambda$ 方向）的长度比为 $h$ 。

对于球面投影：

$$
k = \frac{\sqrt{(\frac{\partial x}{\partial \phi})^2 + (\frac{\partial y}{\partial \phi})^2}}{R}
$$

$$
h = \frac{\sqrt{(\frac{\partial x}{\partial \lambda})^2 + (\frac{\partial y}{\partial \lambda})^2}}{R \cos\phi}
$$

其中 $R$ 为地球半径。

**最大最小长度比：**

由于失真通常具有方向依赖性，主方向的长度比可通过度量张量的特征值计算：

$$
\text{最大长度比: } k_{max} = \sqrt{\frac{h^2 + k^2 + \sqrt{(h^2 - k^2)^2 + 4h^2k^2\cos^2\theta'}}{2}}
$$

$$
\text{最小长度比: } k_{min} = \sqrt{\frac{h^2 + k^2 - \sqrt{(h^2 - k^2)^2 + 4h^2k^2\cos^2\theta'}}{2}}
$$

$$
\text{长度失真度: } d_{length} = \frac{k_{max} - k_{min}}{k_{min}}
$$

#### 角度失真（Angular Distortion）

角度失真衡量投影保持角度不变的能力，是保角投影的核心指标。

**Tissot标形（Tissot's Indicatrix）：**

Tissot标形是分析投影失真的经典工具。在地球上取一个无穷小的圆，投影后变为椭圆。

设该椭圆的半长轴为 $a$ ，半短轴为 $b$ ，椭圆的方位角为 $\theta$ 。

**角度失真度量：**

$$
\omega = 2 \arcsin\left(\frac{a - b}{a + b}\right)
$$

当 $\omega = 0$ 时，投影为保角投影（如墨卡托投影）。

**变形椭圆参数：**

$$
a = k_{max}
$$

$$
b = k_{min}
$$

其中 $\theta'$ 为投影后经纬线的夹角。

#### 面积失真（Area Distortion）

面积失真衡量投影保持面积不变的能力。

**面积比（Area Scale）：**

$$
p = hk \sin\theta'
$$

其中 $h$ 和 $k$ 如前定义， $\theta'$ 为投影后经纬线的夹角。

**面积失真度量：**

对于等积投影， $p = 1$ （理论上）。

实际面积失真度：

$$
d_{area} = |p - 1|
$$

或使用相对形式：

$$
d_{area, rel} = \frac{|p - 1|}{p}
$$

### 8.2.2 综合失真指标

#### Arends指标

Arends指标提供了一种综合评估投影质量的方法：

$$
I = \frac{1}{S} \int_S \omega \, dS
$$

其中 $S$ 为投影覆盖的区域， $\omega$ 为角度失真。

**数值实现：**

```python
def arends_indicator(proj_func, bounds, grid_resolution=100):
    """
    计算Arends综合失真指标

    参数：
        proj_func: 投影函数 (lon, lat) -> (x, y)
        bounds: 边界 (lon_min, lon_max, lat_min, lat_max)
        grid_resolution: 网格分辨率
    """
    lon_min, lon_max, lat_min, lat_max = bounds

    # 生成网格
    lon_vals = np.linspace(lon_min, lon_max, grid_resolution)
    lat_vals = np.linspace(lat_min, lat_max, grid_resolution)

    total_distortion = 0.0
    area = 0.0

    for i in range(len(lon_vals) - 1):
        for j in range(len(lat_vals) - 1):
            # 计算网格单元中心
            lon = (lon_vals[i] + lon_vals[i+1]) / 2
            lat = (lat_vals[j] + lat_vals[j+1]) / 2

            # 计算局部失真
            distortion = compute_local_distortion(proj_func, lon, lat)

            # 计算单元面积（球面近似）
            d_lon = lon_vals[i+1] - lon_vals[i]
            d_lat = lat_vals[j+1] - lat_vals[j]
            unit_area = d_lon * d_lat * math.cos(math.radians(lat))

            total_distortion += distortion * unit_area
            area += unit_area

    return total_distortion / area

def compute_local_distortion(proj_func, lon, lat, epsilon=0.01):
    """
    计算单点的局部失真（基于Tissot标形）
    """
    # 计算投影坐标
    x0, y0 = proj_func(lon, lat)

    # 数值计算偏导数
    dx_dphi = (proj_func(lon, lat + epsilon)[0] - proj_func(lon, lat - epsilon)[0]) / (2 * epsilon)
    dy_dphi = (proj_func(lon, lat + epsilon)[1] - proj_func(lon, lat - epsilon)[1]) / (2 * epsilon)

    dx_dlambda = (proj_func(lon + epsilon, lat)[0] - proj_func(lon - epsilon, lat)[0]) / (2 * epsilon)
    dy_dlambda = (proj_func(lon + epsilon, lat)[1] - proj_func(lon - epsilon, lat)[1]) / (2 * epsilon)

    # 计算标形参数
    h = math.sqrt((dx_dlambda**2 + dy_dlambda**2)) / (math.cos(math.radians(lat)))
    k = math.sqrt((dx_dphi**2 + dy_dphi**2))

    cos_theta_prime = (dx_dphi * dx_dlambda + dy_dphi * dy_dlambda) / (h * k)

    # Tissot标形半轴
    numerator = h**2 + k**2 + 2 * h * k * cos_theta_prime
    a = math.sqrt(numerator) / 2

    denominator = h**2 + k**2 - 2 * h * k * cos_theta_prime
    b = math.sqrt(denominator) / 2

    # 角度失真
    omega = 2 * math.asin((a - b) / (a + b))

    return omega
```

#### Goldberg-Gott指标

Goldberg与Gott提出了一种综合评估球面到平面映射质量的指标：

$$
I_{GG} = \frac{1}{\pi} \left[ \alpha(\phi, \theta) \sqrt{d_{flex}^2 + d_{skew}^2 + d_{areal}^2} + d_{boundary}^2 + d_{cuts}^2 \right]
$$

其中：
- $\alpha(\phi, \theta)$ 为局部角度失真
- $d_{flex}$ 为柔性失真（flexion，弯曲失真）
- $d_{skew}$ 为剪切开性
- $d_{areal}$ 为面积失真
- $d_{boundary}$ 为边界失真
- $d_{cuts}$ 为切口失真（由于投影分割造成）

**数值实现：**

```python
def goldberg_gott_indicator(proj_func, bounds, grid_res=50):
    """
    计算Goldberg-Gott综合质量指标
    """
    # 简化版本，仅考虑局部失真
    lon_vals = np.linspace(bounds[0], bounds[1], grid_res)
    lat_vals = np.linspace(bounds[2], bounds[3], grid_res)

    total_score = 0.0
    count = 0

    for lon in lon_vals:
        for lat in lat_vals:
            # 计算局部指标
            score = compute_local_gg_score(proj_func, lon, lat)
            total_score += score
            count += 1

    return total_score / count

def compute_local_gg_score(proj_func, lon, lat, epsilon=0.05):
    """
    计算局部Goldberg-Gott指标
    """
    # 计算投影坐标
    x, y = proj_func(lon, lat)

    # 计算一阶导数
    x_lat = (proj_func(lon, lat + epsilon)[0] - proj_func(lon, lat - epsilon)[0]) / (2 * epsilon)
    y_lat = (proj_func(lon, lat + epsilon)[1] - proj_func(lon, lat - epsilon)[1]) / (2 * epsilon)

    x_lon = (proj_func(lon + epsilon, lat)[0] - proj_func(lon - epsilon, lat)[0]) / (2 * epsilon)
    y_lon = (proj_func(lon + epsilon, lat)[1] - proj_func(lon - epsilon, lat)[1]) / (2 * epsilon)

    # 计算二阶导数（用于衡量弯曲）
    x_lat_lat = (proj_func(lon, lat + epsilon)[0] - 2 * x + proj_func(lon, lat - epsilon)[0]) / (epsilon**2)
    y_lon_lon = (proj_func(lon + epsilon, lat)[1] - 2 * y + proj_func(lon - epsilon, lat)[1]) / (epsilon**2)

    # 计算二阶失真（Flexion）
    d_flex = math.sqrt(x_lat_lat**2 + y_lon_lon**2)

    # 计算局部面积失真
    jacobian = x_lat * y_lon - x_lon * y_lat
    d_areal = abs(jacobian - math.cos(math.radians(lat)))

    # 计算局部剪切开性
    cos_theta_prime = (x_lat * x_lon + y_lat * y_lon)
    cos_theta_prime /= math.sqrt(x_lat**2 + y_lat**2) * math.sqrt(x_lon**2 + y_lon**2)
    d_skew = abs(cos_theta_prime)

    # 综合指标
    alpha = 2 * math.asin(abs(d_skew) / 2)
    score = (alpha / math.pi) * math.sqrt(d_flex**2 + d_skew**2 + d_areal**2)

    return score
```

### 8.2.3 信息论指标

#### 熵失真指标

从信息论角度，投影失真可视为信息损失。

**信息熵定义：**

对于离散化的地图区域，设原始球面数据的熵为 $H_{sphere}$ ，投影后平面数据的熵为 $H_{plane}$ 。

$$
H = -\sum_{i} p_i \log p_i
$$

其中 $p_i$ 为像素 $i$ 的归一化值。

**熵失真：**

$$
D_{entropy} = H_{sphere} - H_{plane}
$$

当投影导致信息损失时， $H_{plane} < H_{sphere}$ ， $D_{entropy} > 0$ 。

**实际应用：**

```python
def entropy_distortion(original_grid, projected_grid):
    """
    计算基于信息熵的失真指标

    参数：
        original_grid: 原始球面数据网格（地形高度等）
        projected_grid: 投影后数据网格
    """
    def compute_entropy(grid):
        # 归一化
        normalized = (grid - grid.min()) / (grid.max() - grid.min() + 1e-10)

        # 计算直方图
        hist, _ = np.histogram(normalized.flatten(), bins=256, density=True)

        # 计算熵
        entropy = 0.0
        for p in hist:
            if p > 0:
                entropy -= p * math.log2(p)

        return entropy

    H_sphere = compute_entropy(original_grid)
    H_plane = compute_entropy(projected_grid)

    D = H_sphere - H_plane

    return {
        'sphere_entropy': H_sphere,
        'plane_entropy': H_plane,
        'distortion': D
    }
```

#### 互信息指标

互信息（Mutual Information）衡量投影前后数据的相关性：

$$
I(X; Y) = H(X) + H(Y) - H(X, Y)
$$

其中 $X$ 为原始球面数据， $Y$ 为投影后数据， $H(X, Y)$ 为联合熵。

```python
def mutual_information(original, projected, bins=64):
    """
    计算原始数据与投影数据之间的互信息
    """
    # 计算联合直方图
    joint_hist, _, _ = np.histogram2d(
        original.flatten(),
        projected.flatten(),
        bins=bins,
        density=True
    )

    # 边缘分布
    marginal_x = np.sum(joint_hist, axis=1)
    marginal_y = np.sum(joint_hist, axis=0)

    # 计算互信息
    MI = 0.0
    for i in range(bins):
        for j in range(bins):
            if joint_hist[i, j] > 0 and marginal_x[i] > 0 and marginal_y[j] > 0:
                MI += joint_hist[i, j] * math.log2(
                    joint_hist[i, j] / (marginal_x[i] * marginal_y[j])
                )

    return MI
```

### 8.2.4 全局误差度量

#### Airy准则

Airy准则由George Airy提出，用于评估投影的平均误差。

**Airy平均误差：**

$$
E_A = \frac{1}{S} \iint_S (a - 1)^2 \, dS
$$

其中 $a$ 为局部面积比。

**数值实现：**

```python
def airy_criterion(proj_func, lat_range=(-80, 80), n_points=1000):
    """
    计算Airy平均误差准则

    Airy准则衡量投影在给定区域内的平均面积失真
    """
    lats = np.linspace(lat_range[0], lat_range[1], n_points)

    squared_errors = []

    for lat in lats:
        # 计算局部面积比
        h, k, theta_prime = compute_scale_factors(proj_func, 0, lat)

        # 面积比
        area_scale = h * k * math.sin(theta_prime)

        # 相对误差
        relative_error = (area_scale - 1.0) / 1.0

        squared_errors.append(relative_error**2)

    # 平均误差
    E_A = np.mean(squared_errors)

    return E_A
```

#### Jordan准则

Jordan准则考虑最大误差：

$$
E_J = \max_S |a - 1|
$$

即在整个区域内，面积与真实值偏离最大的程度。

```python
def jordan_criterion(proj_func, bounds, grid_res=100):
    """
    计算Jordan最大误差准则
    """
    lon_vals = np.linspace(bounds[0], bounds[1], grid_res)
    lat_vals = np.linspace(bounds[2], bounds[3], grid_res)

    max_error = 0.0

    for lon in lon_vals:
        for lat in lat_vals:
            h, k, theta_prime = compute_scale_factors(proj_func, lon, lat)

            area_scale = h * k * math.sin(theta_prime)
            error = abs(area_scale - 1.0)

            if error > max_error:
                max_error = error

    return max_error
```

---

## 8.3 机器学习在投影优化中的应用

### 8.3.1 神经网络投影变换

传统投影变换基于解析公式，而神经网络可以学习复杂的非线性映射关系，可能发现新的投影规律。

#### 前馈网络投影模型

**模型架构：**

```python
import torch
import torch.nn as nn
import numpy as np

class NeuralProjection(nn.Module):
    """
    神经网络投影变换模型

    输入：经度 λ，纬度 φ
    输出：平面坐标 (x, y)
    """
    def __init__(self, hidden_sizes=[64, 128, 64], activation='relu'):
        super(NeuralProjection, self).__init__()

        layers = []
        input_size = 2  # (lon, lat)

        for i, hidden_size in enumerate(hidden_sizes):
            layers.append(nn.Linear(input_size, hidden_size))

            if activation == 'relu':
                layers.append(nn.ReLU())
            elif activation == 'tanh':
                layers.append(nn.Tanh())
            elif activation == 'silu':
                layers.append(nn.SiLU())

            input_size = hidden_size

        # 输出层
        layers.append(nn.Linear(input_size, 2))  # (x, y)

        self.network = nn.Sequential(*layers)

    def forward(self, lon_lat):
        """
        前向传播

        参数：
            lon_lat: Tensor, shape (batch_size, 2), [lon, lat]
        """
        # 归一化输入（经度到[-1,1]，纬度到[-1,1]）
        normalized = lon_lat / torch.tensor([180.0, 90.0])

        # 网络变换
        xy = self.network(normalized)

        # 反归一化到合理范围
        # 假设输出范围类似墨卡托投影
        xy = xy * torch.tensor([3.0, 1.5])  # 缩放因子

        return xy
```

**训练数据生成：**

```python
def generate_training_data(true_projection_func,
                           num_samples=10000,
                           lon_range=(-180, 180),
                           lat_range=(-80, 80)):
    """
    生成用于训练神经网络的投影数据

    参数：
        true_projection_func: 真实投影函数，如墨卡托投影
        num_samples: 样本数量
        lon_range: 经度范围
        lat_range: 纬度范围
    """
    # 随机采样经纬度
    lons = np.random.uniform(lon_range[0], lon_range[1], num_samples)
    lats = np.random.uniform(lat_range[0], lat_range[1], num_samples)

    # 计算真实投影坐标
    xy = np.array([true_projection_func(lon, lat) for lon, lat in zip(lons, lats)])

    # 构造输入输出Tensor
    lon_lat = torch.tensor(np.column_stack([lons, lats]), dtype=torch.float32)
    xy_target = torch.tensor(xy, dtype=torch.float32)

    return lon_lat, xy_target

# 示例：墨卡托投影
def mercator_projection(lon, lat, R=6378137.0):
    """
    墨卡托投影（简化版）
    """
    lon_rad = math.radians(lon)
    lat_rad = math.radians(lat)

    x = R * lon_rad
    y = R * math.log(math.tan(math.pi/4 + lat_rad/2))

    return (x, y)

# 生成训练数据
train_data, train_targets = generate_training_data(
    mercator_projection,
    num_samples=50000
)
```

**训练过程：**

```python
def train_neural_projection(model, train_data, train_targets,
                           epochs=100, batch_size=256, learning_rate=0.001):
    """
    训练神经网络投影模型
    """
    optimizer = torch.optim.Adam(model.parameters(), lr=learning_rate)
    criterion = nn.MSELoss()

    num_samples = len(train_data)

    for epoch in range(epochs):
        total_loss = 0.0

        # 小批量训练
        for i in range(0, num_samples, batch_size):
            batch_end = min(i + batch_size, num_samples)

            batch_data = train_data[i:batch_end]
            batch_targets = train_targets[i:batch_end]

            # 前向传播
            optimizer.zero_grad()
            predictions = model(batch_data)

            # 计算损失
            loss = criterion(predictions, batch_targets)

            # 反向传播
            loss.backward()
            optimizer.step()

            total_loss += loss.item() * (batch_end - i)

        avg_loss = total_loss / num_samples

        if (epoch + 1) % 10 == 0:
            print(f'Epoch {epoch+1}, Average Loss: {avg_loss:.6f}')

        # 保存检查点
        if (epoch + 1) % 50 == 0:
            torch.save(model.state_dict(), f'projection_model_epoch_{epoch+1}.pth')

    return model
```

**模型评估：**

```python
def evaluate_projection_quality(model, true_projection_func, test_points=100):
    """
    评估神经网络投影的质量

    参数：
        model: 训练好的神经网络模型
        true_projection_func: 真实投影函数
        test_points: 测试点数量
    """
    model.eval()

    # 生成测试点
    lons = np.linspace(-170, 170, test_points)
    lats = np.linspace(-70, 70, test_points)

    errors = []
    length_errors = []
    area_errors = []

    with torch.no_grad():
        for lon in lons:
            for lat in lats:

                # 真实投影坐标
                x_true, y_true = true_projection_func(lon, lat)

                # 神经网络预测
                input_tensor = torch.tensor([[lon, lat]], dtype=torch.float32)
                x_pred, y_pred = model(input_tensor).squeeze().numpy()

                # 位置误差
                position_error = math.sqrt((x_pred - x_true)**2 + (y_pred - y_true)**2)
                errors.append(position_error)

    # 统计结果
    error_array = np.array(errors)

    return {
        'max_error': np.max(error_array),
        'mean_error': np.mean(error_array),
        'median_error': np.median(error_array),
        'std_error': np.std(error_array),
        'error_distribution': error_array
    }
```

### 8.3.2 强化学习优化投影参数

投影通常包含多个可调参数（如标准纬线、中心经线等），可以使用强化学习自动寻找最优参数组合。

#### OpenAI Gym投影环境

```python
import gym
from gym import spaces
import numpy as np

class ProjectionOptimizationEnv(gym.Env):
    """
    投影参数优化环境

    状态（State）：当前失真度量
    动作（Action）：调整投影参数（如标准纬线）
    奖励（Reward）：失真减少的程度
    """
    def __init__(self, projection_type='mercator', region_bounds=(-180, 180, -80, 80)):
        super(ProjectionOptimizationEnv, self).__init__()

        self.projection_type = projection_type
        self.region_bounds = region_bounds

        # 动作空间：调整参数
        # 对于墨卡托投影，只有一个主要参数：标准纬线
        self.action_space = spaces.Box(low=-5.0, high=5.0, shape=(1,), dtype=np.float32)

        # 状态空间：失真指标
        # [Airy损失, Jordan损失, Tissot最大角度失真]
        self.observation_space = spaces.Box(low=-np.inf, high=np.inf, shape=(3,), dtype=np.float32)

        # 初始参数
        self.current_params = {
            'standard_parallels': [0.0]  # 赤道
        }

        self.current_state = None

    def reset(self):
        """重置环境到初始状态"""
        self.current_params = {
            'standard_parallels': [np.random.uniform(-60, 60)]
        }

        self.current_state = self._get_state()
        return self.current_state

    def step(self, action):
        """执行一步优化"""
        # 更新参数
        old_standard_parallel = self.current_params['standard_parallels'][0]
        new_standard_parallel = old_standard_parallel + action[0]

        # 限制在合理范围
        new_standard_parallel = np.clip(new_standard_parallel, -80, 80)

        self.current_params['standard_parallels'] = [new_standard_parallel]

        # 计算新状态
        new_state = self._get_state()

        # 计算奖励（失真减少为正奖励）
        if self.current_state is not None:
            reward = self.current_state[0] - new_state[0]  # 简化：取Airy损失减少
        else:
            reward = 0.0

        # 判断是否收敛
        done = abs(action[0]) < 0.01

        self.current_state = new_state

        return new_state, reward, done, {}

    def _get_state(self):
        """计算当前状态的失真指标"""
        # 计算各种失真指标
        airy_loss = self._compute_airy_loss()
        jordan_loss = self._compute_jordan_loss()
        tissot_max = self._compute_max_tissot()

        return np.array([airy_loss, jordan_loss, tissot_max], dtype=np.float32)

    def _compute_airy_loss(self):
        """计算Airy平均误差"""
        # 简化实现：在网格上采样
        lats = np.linspace(-70, 70, 50)

        errors = []
        std_parallel = self.current_params['standard_parallels'][0]

        for lat in lats:
            # 计算局部面积比
            # 这里使用简化公式，实际应使用完整投影公式
            area_scale = 1.0 / math.cos(math.radians(lat)) / math.cos(math.radians(std_parallel))
            error = (area_scale - 1.0)**2
            errors.append(error)

        return np.mean(errors)

    def _compute_jordan_loss(self):
        """计算Jordan最大误差"""
        lats = np.linspace(-70, 70, 50)

        max_error = 0.0
        std_parallel = self.current_params['standard_parallels'][0]

        for lat in lats:
            area_scale = 1.0 / math.cos(math.radians(lat)) / math.cos(math.radians(std_parallel))
            error = abs(area_scale - 1.0)
            max_error = max(max_error, error)

        return max_error

    def _compute_max_tissot(self):
        """计算最大Tissot角度失真"""
        # 简化实现
        return 0.0  # 墨卡托投影是保角的
```

#### DQN训练

```python
import torch
import torch.nn as nn
import torch.optim as optim
from collections import deque
import random

class DQN(nn.Module):
    """
    Deep Q-Network用于投影参数优化
    """
    def __init__(self, state_dim, action_dim):
        super(DQN, self).__init__()

        self.fc1 = nn.Linear(state_dim, 128)
        self.fc2 = nn.Linear(128, 128)
        self.fc3 = nn.Linear(128, action_dim)

        self.relu = nn.ReLU()

    def forward(self, x):
        x = self.relu(self.fc1(x))
        x = self.relu(self.fc2(x))
        x = self.fc3(x)
        return x

class DQNAgent:
    """
    DQN智能体
    """
    def __init__(self, state_dim, action_dim, learning_rate=0.001):
        self.state_dim = state_dim
        self.action_dim = action_dim

        self.q_network = DQN(state_dim, action_dim)
        self.target_network = DQN(state_dim, action_dim)

        self.target_network.load_state_dict(self.q_network.state_dict())

        self.optimizer = optim.Adam(self.q_network.parameters(), lr=learning_rate)

        self.replay_buffer = deque(maxlen=10000)

        self.epsilon = 1.0
        self.epsilon_decay = 0.995
        self.epsilon_min = 0.01

        self.gamma = 0.99

    def act(self, state):
        """选择动作"""
        if np.random.random() < self.epsilon:
            # 探索：随机动作
            action = np.random.uniform(-5, 5, self.action_dim)
        else:
            # 利用：选择最优动作
            state_tensor = torch.FloatTensor(state).unsqueeze(0)
            q_values = self.q_network(state_tensor)
            action = q_values.argmax().detach().numpy()

        return action

    def train(self, batch_size=64):
        """训练网络"""
        if len(self.replay_buffer) < batch_size:
            return

        # 采样小批量
        batch = random.sample(self.replay_buffer, batch_size)
        states, actions, rewards, next_states, dones = zip(*batch)

        states = torch.FloatTensor(states)
        actions = torch.FloatTensor(actions)
        rewards = torch.FloatTensor(rewards)
        next_states = torch.FloatTensor(next_states)
        dones = torch.FloatTensor(dones)

        # 计算当前Q值
        q_values = self.q_network(states).gather(1, actions.long().unsqueeze(1))

        # 计算目标Q值
        next_q_values = self.target_network(next_states).max(1)[0].detach()
        target_q_values = rewards + (1 - dones) * self.gamma * next_q_values

        # 计算损失
        loss = nn.MSELoss()(q_values.squeeze(), target_q_values)

        # 优化
        self.optimizer.zero_grad()
        loss.backward()
        self.optimizer.step()

        # 更新epsilon
        if self.epsilon > self.epsilon_min:
            self.epsilon *= self.epsilon_decay

    def update_target_network(self):
        """更新目标网络"""
        self.target_network.load_state_dict(self.q_network.state_dict())

    def remember(self, state, action, reward, next_state, done):
        """存储经验"""
        self.replay_buffer.append((state, action, reward, next_state, done))

# 训练循环
def train_projection_optimizer(env, agent, episodes=500):
    """
    训练投影参数优化器
    """
    rewards_history = []
    best_params = None
    best_reward = -np.inf

    for episode in range(episodes):
        state = env.reset()
        total_reward = 0.0

        for step in range(200):  # 每个episode最多200步
            # 选择动作
            action = agent.act(state)

            # 执行动作
            next_state, reward, done, _ = env.step(action)

            # 存储经验
            agent.remember(state, action, reward, next_state, done)

            # 训练
            agent.train()

            state = next_state
            total_reward += reward

            if done:
                break

        # 更新目标网络
        agent.update_target_network()

        rewards_history.append(total_reward)

        # 记录最佳参数
        if total_reward > best_reward:
            best_reward = total_reward
            best_params = env.current_params.copy()

        if episode % 50 == 0:
            print(f"Episode {episode}, Total Reward: {total_reward:.4f}, Epsilon: {agent.epsilon:.4f}")
            print(f"Best params: {best_params}")

    return best_params, rewards_history
```

### 8.3.3 生成对抗网络投影

生成对抗网络（GAN）可用于学习改进后的投影变换，减少失真。

#### 投影GAN架构

```python
class ProjectionGAN:
    """
    用于投影优化的生成对抗网络
    """
    def __init__(self, latent_dim=2, output_dim=2):
        self.latent_dim = latent_dim
        self.output_dim = output_dim

        # 生成器：学习低失真投影
        self.generator = self._build_generator(latent_dim, output_dim)

        # 判别器：判断投影质量
        self.discriminator = self._build_discriminator(output_dim)

        # 优化器
        self.g_optimizer = torch.optim.Adam(self.generator.parameters(), lr=0.0002)
        self.d_optimizer = torch.optim.Adam(self.discriminator.parameters(), lr=0.0002)

        # 损失函数
        self.criterion = nn.BCELoss()

    def _build_generator(self, input_dim, output_dim):
        """构建生成器网络"""
        return nn.Sequential(
            nn.Linear(input_dim, 64),
            nn.LeakyReLU(0.2),

            nn.Linear(64, 128),
            nn.BatchNorm1d(128),
            nn.LeakyReLU(0.2),

            nn.Linear(128, 256),
            nn.BatchNorm1d(256),
            nn.LeakyReLU(0.2),

            nn.Linear(256, output_dim)
        )

    def _build_discriminator(self, input_dim):
        """构建判别器网络"""
        return nn.Sequential(
            nn.Linear(input_dim, 256),
            nn.LeakyReLU(0.2),

            nn.Linear(256, 128),
            nn.BatchNorm1d(128),
            nn.LeakyReLU(0.2),

            nn.Linear(128, 64),
            nn.BatchNorm1d(64),
            nn.LeakyReLU(0.2),

            nn.Linear(64, 1),
            nn.Sigmoid()
        )

    def train(self, real_projections, epochs=200, batch_size=64):
        """
        训练GAN

        参数：
            real_projections: 真实投影数据（高质量参考）
            epochs: 训练轮数
            batch_size: 批大小
        """
        num_samples = len(real_projections)

        for epoch in range(epochs):
            for i in range(0, num_samples, batch_size):
                batch_end = min(i + batch_size, num_samples)
                real = torch.FloatTensor(real_projections[i:batch_end])

                batch_size_actual = batch_end - i

                # 训练判别器
                self.d_optimizer.zero_grad()

                # 真实投影
                real_labels = torch.ones(batch_size_actual, 1)
                real_output = self.discriminator(real)
                real_loss = self.criterion(real_output, real_labels)

                # 生成的投影（噪声输入）
                noise = torch.randn(batch_size_actual, self.latent_dim)
                fake = self.generator(noise)
                fake_labels = torch.zeros(batch_size_actual, 1)
                fake_output = self.discriminator(fake.detach())
                fake_loss = self.criterion(fake_output, fake_labels)

                # 判别器总损失
                d_loss = real_loss + fake_loss
                d_loss.backward()
                self.d_optimizer.step()

                # 训练生成器
                self.g_optimizer.zero_grad()

                noise = torch.randn(batch_size_actual, self.latent_dim)
                fake = self.generator(noise)
                fake_output = self.discriminator(fake)

                # 生成器希望判别器认为它是真实的
                g_loss = self.criterion(fake_output, real_labels)
                g_loss.backward()
                self.g_optimizer.step()

            if epoch % 20 == 0:
                print(f"Epoch {epoch}, D_loss: {d_loss.item():.4f}, G_loss: {g_loss.item():.4f}")
```

### 8.3.4 自编码器投影压缩

自动编码器可用于学习投影的紧凑表示，实现高效存储和传输。

#### 投影自编码器

```python
class ProjectionAutoencoder(nn.Module):
    """
    投影变换自编码器

    编码器：经纬度 → 潜在表示
    解码器：潜在表示 → 平面坐标
    """
    def __init__(self, latent_dim=16):
        super(ProjectionAutoencoder, self).__init__()
        self.latent_dim = latent_dim

        # 编码器
        self.encoder = nn.Sequential(
            nn.Linear(2, 64),
            nn.Tanh(),

            nn.Linear(64, 128),
            nn.Tanh(),

            nn.Linear(128, latent_dim)
        )

        # 解码器
        self.decoder = nn.Sequential(
            nn.Linear(latent_dim, 128),
            nn.Tanh(),

            nn.Linear(128, 64),
            nn.Tanh(),

            nn.Linear(64, 2)
        )

    def forward(self, x):
        encoded = self.encoder(x)
        decoded = self.decoder(encoded)
        return decoded

    def get_latent_representation(self, x):
        """获取潜在表示"""
        return self.encoder(x)

def train_autoencoder(model, data_loader, epochs=100, learning_rate=0.001):
    """
    训练自编码器

    参数：
        model: 自编码器模型
        data_loader: 数据加载器
        epochs: 训练轮数
        learning_rate: 学习率
    """
    optimizer = torch.optim.Adam(model.parameters(), lr=learning_rate)
    criterion = nn.MSELoss()

    for epoch in range(epochs):
        total_loss = 0.0

        for batch in data_loader:
            lon_lat, xy_target = batch

            # 前向传播
            xy_pred = model(lon_lat)

            # 计算损失
            loss = criterion(xy_pred, xy_target)

            # 反向传播
            optimizer.zero_grad()
            loss.backward()
            optimizer.step()

            total_loss += loss.item()

        avg_loss = total_loss / len(data_loader)

        if (epoch + 1) % 10 == 0:
            print(f'Epoch {epoch+1}, Average Loss: {avg_loss:.6f}')

            # 可视化压缩率
            encoded = model.get_latent_representation(lon_lat[:100])
            print(f'Encoded shape: {encoded.shape}, Latent dim: {model.latent_dim}')

    return model
```

---

## 8.4 现代数学技术在经典投影中的应用

### 8.4.1 小波分析投影失真

小波变换提供了一种多尺度分析工具，可用于局部化评估投影失真。

#### 小波变换基础

**连续小波变换（CWT）：**

$$
W_f(a, b) = \frac{1}{\sqrt{a}} \int_{-\infty}^{\infty} f(t) \psi\left(\frac{t-b}{a}\right) dt
$$

其中 $a$ 是尺度参数， $b$ 是平移参数， $\psi$ 是小波母函数。

**离散小波变换（DWT）：**

通过选择 $a = 2^j$ 和 $b = k 2^j$ ，得到离散小波变换：

$$
W_{j,k} = \frac{1}{\sqrt{2^j}} \int f(t) \psi\left(\frac{t}{2^j} - k\right) dt
$$

#### 投影失真的小波分析

```python
import pywt

def wavelet_distortion_analysis(original_grid, projected_grid,
                                wavelet='db4', levels=5):
    """
    使用小波分析比较原始和投影后数据的失真

    参数：
        original_grid: 原始球面数据（二维数组）
        projected_grid: 投影后数据（二维数组）
        wavelet: 小波类型（如 'db4', 'haar', 'sym2'）
        levels: 分解层数
    """
    # 执行二维离散小波变换
    coeffs_orig = pywt.wavedec2(original_grid, wavelet, level=levels)
    coeffs_proj = pywt.wavedec2(projected_grid, wavelet, level=levels)

    # 分析各层的失真
    distortion_by_level = []

    for level in range(levels + 1):
        # 每层包含三个子带：水平(H)、垂直(V)、对角(D)
        # 或低通近似(LL)
        if level == 0:
            # 最低频近似
            diff = np.abs(coeffs_orig[level] - coeffs_proj[level])
            energy_loss = np.sum(diff**2)
        else:
            # 高频细节
            h, v, d = coeffs_orig[level]
            h_p, v_p, d_p = coeffs_proj[level]

            # 计算能量损失
            energy_loss_h = np.sum((h - h_p)**2)
            energy_loss_v = np.sum((v - v_p)**2)
            energy_loss_d = np.sum((d - d_p)**2)

            energy_loss = energy_loss_h + energy_loss_v + energy_loss_d

        distortion_by_level.append({
            'level': level,
            'energy_loss': energy_loss,
            'relative_loss': energy_loss / np.sum(np.array(coeffs_orig[level])**2)
        })

    # 计算总失真指标
    total_energy_orig = sum(np.sum(np.array(c)**2) if isinstance(c, tuple)
                           else np.sum(c**2) for c in coeffs_orig)
    total_loss = sum(d['energy_loss'] for d in distortion_by_level)

    overall_distortion = total_loss / total_energy_orig

    return {
        'overall_distortion': overall_distortion,
        'distortion_by_level': distortion_by_level
    }

# 示例使用
def generate_test_data(size=256):
    """生成测试数据"""
    x = np.linspace(-5, 5, size)
    y = np.linspace(-5, 5, size)
    xx, yy = np.meshgrid(x, y)

    # 原始数据：高斯函数
    original = np.exp(-(xx**2 + yy**2))

    # 投影后数据：添加失真
    projected = original * (1 + 0.1 * np.sin(3 * xx) * np.cos(3 * yy))

    return original, projected

original, projected = generate_test_data(256)
analysis = wavelet_distortion_analysis(original, projected)

print(f"Overall distortion: {analysis['overall_distortion']:.6f}")
for level_info in analysis['distortion_by_level']:
    print(f"Level {level_info['level']}: {level_info['relative_loss']:.6f}")
```

#### 小波包用于多分辨率分析

```python
def wavelet_packet_analysis(data, wavelet='db4', max_level=4):
    """
    使用小波包进行详细的多分辨率失真分析
    """
    wp_orig = pywt.WaveletPacket(data, wavelet, mode='symmetric', maxlevel=max_level)
    wp_proj = pywt.WaveletPacket(data * (1 + 0.1 * np.random.randn(*data.shape)),
                                 wavelet, mode='symmetric', maxlevel=max_level)

    # 收集所有节点的能量
    nodes_orig = [node.path for node in wp_orig.get_level(max_level, 'natural')]
    distortion_by_node = []

    for node_path in nodes_orig:
        node_orig = wp_orig[node_path]
        node_proj = wp_proj[node_path]

        energy_orig = np.sum(node_orig.data**2)
        energy_proj = np.sum(node_proj.data**2)

        relative_loss = abs(energy_proj - energy_orig) / (energy_orig + 1e-10)

        distortion_by_node.append({
            'node': node_path,
            'energy_orig': energy_orig,
            'energy_proj': energy_proj,
            'relative_loss': relative_loss
        })

    return {
        'distortion_by_node': distortion_by_node,
        'max_loss': max(d['relative_loss'] for d in distortion_by_node),
        'mean_loss': np.mean([d['relative_loss'] for d in distortion_by_node])
    }
```

### 8.4.2 分数阶微积分投影

分数阶微积分（Fractional Calculus）扩展了传统微积分的概念，可用于更精确地描述失真的渐进行为。

#### 分数阶导数

**Riemann-Liouville分数阶导数：**

$$
D^a f(x) = \frac{1}{\Gamma(n-a)} \frac{d^n}{dx^n} \int_a^x \frac{f(t)}{(x-t)^{a-n+1}} dt
$$

其中 $n-1 < a < n$ ， $\Gamma$ 是伽马函数。

**Caputo分数阶导数：**

$$
D^a f(x) = \frac{1}{\Gamma(n-a)} \int_a^x \frac{f^{(n)}(t)}{(x-t)^{a-n+1}} dt
$$

#### 投影失真的分数阶分析

```python
def fractional_derivative_numeric(data, alpha, h=0.01):
    """
    数值计算分数阶导数（基于Grünwald-Letnikov定义）

    参数：
        data: 输入数据
        alpha: 分数阶
        h: 步长
    """
    n = len(data)
    result = np.zeros_like(data)

    # 计算 Grünwald-Letnikov 系数
    def grunwald_letnikov_coefs(a, k):
        """计算Grünwald-Letnikov系数"""
        if k == 0:
            return 1.0

        coef = (k - 1 - a) * grunwald_letnikov_coefs(a, k-1) / k
        return coef

    # 计算分数阶导数
    for i in range(n):
        sum_val = 0.0
        for k in range(i + 1):
            coef = grunwald_letnikov_coefs(alpha, k)
            sum_val += coef * data[i - k]

        result[i] = sum_val / (h**alpha)

    return result

def analyze_projection_fractional(proj_func, lon_range=(-180, 180),
                                 lat_range=(-80, 80), alpha=0.5):
    """
    使用分数阶微积分分析投影变换
    """
    # 沿经线方向采样
    lats = np.linspace(lat_range[0], lat_range[1], 200)
    lon_fixed = 0.0

    # 计算投影坐标y（墨卡托投影y主要随纬度变化）
    y_values = np.array([proj_func(lon_fixed, lat)[1] for lat in lats])

    # 计算一阶导数
    dy_dlat_numerical = np.gradient(y_values, lats)

    # 计算分数阶导数
    dy_dlat_fractional = fractional_derivative_numeric(y_values, alpha=alpha, h=lats[1]-lats[0])

    # 分析差异
    difference = dy_dlat_fractional - dy_dlat_numerical

    return {
        'latitudes': lats,
        'first_derivative': dy_dlat_numerical,
        'fractional_derivative': dy_dlat_fractional,
        'difference': difference,
        'max_difference': np.max(np.abs(difference)),
        'mean_difference': np.mean(np.abs(difference))
    }

# 示例分析
def mercator_projection(lon, lat, R=6378137.0):
    """墨卡托投影"""
    x = R * math.radians(lon)
    y = R * math.log(math.tan(math.pi/4 + math.radians(lat)/2))
    return (x, y)

analysis = analyze_projection_fractional(mercator_projection, alpha=0.5)
print(f"Max difference between fractional and integer order derivatives: {analysis['max_difference']:.6f}")
```

#### 分数阶积分

```python
def fractional_integral_numeric(data, alpha, h=0.01):
    """
    数值计算分数阶积分
    """
    n = len(data)
    result = np.zeros(n)

    for i in range(n):
        sum_val = 0.0

        for k in range(i + 1):
            # 梯形法则的分数阶扩展
            if k == 0:
                weight = 0.5
            elif k == i:
                weight = 0.5
            else:
                weight = 1.0

            term = weight * data[k] * (i - k)**(alpha - 1)
            sum_val += term

        result[i] = sum_val / (math.gamma(alpha) * h**(alpha - 1))

    return result

def compare_fractional_orders(proj_func, alphas=[0.25, 0.5, 0.75, 1.0]):
    """
    比较不同分数阶的分析结果
    """
    lats = np.linspace(-70, 70, 100)
    results = {}

    for alpha in alphas:
        dy_dlat = np.gradient([proj_func(0, lat)[1] for lat in lats], lats)
        dy_dlat_frac = fractional_derivative_numeric(dy_dlat, alpha=alpha, h=lats[1]-lats[0])

        results[alpha] = {
            'lats': lats,
            'fractional_derivative': dy_dlat_frac,
            'max_value': np.max(np.abs(dy_dlat_frac)),
            'mean_value': np.mean(np.abs(dy_dlat_frac))
        }

    return results
```

### 8.4.3 拓扑数据分析投影质量

拓扑数据分析（Topological Data Analysis, TDA）提供了一种不依赖于坐标系的空间分析方法。

#### 持续同调（Persistent Homology）

持久同调通过分析数据的拓扑特征（连通分量、空洞等）在不同尺度下的持续情况来理解数据结构。

```python
import numpy as np
from scipy.spatial import Delaunay, ConvexHull

def compute_persistent_homology(points, max_distance=1.0, num_levels=50):
    """
    计算持久同调（简化版本）

    参数：
        points: 数据点 (n, 2)
        max_distance: 最大距离阈值
        num_levels: 距离阈值数量
    """
    # 计算点间距离矩阵
    from scipy.spatial.distance import pdist, squareform
    distances = squareform(pdist(points))

    # 生成距离阈值序列
    thresholds = np.linspace(0, max_distance, num_levels)

    # 追踪连通分量（0维持久同调）
    # 使用并查集（Union-Find）数据结构
    parent = list(range(len(points)))
    rank = [0] * len(points))

    def find(x):
        if parent[x] != x:
            parent[x] = find(parent[x])
        return parent[x]

    def union(x, y):
        px, py = find(x), find(y)
        if px == py:
            return False
        if rank[px] < rank[py]:
            parent[px] = py
        elif rank[px] > rank[py]:
            parent[py] = px
        else:
            parent[py] = px
            rank[px] += 1
        return True

    persistence_diagram = []

    prev_components = len(points)

    for i, threshold in enumerate(thresholds):
        # 添加距离小于阈值的边
        for j in range(len(points)):
            for k in range(j + 1, len(points)):
                if distances[j, k] <= threshold:
                    if union(j, k):
                        # 合并发生，记录诞生-死亡对
                        # 这里简化处理，实际需要更复杂的追踪
                        pass

        # 计算当前连通分量数
        current_components = len(set(find(i) for i in range(len(points))))

        components_born = prev_components - current_components
        if components_born > 0:
            # 记录诞生点
            persistence_diagram.append({
                'birth': threshold,
                'death': None,  # 尚未死亡
                'dimension': 0
            })

        prev_components = current_components

    return {
        'persistence_diagram': persistence_diagram,
        'thresholds': thresholds,
        'components_over_scale': [len(set(find(i) for i in range(len(points))))
                                   for threshold in thresholds]
    }

def compare_projection_topology(original_grid, projected_grid, num_points=100):
    """
    比较原始和投影数据的拓扑结构
    """
    # 随机采样点
    idx = np.random.choice(original_grid.shape[0]*original_grid.shape[1],
                          num_points, replace=False)
    row_idx, col_idx = np.unravel_index(idx, original_grid.shape)

    # 提取点坐标
    points_original = np.column_stack([row_idx, col_idx])
    points_projected = np.column_stack([projected_grid[row_idx, col_idx, 0],
                                       projected_grid[row_idx, col_idx, 1]])

    # 计算持久同调
    ph_original = compute_persistent_homology(points_original, max_distance=200.0)
    ph_projected = compute_persistent_homology(points_projected, max_distance=200.0)

    # 比较连通分量随尺度的变化
    diff_components = np.array(ph_original['components_over_scale']) - \
                      np.array(ph_projected['components_over_scale'])

    return {
        'difference_over_scale': diff_components,
        'max_difference': np.max(np.abs(diff_components)),
        'mean_difference': np.mean(np.abs(diff_components)),
        'ph_original': ph_original,
        'ph_projected': ph_projected
    }
```

#### Morse理论分析

Morse理论研究函数的临界点及其拓扑意义。

```python
def compute_morse_complex(grid_data):
    """
    计算Morse分解（简化版）

    识别极大值、极小值和鞍点
    """
    from scipy.ndimage import label, maximum_filter, minimum_filter

    # 识别局部极大值
    local_max = maximum_filter(grid_data, size=3) == grid_data

    # 识别局部极小值
    local_min = minimum_filter(grid_data, size=3) == grid_data

    # 统计临界点
    num_maxima = np.sum(local_max)
    num_minima = np.sum(local_min)

    # 简化的鞍点识别（基于梯度近似）
    from scipy.ndimage import sobel
    grad_x = sobel(grid_data, axis=1)
    grad_y = sobel(grid_data, axis=0)
    grad_mag = np.sqrt(grad_x**2 + grad_y**2)

    # 梯度接近零但不是极值的点为鞍点
    saddle_candidates = (grad_mag < 0.1) & (~local_max) & (~local_min)
    num_saddles = np.sum(saddle_candidates)

    # 欧拉示性数（Euler characteristic）验证
    # 对于二维封闭曲面：V - E + F = 2
    # 简化的Morse不等式：#minima - #saddles + #maxima = χ(disk) = 1

    euler_char = num_minima - num_saddles + num_maxima

    return {
        'num_minima': num_minima,
        'num_maxima': num_maxima,
        'num_saddles': num_saddles,
        'euler_characteristic': euler_char,
        'saddle_candidates': saddle_candidates
    }

def analyze_projection_morse(original_data, projected_data):
    """
    使用Morse理论比较投影前后
    """
    morse_orig = compute_morse_complex(original_data)
    morse_proj = compute_morse_complex(projected_data)

    # 比较临界点变化
    critical_point_change = {
        'minima_difference': morse_proj['num_minima'] - morse_orig['num_minima'],
        'maxima_difference': morse_proj['num_maxima'] - morse_orig['num_maxima'],
        'saddles_difference': morse_proj['num_saddles'] - morse_orig['num_saddles'],
        'euler_difference': morse_proj['euler_characteristic'] -
                           morse_orig['euler_characteristic']
    }

    return {
        'morse_original': morse_orig,
        'morse_projected': morse_proj,
        'critical_point_change': critical_point_change
    }
```

### 8.4.4 稀疏表示与字典学习

稀疏表示理论可用于压缩和高效表示投影数据。

#### K-SVD字典学习

```python
from sklearn.decomposition import MiniBatchDictionaryLearning
from sklearn.feature_extraction.image import extract_patches_2d

def learn_sparse_dictionary(proj_data, patch_size=(8, 8),
                           n_components=100, n_samples=10000):
    """
    学习投影数据的稀疏字典

    参数：
        proj_data: 投影数据 (height, width)
        patch_size: 图像块大小
        n_components: 字典原子数量
        n_samples: 采样数量
    """
    # 归一化数据
    data_normalized = (proj_data - proj_data.mean()) / (proj_data.std() + 1e-10)

    # 提取图像块
    patches = extract_patches_2d(data_normalized, patch_size, max_patches=n_samples,
                                 random_state=42)

    # 展平图像块
    patches = patches.reshape(patches.shape[0], -1)

    # 字典学习
    dict_learner = MiniBatchDictionaryLearning(
        n_components=n_components,
        batch_size=500,
        alpha=1.0,  # 稀疏性参数
        max_iter=50,
        random_state=42
    )

    dictionary = dict_learner.fit(patches).components_

    # 稀疏编码
    sparse_codes = dict_learner.transform(patches)

    # 重建误差
    reconstructed = np.dot(sparse_codes, dictionary)
    reconstruction_error = np.mean((patches - reconstructed) ** 2)

    return {
        'dictionary': dictionary.reshape(n_components, *patch_size),
        'sparse_codes': sparse_codes,
        'reconstruction_error': reconstruction_error,
        'compression_ratio': (patches.shape[1] * patches.shape[0]) /
                           (sparse_codes.size + dictionary.size)
    }

def apply_sparse_representation(proj_data, dictionary, patch_size=(8, 8)):
    """
    使用学习到的字典表示投影数据
    """
    from sklearn.linear_model import OrthogonalMatchingPursuit

    height, width = proj_data.shape
    patches = extract_patches_2d(proj_data, patch_size)
    n_patches = patches.shape[0]

    # 展平字典
    dictionary_flat = dictionary.reshape(len(dictionary), -1)
    patches_flat = patches.reshape(n_patches, -1)

    # 稀疏编码
    omp = OrthogonalMatchingPursuit(n_nonzero_coefs=5)
    sparse_codes = omp.fit_transform(dictionary_flat, patches_flat)

    # 重建
    reconstructed_flat = sparse_codes @ dictionary_flat
    reconstructed = reconstructed_flat.reshape(n_patches, *patch_size)

    # 组合重建图像
    reconstructed_image = np.zeros_like(proj_data)
    counts = np.zeros_like(proj_data)

    for i in range(n_patches):
        # 计算块位置
        h = i // (width - patch_size[1] + 1)
        w = i % (width - patch_size[1] + 1)

        # 累加
        reconstructed_image[h:h+patch_size[0], w:w+patch_size[1]] += reconstructed[i]
        counts[h:h+patch_size[0], w:w+patch_size[1]] += 1

    # 平均重叠区域
    reconstructed_image /= (counts + 1e-10)

    return reconstructed_image
```

---

## 8.5 本章小结

现代误差分析与质量度量体系结合了经典几何理论、计算方法和先进数学工具，为投影质量的精确评估和优化提供了全面的框架。

**主要内容总结：**

1. **定量失真指标**：
   - 从基本的长度、角度、面积失真到综合的Arends、Goldberg-Gott指标
   - 信息论方法（熵、互信息）提供了新的失真度量视角
   - Airy和Jordan准则分别从平均和最大角度衡量整体失真

2. **机器学习应用**：
   - 神经网络可学习复杂投影变换，可能发现新的投影规律
   - 强化学习自动优化投影参数，实现自适应投影
   - 生成对抗网络降低投影失真，生成高质量投影
   - 自编码器实现投影压缩和高效存储

3. **现代数学技术**：
   - 小波分析提供多尺度失真评估
   - 分数阶微积分描述失真渐进行为
   - 拓扑数据分析（TDA）不依赖坐标系评估空间结构保持
   - 稀疏表示实现投影压缩和高效传输

**发展趋势：**

1. **智能化**：机器学习将使投影优化更加自动化和智能化
2. **多目标优化**：同时考虑多种失真类型的帕累托优化
3. **实时应用**：GPU加速和近似算法支持实时投影
4. **个性化投影**：根据用户需求和数据特性自适应选择投影

现代误差分析与质量度量不仅解决了传统方法难以处理的问题，还为制图学开辟了新的研究方向。理解这些技术和应用，对于现代制图工作者和GIS开发者具有重要意义。
