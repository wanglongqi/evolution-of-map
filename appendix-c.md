---
nav_order: 16
---

# 附录 C: 数学推导集合

本附录收集了全书所有关键地图投影公式的数学推导，包括墨卡托投影、横轴墨卡托投影、各种等角/等积/等距投影的完整推导过程，以及Tissot指示椭圆参数的系统推导。这些推导采用严谨的数学表述，从基本原理出发，逐步构建投影的数学框架。


## C.1 墨卡托投影推导

### C.1.1 问题定义与等角条件

设地球为半径 $R$ 的球体，建立球面坐标系 $(\lambda, \phi)$ 到平面坐标系 $(x, y)$ 的映射：

$$
x = f(\lambda, \phi)
$$

$$
y = g(\lambda, \phi)
$$

其中：
- $\lambda \in [-\pi, \pi]$ 为经度（longitude）
- $\phi \in [-\pi/2, \pi/2]$ 为纬度（latitude）
- $x, y$ 为平面坐标

**等角条件（Conformal Condition）**：投影在局部保持角度不变，即球面上任意一点的微小区域与投影平面上对应区域的形状相似。

### C.1.2 球面线元素

在球面上，沿经度方向的微元长度：

$$
dL_\lambda = R \cos(\phi) \, d\lambda
$$

沿纬度方向的微元长度：

$$
dL_\phi = R \, d\phi
$$

### C.1.3 投影平面线元素

投影后，平面上的微元长度为：

沿经度方向：

$$
dl_\lambda = \sqrt{\left(\frac{\partial x}{\partial \lambda}\right)^2 + \left(\frac{\partial y}{\partial \lambda}\right)^2} \, d\lambda
$$

沿纬度方向：

$$
dl_\phi = \sqrt{\left(\frac{\partial x}{\partial \phi}\right)^2 + \left(\frac{\partial y}{\partial \phi}\right)^2} \, d\phi
$$

### C.1.4 等角条件的数学表述

等角性要求两个方向的比例因子相等：

$$
\frac{dl_\lambda}{dL_\lambda} = \frac{dl_\phi}{dL_\phi} = k(\lambda, \phi)
$$

其中 $k(\lambda, \phi)$ 为局部比例因子（scale factor）。

显式表示为：

$$
\frac{\sqrt{\left(\frac{\partial x}{\partial \lambda}\right)^2 + \left(\frac{\partial y}{\partial \lambda}\right)^2}}{R \cos(\phi)} = \frac{\sqrt{\left(\frac{\partial x}{\partial \phi}\right)^2 + \left(\frac{\partial y}{\partial \phi}\right)^2}}{R}
$$

### C.1.5 简化假设

为了求解，采用以下合理假设：

1. **经度线性映射**：

   $$
x = R \lambda
$$

   这意味着：

   $$
\frac{\partial x}{\partial \lambda} = R, \quad \frac{\partial x}{\partial \phi} = 0
$$

2. **纬度独立映射**：

   $$
y = y(\phi)
$$

   这意味着：

   $$
\frac{\partial y}{\partial \lambda} = 0, \quad \frac{\partial y}{\partial \phi} = \frac{dy}{d\phi}
$$

### C.1.6 应用等角条件

将简化假设代入等角条件：

**经度方向比例因子**：

$$
h_\lambda = \frac{dl_\lambda}{dL_\lambda} = \frac{\sqrt{R^2 + 0}}{R \cos(\phi)} = \frac{R}{R \cos(\phi)} = \frac{1}{\cos(\phi)} = \sec(\phi)
$$

**纬度方向比例因子**：

$$
h_\phi = \frac{dl_\phi}{dL_\phi} = \frac{\sqrt{0 + \left(\frac{dy}{d\phi}\right)^2}}{R} = \frac{1}{R} \frac{dy}{d\phi}
$$

令 $h_\lambda = h_\phi$ ：

$$
\sec(\phi) = \frac{1}{R} \frac{dy}{d\phi}
$$

### C.1.7 关键微分方程与积分

得到关键微分方程：

$$
\frac{dy}{d\phi} = R \sec(\phi)
$$

积分求解：

$$
y = R \int \sec(\phi) \, d\phi
$$

使用标准积分公式：

$$
\int \sec(\phi) \, d\phi = \ln|\sec(\phi) + \tan(\phi)| + C
$$

使用等价形式（Gudermannian 函数相关）：

$$
\int \sec(\phi) \, d\phi = \ln\left[\tan\left(\frac{\pi}{4} + \frac{\phi}{2}\right)\right] + C
$$

这两个形式的等价性可通过三角恒等式证明：

$$
\tan\left(\frac{\pi}{4} + \frac{\phi}{2}\right) = \sec(\phi) + \tan(\phi)
$$

### C.1.8 墨卡托投影最终公式

结合 $x$ 和 $y$ 的表达式，得到完整的墨卡托投影公式：

$$
x = R \lambda
$$

$$
y = R \ln\left[\tan\left(\frac{\pi}{4} + \frac{\phi}{2}\right)\right]
$$

其中纬度 $\phi$ 使用弧度单位。

**角度单位实用公式**：

若 $\lambda, \phi$ 以角度单位表示：

$$
x = R \cdot \frac{\pi}{180} \cdot \lambda
$$

$$
y = R \ln\left[\tan\left(\frac{\pi}{4} + \frac{\pi \cdot \phi}{360}\right)\right]
$$

### C.1.9 墨卡托纬度（等量纬度）

定义墨卡托纬度（Isometric Latitude，又称高斯共轭纬度）：

$$
\psi(\phi) = \ln\left[\tan\left(\frac{\pi}{4} + \frac{\phi}{2}\right)\right]
$$

性质：
1. 奇函数： $\psi(-\phi) = -\psi(\phi)$
2. 单调递增： $\psi'(\phi) = \sec(\phi) > 0$ （对于 $\vert \phi\vert < \pi/2$ ）
3. 无界性： $\lim_{\phi \to \pm \pi/2} \psi(\phi) = \pm \infty$

### C.1.10 尺度因子分析

墨卡托投影的尺度因子：

$$
k(\phi) = \sec(\phi) = \frac{1}{\cos(\phi)}
$$

关键特征：
- 赤道（ $\phi = 0$ ）： $k = 1$ ，无变形
- 纬度 $\pm 60°$ ： $k = 2$ ，距离放大2倍
- 纬度 $\pm 75°$ ： $k \approx 3.86$
- 纬度 $\pm 85°$ ： $k \approx 11.47$
- 极点（ $\phi \to \pm 90°$ ）： $k \to \infty$

### C.1.11 面积变形

面积比例因子：

$$
p(\phi) = k^2(\phi) = \sec^2(\phi)
$$

在纬度 $\phi$ 处，球面微元面积 $dA_{sphere} = R^2 \cos(\phi) \, d\lambda \, d\phi$ ，投影后面积 $dA_{map} = R^2 \sec(\phi) \, d\lambda \cdot R \sec(\phi) \, d\phi = R^2 \sec^2(\phi) \cos(\phi) \, d\lambda \, d\phi$ ：

$$
\frac{dA_{map}}{dA_{sphere}} = \frac{R^2 \sec^2(\phi) \cos(\phi)}{R^2 \cos(\phi)} = \sec^2(\phi)
$$

在纬度 $\phi$ 处，球面微元面积 $dA_{sphere} = R^2 \cos(\phi) \, d\lambda \, d\phi$ ，投影后面积 $dA_{map} = R^2 \sec(\phi) \, d\lambda \, d\phi$ ：

$$
\frac{dA_{map}}{dA_{sphere}} = \frac{R^2 \sec(\phi)}{R^2 \cos(\phi)} = \sec^2(\phi)
$$

## C.2 等角航线（Rhumb Line）推导

### C.2.1 等角航线定义

等角航线（Rhumb line，又称恒向线或对数螺线）是球面上保持固定方位角（azimuth） $\alpha$ 的曲线。

### C.2.2 球面上的线元素

球面上的线元素（第一基本形式）：

$$
ds^2 = dl_\lambda^2 + dl_\phi^2 = R^2 \cos^2(\phi) \, d\lambda^2 + R^2 \, d\phi^2
$$

### C.2.3 等角条件的微分方程

等角条件要求切线与纬线方向的夹角 $\psi$ 为常数：

$$
\tan(\psi) = \frac{R \, d\phi}{R \cos(\phi) \, d\lambda} = \frac{d\phi}{\cos(\phi) \, d\lambda}
$$

因此得到等角航线的微分方程：

$$
\frac{d\phi}{d\lambda} = \tan(\psi) \cos(\phi)
$$

或等价形式：

$$
\frac{d\lambda}{d\phi} = \cot(\psi) \sec(\phi)
$$

### C.2.4 等角航线的解

对微分方程积分：

$$
\int d\lambda = \cot(\psi) \int \sec(\phi) \, d\phi
$$

$$
\lambda = \cot(\psi) \cdot \ln\left[\tan\left(\frac{\pi}{4} + \frac{\phi}{2}\right)\right] + C
$$

其中 $C$ 为积分常数，由初始条件确定。

这个解表明等角航线在经度-纬度平面中表现为对数曲线，这也是"loxodrome"名称的由来（希腊语"loxos"意为斜的，"dromos"意为路径）。

### C.2.5 墨卡托投影中等角航线的线性化

在墨卡托投影下：

$$
x = R \lambda
$$

$$
y = R \ln\left[\tan\left(\frac{\pi}{4} + \frac{\phi}{2}\right)\right]
$$

因此，在投影平面上：

$$
\frac{dy}{dx} = \frac{dy/d\phi}{dx/d\lambda} \cdot \frac{d\phi}{d\lambda}
$$

计算导数：

$$
\frac{dy}{d\phi} = R \sec(\phi), \quad \frac{dx}{d\lambda} = R
$$

使用等角航线微分方程 $\frac{d\phi}{d\lambda} = \tan(\psi) \cos(\phi)$ ：

$$
\frac{dy}{dx} = \frac{R \sec(\phi)}{R} \cdot \tan(\psi) \cos(\phi) = \tan(\psi)
$$

**这证明了墨卡托投影将球面的等角航线映射为平面上的直线**。


## C.3 第一基本形式与曲面的内蕴几何

### C.3.1 曲面的第一基本形式

设曲面 $S$ 由参数方程 $\mathbf{r}(u, v) = (x(u,v), y(u,v), z(u,v))$ 给出。

**第一基本形式**：

$$
ds^2 = E \, du^2 + 2F \, du \, dv + G \, dv^2
$$

其中系数为：

$$
E = \frac{\partial \mathbf{r}}{\partial u} \cdot \frac{\partial \mathbf{r}}{\partial u} = \left(\frac{\partial x}{\partial u}\right)^2 + \left(\frac{\partial y}{\partial u}\right)^2 + \left(\frac{\partial z}{\partial u}\right)^2
$$

$$
F = \frac{\partial \mathbf{r}}{\partial u} \cdot \frac{\partial \mathbf{r}}{\partial v} = \frac{\partial x}{\partial u}\frac{\partial x}{\partial v} + \frac{\partial y}{\partial u}\frac{\partial y}{\partial v} + \frac{\partial z}{\partial u}\frac{\partial z}{\partial v}
$$

$$
G = \frac{\partial \mathbf{r}}{\partial v} \cdot \frac{\partial \mathbf{r}}{\partial v} = \left(\frac{\partial x}{\partial v}\right)^2 + \left(\frac{\partial y}{\partial v}\right)^2 + \left(\frac{\partial z}{\partial v}\right)^2
$$

### C.3.2 球面的第一基本形式

半径为 $R$ 的球面，使用经纬度 $(\lambda, \phi)$ 作为参数：

球面参数方程：

$$
\mathbf{r}(\lambda, \phi) = (R \cos\phi \cos\lambda, \, R \cos\phi \sin\lambda, \, R \sin\phi)
$$

计算偏导数：

$$
\frac{\partial \mathbf{r}}{\partial \lambda} = (-R \cos\phi \sin\lambda, \, R \cos\phi \cos\lambda, \, 0)
$$

$$
\frac{\partial \mathbf{r}}{\partial \phi} = (-R \sin\phi \cos\lambda, \, -R \sin\phi \sin\lambda, \, R \cos\phi)
$$

计算第一基本形系数：

$$
E = R^2 \cos^2\phi (\sin^2\lambda + \cos^2\lambda) = R^2 \cos^2\phi
$$

$$
F = R^2 \cos\phi \sin\lambda \sin\phi \cos\lambda - R^2 \cos\phi \cos\lambda \sin\phi \sin\lambda = 0
$$

$$
G = R^2 \sin^2\phi (\cos^2\lambda + \sin^2\lambda) + R^2 \cos^2\phi = R^2
$$

**球面第一基本形式**：

$$
ds^2 = E \, d\lambda^2 + 2F \, d\lambda \, d\phi + G \, d\phi^2 = R^2 \cos^2\phi \, d\lambda^2 + R^2 \, d\phi^2
$$

### C.3.3 投影后的第一基本形式

投影将球面坐标 $(\lambda, \phi)$ 映射到平面坐标 $(x, y)$ ：

$$
\mathbf{r}_{map}(\lambda, \phi) = (x(\lambda, \phi), y(\lambda, \phi), 0)
$$

投影平面的第一基本形式系数：

$$
E_{map} = \left(\frac{\partial x}{\partial \lambda}\right)^2 + \left(\frac{\partial y}{\partial \lambda}\right)^2
$$

$$
F_{map} = \frac{\partial x}{\partial \lambda}\frac{\partial x}{\partial \phi} + \frac{\partial y}{\partial \lambda}\frac{\partial y}{\partial \phi}
$$

$$
G_{map} = \left(\frac{\partial x}{\partial \phi}\right)^2 + \left(\frac{\partial y}{\partial \phi}\right)^2
$$

## C.4 高斯绝妙定理

### C.4.1 主曲率与高斯曲率定义

在曲面上任一点，存在两个主曲率（principal curvatures） $k_1$ 和 $k_2$ ，分别是曲面在该点法曲率的最大值和最小值。

**高斯曲率（Gaussian curvature） $K$**：

$$
K = k_1 \cdot k_2
$$

使用第二基本形式系数 $L, M, N$ 和第一基本形式系数 $E, F, G$ ：

$$
K = \frac{LN - M^2}{EG - F^2}
$$

对于半径为 $R$ 的球面：

$$
k_1 = k_2 = \frac{1}{R} \implies K_{sphere} = \frac{1}{R^2}
$$

对于平面：

$$
k_1 = k_2 = 0 \implies K_{plane} = 0
$$

### C.4.2 绝妙定理表述

**定理（Theorema Egregium）**：曲面的高斯曲率 $K$ 可以仅使用第一基本形式的系数 $E, F, G$ 及其对 $u, v$ 的导数表示。也就是说，高斯曲率是曲面的内蕴性质，不依赖于曲面在三维空间中的嵌入方式。

具体公式（Brioschi 公式的特化形式）：

$$
K = \frac{1}{(EG - F^2)^2} \left[ \left| \begin{matrix}
-\frac{1}{2}E_{vv} + F_{uv} - \frac{1}{2}G_{uu} & \frac{1}{2}E_u & F_u - \frac{1}{2}E_v \\
F_v - \frac{1}{2}G_u & E & F \\
\frac{1}{2}G_v & F & G
\end{matrix} \right| - \left| \begin{matrix}
0 & \frac{1}{2}E_v & \frac{1}{2}G_u \\
\frac{1}{2}E_v & E & F \\
\frac{1}{2}G_u & F & G
\end{matrix} \right| \right]
$$

其中下标表示偏导数，如 $E_u = \frac{\partial E}{\partial u}$ 。

### C.4.3 绝妙定理对地图投影的深刻意义

由于球面各点的高斯曲率 $K = 1/R^2 > 0$ ，而平面各点 $K = 0$ ，高斯绝妙定理意味着：

1. **不存在等距映射**：无法找到从球面到平面的保持所有距离的映射
2. **无同时保持的投影**：不存在同时保持所有角度和面积的投影
3. **变形的必然性**：任何投影都必须在几何性质之间做出权衡

具体推论：
- **等角投影**： $k = h = \text{尺度因子}$ ，角度不变但面积 $p = k^2 \neq 1$
- **等积投影**： $p = 1$ ，面积不变但角度变形 $\omega > 0$
- **混合投影**：在多个性质间寻求优化


## C.5 Tissot 指示椭圆推导

### C.5.1 基本构造思想

在球面上任一点 $P(\lambda, \phi)$ 处取一个半径为 $\epsilon$ 的无穷小圆。投影后，这个圆在平面上一般变为椭圆。这个椭圆的形状、大小和方向完全表征了该点的投影变形性质。

### C.5.2 球面上的微元圆

球面上点 $P$ 处，局部切平面上的微小圆可参数化为：

$$
\mathbf{r}(s) = P + \epsilon \cdot (\cos s \cdot \mathbf{e}_1 + \sin s \cdot \mathbf{e}_2)
$$

其中：
- $s \in [0, 2\pi)$ 为角度参数
- $\mathbf{e}_1$ 和 $\mathbf{e}_2$ 是切平面上的正交单位向量
- 在经纬度坐标系中， $\mathbf{e}_1 = \frac{1}{R} \frac{\partial}{\partial \lambda}$ ， $\mathbf{e}_2 = \frac{1}{R} \frac{\partial}{\partial \phi}$

### C.5.3 投影后的椭圆

投影函数记作： $(x, y) = (f(\lambda, \phi), g(\lambda, \phi))$

对于无穷小变形，投影可近似为线性变换：

$$
\begin{pmatrix} \Delta x \\ \Delta y \end{pmatrix} = \mathbf{J} \begin{pmatrix} \Delta \lambda \\ \Delta \phi \end{pmatrix}
$$

**雅可比矩阵**：

$$
\mathbf{J} = \begin{pmatrix} \frac{\partial x}{\partial \lambda} & \frac{\partial x}{\partial \phi} \\[6pt] \frac{\partial y}{\partial \lambda} & \frac{\partial y}{\partial \phi} \end{pmatrix}
$$

### C.5.4 Tissot 椭圆的二次型方程

定义以下度量系数：

$$
E = \left( \frac{\partial x}{\partial \lambda} \right)^2 + \left( \frac{\partial y}{\partial \lambda} \right)^2
$$

$$
F = \frac{\partial x}{\partial \lambda} \frac{\partial x}{\partial \phi} + \frac{\partial y}{\partial \lambda} \frac{\partial y}{\partial \phi}
$$

$$
G = \left( \frac{\partial x}{\partial \phi} \right)^2 + \left( \frac{\partial y}{\partial \phi} \right)^2
$$

投影后椭圆满足的二次型方程：

$$
\frac{E}{R^2\cos^2\phi} \cos^2\theta + \frac{2F}{R^2\cos\phi} \cos\theta \sin\theta + \frac{G}{R^2} \sin^2\theta = 1
$$

其中 $\theta$ 为椭圆上点的角度参数。

### C.5.5 主比例因子与主方向

构造对称矩阵：

$$
\mathbf{M} = \frac{1}{R^2 \cos^2\phi} \begin{pmatrix} E & F \cos\phi \\ F \cos\phi & G \cos^2\phi \end{pmatrix}
$$

**主比例因子** $\mathbf{M}$ 的特征值 $\lambda_1, \lambda_2$ ：

$$
\lambda_{1,2} = \frac{\text{tr}(\mathbf{M}) \pm \sqrt{\text{tr}(\mathbf{M})^2 - 4\det(\mathbf{M})}}{2}
$$

其中：

$$
\text{tr}(\mathbf{M}) = \frac{E}{R^2 \cos^2\phi} + \frac{G}{R^2}
$$

$$
\det(\mathbf{M}) = \frac{EG - F^2}{R^4 \cos^2\phi}
$$

主比例因子（椭圆长短轴）：

$$
a = \sqrt{\lambda_1}, \quad b = \sqrt{\lambda_2}
$$

**主方向**（特征向量方向）的方位角 $\alpha$ ：

$$
\tan 2\alpha = \frac{2F \cos\phi}{E - G \cos^2\phi}
$$

### C.5.6 Tissot 失真度量的数学表达式

1. **最大角度变形**（Maximum Angular Distortion）：

$$
\omega = 2 \arcsin\left( \frac{a - b}{a + b} \right)
$$

对于等角投影， $a = b$ ，故 $\omega = 0$ 。

2. **面积比例因子**（Area Scale Factor）：

$$
p = a \cdot b = \sqrt{\det(\mathbf{M})}
$$

使用雅可比行列式表示：

$$
p = \frac{1}{R^2 \cos\phi} \left| \frac{\partial(x, y)}{\partial(\lambda, \phi)} \right| = \frac{1}{R^2 \cos\phi} \left| \frac{\partial x}{\partial \lambda} \frac{\partial y}{\partial \phi} - \frac{\partial x}{\partial \phi} \frac{\partial y}{\partial \lambda} \right|
$$

对于等积投影， $p = 1$ 处处成立。

3. **形状比例因子**（Shape Scale Factor）：

$$
s = \frac{a}{b} \geq 1
$$

等角投影： $s = 1$ 。

4. **Tissot 椭圆的离心率**：

$$
e = \sqrt{1 - \left(\frac{b}{a}\right)^2} = \sqrt{1 - \frac{1}{s^2}}
$$

## C.6 横轴墨卡托投影与高斯-克吕格投影

### C.6.1 横轴墨卡托投影的坐标旋转

横轴墨卡托（Transverse Mercator）通过旋转坐标系实现。设原坐标为 $(\lambda, \phi)$ ，中央经线为 $\lambda_0$ ，通过球面三角变换得到旋转后坐标 $(\lambda', \phi')$ ：

$$
\sin\phi' = \sin\phi \cos\phi_0 - \cos\phi \sin\phi_0 \cos(\lambda - \lambda_0)
$$

$$
\tan\lambda' = \frac{\cos\phi \sin(\lambda - \lambda_0)}{\sin\phi \sin\phi_0 + \cos\phi \cos\phi_0 \cos(\lambda - \lambda_0)}
$$

对于标准横轴墨卡托，通常 $\phi_0 = 0$ （赤道），简化为：

$$
\sin\phi' = -\cos\phi \cos(\lambda - \lambda_0)
$$

$$
\tan\lambda' = \frac{\sin(\lambda - \lambda_0)}{\cos\phi \cos(\lambda - \lambda_0)}
$$

### C.6.2 投影公式

将旋转后的坐标 $(\lambda', \phi')$ 代入标准墨卡托公式：

$$
X = R \lambda'
$$

$$
Y = R \ln\left[\tan\left(\frac{\pi}{4} + \frac{\phi'}{2}\right)\right]
$$

### C.6.3 高斯-克吕格投影（椭球面）

高斯-克吕格投影（Gauss-Krüger Projection）是椭球面上的严格横轴墨卡托投影。

**椭球面参数**：

- 长半轴： $a$
- 扁率： $f = \frac{a - b}{a}$
- 第一偏心率： $e = \sqrt{2f - f^2}$
- 第二偏心率： $e' = \frac{e}{\sqrt{1 - e^2}}$

**子午线弧长**（Mercator latitude）：
从赤道到纬度 $\phi$ 的子午线弧长：

$$
M(\phi) = a(1 - e^2) \int_0^\phi \frac{d\phi'}{(1 - e^2 \sin^2\phi')^{3/2}}
$$

这是椭圆积分，无初等函数表达式。

**级数展开**（实用计算公式）：

$$
M(\phi) = a \left[ A_0 \phi + A_2 \sin 2\phi + A_4 \sin 4\phi + A_6 \sin 6\phi + \cdots \right]
$$

其中：

$$
A_0 = 1 - \frac{3}{4}e^2 - \frac{3}{64}e^4 - \frac{5}{256}e^6 - \cdots
$$

$$
A_2 = \frac{3}{8}e^2 + \frac{3}{32}e^4 + \frac{45}{1024}e^6 + \cdots
$$

$$
A_4 = \frac{15}{256}e^4 + \frac{45}{1024}e^6 + \cdots
$$

$$
A_6 = \frac{35}{3072}e^6 + \cdots
$$

**高斯-克吕格投影正算公式**：

给定纬度 $\phi$ ，经度 $\lambda$ ，中央经线 $\lambda_0$ ，定义经度差 $\Delta\lambda = \lambda - \lambda_0$ 。

辅助量：

$$
t = \tan\phi
$$

$$
\eta^2 = e'^2 \cos^2\phi = \frac{e^2 \cos^2\phi}{1 - e^2}
$$

$$
N = \frac{a}{\sqrt{1 - e^2 \sin^2\phi}}
$$

（卯酉圈曲率半径）

投影坐标（X为北坐标，Y为东坐标）：

$$
X = M(\phi) + N t \cos^2\phi \frac{\Delta\lambda^2}{2} \left[ 1 + \frac{\Delta\lambda^2}{12} \left(5 - t^2 + 9\eta^2 + 4\eta^4\right) + \cdots \right]
$$

$$
Y = N \cos\phi \, \Delta\lambda \left[ 1 + \frac{\Delta\lambda^2}{6} \left(1 - t^2 + \eta^2 \right) + \frac{\Delta\lambda^4}{120} \left(5 - 18t^2 + t^4 + 14\eta^2 - 58t^2\eta^2 \right) + \cdots \right]
$$

**尺度因子**（Scale factor）：

$$
h(\Delta\lambda, \phi) = 1 + \frac{\Delta\lambda^2 \cos^2\phi}{2} (1 + \eta^2) + \frac{\Delta\lambda^4 \cos^4\phi}{24} (5 - 4t^2 + 14\eta^2 + \dots) + \cdots
$$

在中央经线 $\Delta\lambda = 0$ 处： $h = 1$ （无变形）

## C.7 兰伯特等角圆锥投影

### C.7.1 投影设置

兰伯特等角圆锥投影（Lambert Conformal Conic Projection）使用两个标准纬线 $\phi_1$ 和 $\phi_2$ （ $\phi_1 < \phi_2$ ），中央经线为 $\lambda_0$ 。

### C.7.2 圆锥常数

圆锥常数（cone constant） $n$ ：

$$
n = \frac{\ln(\cos\phi_1 \sec\phi_2)}{\ln\left[ \tan\left(\frac{\pi}{4} + \frac{\phi_2}{2}\right) \cot\left(\frac{\pi}{4} + \frac{\phi_1}{2}\right) \right]}
$$

### C.7.3 坐标公式

定义常数：

$$
F = \frac{a \cos\phi_1 \tan^n\left(\frac{\pi}{4} + \frac{\phi_1}{2}\right)}{n}
$$

其中 $a$ 为地球半径（椭球面或球面）。
极坐标半径：

$$
\rho = F \cot^n\left(\frac{\pi}{4} + \frac{\phi}{2}\right)
$$

极坐标角度：

$$
\theta = n (\lambda - \lambda_0)
$$

投影坐标：

$$
x = \rho \sin\theta + x_0
$$

$$
y = \rho_0 - \rho \cos\theta + y_0
$$

其中 $(x_0, y_0)$ 为坐标原点偏移（通常用于使坐标为正值）， $\rho_0 = F \cot^n\left(\frac{\pi}{4} + \frac{\phi_0}{2}\right)$ ， $\phi_0$ 为参考纬度。

### C.7.4 反算公式

给定平面坐标 $(x, y)$ ，计算纬度 $\phi$ 和经度 $\lambda$ ：

$$
\theta' = \arctan\left(\frac{x - x_0}{\rho_0 - (y - y_0)}\right)
$$

$$
\rho = \sqrt{(x - x_0)^2 + (\rho_0 - (y - y_0))^2}
$$

$$
t = \left(\frac{\rho}{F}\right)^{1/n}
$$

$$
\phi = \frac{\pi}{2} - 2 \arctan(t)
$$

$$
\lambda = \frac{\theta'}{n} + \lambda_0
$$

### C.7.5 尺度因子

兰伯特等角圆锥投影在两个标准纬线 $\phi_1$ 和 $\phi_2$ 处尺度因子 $h = 1$ 。在标准纬线之间 $h < 1$ （收缩），在标准纬线之外 $h > 1$ （膨胀）。

## C.8 球极投影（Stereographic Projection）

### C.8.1 投影定义

球极投影是从球面到平面的透视投影，投影中心在球面上一点（通常为北极或南极），将球面（除投影中心的对径点外）投影到与球面相切的平面。

### C.8.2 复数表示

设球面点 $P$ 的球坐标为 $(\lambda, \phi)$ ，平面上的对应点 $P'$ 的复坐标为 $w = X + iY$ 。
使用复数表示，球极投影可以表述为：

$$
w = \frac{2R}{1 + e^{-i\lambda} \sin\phi + \cos\phi}
$$

### C.8.3 实参数形式

**北极切投影**（射影中心为北极）：

$$
X = 2R \cdot \frac{\cos\phi \cos\lambda}{1 + \sin\phi}
$$

$$
Y = 2R \cdot \frac{\cos\phi \sin\lambda}{1 + \sin\phi}
$$

**南极切投影**（射影中心为南极）：

$$
X = 2R \cdot \frac{\cos\phi \cos\lambda}{1 - \sin\phi}
$$

$$
Y = 2R \cdot \frac{\cos\phi \sin\lambda}{1 - \sin\phi}
$$

### C.8.4 等角性证明

球极投影是等角投影（Conformal projection），可通过复分析证明。复数表示 $w(z)$ 其中 $z = \tan(\frac{\pi}{4} + \frac{\phi}{2}) e^{i\lambda}$ 是 $z$ 的解析函数，满足柯西-黎曼方程，因此是保角的。

### C.8.5 圆性质

球极投影的重要性质：球面上的圆（或大圆）投影为平面上的圆或直线。这来源于球极投影是莫比乌斯变换（Möbius transformation）的特例。


## C.9 Web 墨卡托投影（WGS84/Pseudo-Mercator）

### C.9.1 与传统墨卡托的差异

传统墨卡托（基于WGS84椭球体）采用球形地球近似：

$$
x(\lambda) = R \lambda
$$

$$
y(\phi) = R \ln\left[\tan\left(\frac{\pi}{4} + \frac{\phi}{2}\right)\right]
$$

其中 $R = 6378137$ 米（等于WGS84椭球体的长半轴）。
传统椭球体墨卡托的纬度映射包含偏心率修正项：

$$
\psi(\phi) = \ln\left[\tan\left(\frac{\pi}{4} + \frac{\phi}{2}\right)\right] - \frac{e}{2}\ln\left[\frac{1 - e\sin\phi}{1 + e\sin\phi}\right]
$$

其中 $e \approx 0.08181919$ 是WGS84的第一偏心率。
Web墨卡托省略了偏心率修正项，简化性能和实现。

### C.9.2 纬度限制与正方形投影

为了使投影坐标空间为正方形（便于瓦片划分），将纬度限制为使投影坐标最大值为 $\pm 20037508.342789244$ 米：

$$
y_{\max} = \pi R \approx 20037508.342789244 \text{ 米}
$$

最大纬度 $\phi_{\max}$ ：

$$
\pi = \ln\left[\tan\left(\frac{\pi}{4} + \frac{\phi_{\max}}{2}\right)\right]
$$

$$
e^{\pi} = \tan\left(\frac{\pi}{4} + \frac{\phi_{\max}}{2}\right)
$$

$$
\phi_{\max} = 2\arctan(e^{\pi}) - \frac{\pi}{2} \approx 1.484422 \text{ rad} \approx 85.05113°
$$

因此，Web墨卡托的实用范围：
- 纬度： $-85.05113° \leq \phi \leq 85.05113°$
- 经度： $-180° \leq \lambda \leq 180°$
- 投影坐标： $x, y \in [-\pi R, \pi R] = [-20037508.342789244, 20037508.342789244]$ 米

### C.9.3 逆投影公式

给定投影坐标 $(x, y)$ ，地理坐标为：

$$
\lambda = \frac{x}{R} \cdot \frac{180}{\pi}
$$

$$
\phi = \left[2\arctan\left(e^{y/R}\right) - \frac{\pi}{2}\right] \cdot \frac{180}{\pi}
$$

### C.9.4 EPSG代码

- EPSG:3857：WGS84 / Pseudo-Mercator（Web Mercator 的官方代码）
- EPSG:900913：早期使用的一个非官方代码（"google" 的谐音），现已弃用

## C.10 其他投影的关键公式

### C.10.1 等距圆柱投影（Equirectangular Projection）

等距圆柱投影（Plate Carrée）是最简单的投影之一，将经度和纬度线性映射到直角坐标：

$$
x = R \lambda
$$

$$
y = R \phi
$$

或使用角度单位：

$$
x = R \cdot \frac{\pi}{180} \cdot \lambda_{deg}
$$

$$
y = R \cdot \frac{\pi}{180} \cdot \phi_{deg}
$$

特点：经线间距与纬线间距相同，但高纬度变形严重。

### C.10.2 正弦投影（Sinusoidal Projection）

正弦投影是等积的伪圆柱投影：

$$
x = R \lambda \cos\phi
$$

$$
y = R \phi
$$

面积比例因子 $p = 1$ （等积），但不是等角的。

### C.10.3 摩尔威德投影（Mollweide Projection）

摩尔威德投影是等积伪圆柱投影：

$$
x = \frac{2\sqrt{2}}{\pi} R (\lambda - \lambda_0) \cos\theta
$$

$$
y = \sqrt{2} R \sin\theta
$$

其中 $\theta$ 与纬度 $\phi$ 的关系由方程确定：

$$
2\theta + \sin 2\theta = \pi \sin\phi
$$

### C.10.4 罗宾逊投影（Robinson Projection）

罗宾逊投影是折衷投影，其公式通过表格定义，无简单闭式表达。通过数值插值表格计算纬度对应的 $x$ 比例和 $y$ 坐标。


## C.11 投影变形的综合度量

### C.11.1 Airy 平均误差

Airy 平均误差衡量投影在给定区域内的平均面积失真：

$$
E_A = \frac{1}{S} \iint_S (a - 1)^2 \, dS
$$

其中 $a$ 为局部面积比， $S$ 为积分区域。

### C.11.2 Jordan 最大误差

Jordan 准则考虑最大误差：

$$
E_J = \max_S |a - 1|
$$

### C.11.3 Goldberg-Gott 指标

Goldberg 与 Gott 提出的综合指标：

$$
I_{GG} = \frac{1}{\pi} \left[ \alpha(\phi, \theta) \sqrt{d_{flex}^2 + d_{skew}^2 + d_{areal}^2} + d_{boundary}^2 + d_{cuts}^2 \right]
$$

其中：
- $\alpha(\phi, \theta)$ 为局部角度失真
- $d_{flex}$ 为柔性失真（flexion，弯曲失真）
- $d_{skew}$ 为剪切失真（skew）
- $d_{areal}$ 为面积失真
- $d_{boundary}$ 为边界失真
- $d_{cuts}$ 为切口失真

## C.12 瓦片坐标系统与投影的集成

### C.12.1 瓦片数学

在缩放级别 $z$ （通常 $0 \leq z \leq 22$ ），投影空间划分为 $2^z \times 2^z$ 个 $256 \times 256$ 像素的瓦片。
每个瓦片的投影坐标宽度：

$$
\text{TileSize} = \frac{2 \cdot 20037508.342789244}{2^z} \text{ 米}
$$

### C.12.2 投影坐标到瓦片坐标的转换

给定投影坐标 $(x, y)$ 和缩放级别 $z$ ：

$$
tile\_x = \left\lfloor \frac{x + \pi R}{2\pi R} \cdot 2^z \right\rfloor
$$

$$
tile\_y = \left\lfloor \frac{\pi R - y}{2\pi R} \cdot 2^z \right\rfloor
$$

像素坐标：

$$
pixel\_x = \left\lfloor \left(\frac{x + \pi R}{2\pi R} \cdot 2^z - tile\_x\right) \times 256 \right\rfloor
$$

$$
pixel\_y = \left\lfloor \left(\frac{\pi R - y}{2\pi R} \cdot 2^z - tile\_y\right) \times 256 \right\rfloor
$$

### C.12.3 像素分辨率

在缩放级别 $z$ ，像素分辨率为（单位：米/像素）：

$$
\text{PixelResolution} = \frac{40075016.685578488 \text{ 米}}{256 \times 2^z}
$$

例如，在 $z = 15$ 时：

$$
\text{PixelResolution} \approx 4.77 \text{ 米/像素}
$$

## C.13 高级主题：现代数学技术的应用

### C.13.1 变分法在投影优化中的应用

寻找最优投影可表述为变分问题：

$$
\min_{f,g} \int_\Omega D[f,g; \lambda, \phi] \, dA
$$

其中 $D$ 为失真度量函数， $\Omega$ 为投影区域。
例如，最小化平均角度变形的等积投影：

$$
\min_{f,g} \iint_\Omega \omega(\lambda, \phi) \, dA
$$

约束条件： $ab = 1$ （等积）

### C.13.2 分数阶微积分与失真分析

分数阶导数可以更精确地描述失真的渐进行为：

**Caputo 分数阶导数**：

$$
D^\alpha f(x) = \frac{1}{\Gamma(n-\alpha)} \int_a^x \frac{f^{(n)}(t)}{(x-t)^{\alpha-n+1}} dt
$$

其中 $n-1 < \alpha < n$ ， $\Gamma$ 是伽马函数。
应用：分析比例因子 $k(\phi)$ 在极点附近的分数阶导数，理解失真的奇异行为。

### C.13.3 信息论失真指标

从信息论角度定义投影失真：

**互信息（Mutual Information）**：

$$
I(X; Y) = H(X) + H(Y) - H(X, Y)
$$

其中 $X$ 为原始球面数据， $Y$ 为投影后数据， $H(\cdot)$ 为熵。
互信息越大，投影保留的信息越多。

## C.14 符号说明

- $a$ ：椭球面长半轴
- $b$ ：椭球面短半轴
- $e$ ：第一偏心率， $e = \sqrt{1 - b^2/a^2}$
- $e'$ ：第二偏心率， $e' = e/\sqrt{1-e^2}$
- $f$ ：扁率， $f = (a-b)/a$
- $R$ ：球体半径（或椭球面的等价球体半径）
- $\lambda$ ：经度
- $\phi$ ：纬度
- $x, y$ ：投影平面坐标
- $E, F, G$ ：第一基本形式系数
- $k$ ：经度方向比例因子
- $h$ ：纬度方向比例因子
- $a, b$ ：Tissot椭圆的长短轴（主比例因子）
- $p$ ：面积比例因子
- $\omega$ ：最大角度变形
- $K$ ：高斯曲率
- $ds$ ：线元素

**说明**：本附录收集了地图投影理论中的核心数学推导，从基本原理出发系统构建了主要投影的数学框架。推导采用严谨的数学表述，同时注重投影理论与实际应用的结合，为理解现代GIS和网络地图服务的技术基础提供参考。
