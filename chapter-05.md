# 第五章 19世纪的数学进步

## 5.1 引言

19世纪是数学和科学史上又一个激动人心的发展时期。在自然科学领域，热力学、电磁学、进化论等理论的建立标志着科学从经验观察走向理论综合。在数学领域，分析学的严格化、非欧几何的发现、复分析的成熟、微分几何的系统化等进展，为应用数学提供了前所未有的强大工具。

制图学在19世纪迎来了它最重要的数学转折点。如果说17-18世纪的数学文艺复兴建立了制图学的分析基础，那么19世纪的进步则将制图学提升到微分几何的高度。这一时期，卡尔·弗里德里希·高斯（Carl Friedrich Gauss，1777-1855）、尼古拉·泰索（Nicolas Tissot，1824-1897）等科学家的贡献，使得投影理论从经验性方法演进为严格的理论体系。

高斯的曲面理论和绝妙定理（Theorema Egregium）揭示了投影变形的几何本质，从内蕴几何角度解释了为什么某些投影性质不可能同时保持。泰索的指示椭圆理论则提供了定量分析投影变形的系统方法，使得失真成为可以精确度量和比较的数学量。

本章将系统论述19世纪制图学的数学进步，包括高斯曲面的内蕴几何理论、绝妙定理及其对制图学的意义、泰索指示椭圆的数学构造和失真量化方法、微分几何在投影分析中的应用，以及这些理论如何将制图学提升到现代数学的高度。

## 5.2 高斯与曲面理论

### 5.2.1 高斯的学术背景与贡献

卡尔·弗里德里希·高斯（1777-1855）是人类历史上最伟大的数学家之一，被誉为"数学王子"。他在数论、分析学、微分几何、天文学、地磁测量等多个领域做出了奠基性贡献。与制图学直接相关的主要工作包括：

1. **曲面微分几何**：1827年发表的《关于曲面的一般研究》（Disquisitiones generales circa superficies curvas）奠定了经典微分几何的基础
2. **大地测量**：1821-1825年领导汉诺威王国的大地测量工作，在实践中发展椭球面大地测量学
3. **等角投影**：详细研究球面到平面的等角映射，从数学上完善了等角投影理论
4. **高斯绝妙定理**：发现高斯曲率是曲面的内蕴性质，不依赖于曲面如何嵌入三维空间

高斯在汉诺威大地测量工作中的实践经历，使他深刻认识到从椭球面到平面的投影问题的复杂性。这些实践问题推动了他从理论角度研究曲面几何，最终导致绝妙定理的发现。

### 5.2.2 曲面的第一基本形式

高斯在曲面理论的开创性贡献是系统地使用了曲面的第一基本形式（First Fundamental Form）来描述曲面的内蕴几何性质。

设曲面 $S$ 由参数方程 $\mathbf{r}(u, v) = (x(u, v), y(u, v), z(u, v))$ 给出，其中 $(u, v)$ 是曲面上的局部坐标参数。

曲面上的线元素（line element） $ds$ 为：

$$
ds^2 = E \, du^2 + 2F \, du \, dv + G \, dv^2
$$

其中， $E, F, G$ 称为第一基本形式的系数，定义为：

$$
E = \frac{\partial \mathbf{r}}{\partial u} \cdot \frac{\partial \mathbf{r}}{\partial u} = \left( \frac{\partial x}{\partial u} \right)^2 + \left( \frac{\partial y}{\partial u} \right)^2 + \left( \frac{\partial z}{\partial u} \right)^2
$$

$$
F = \frac{\partial \mathbf{r}}{\partial u} \cdot \frac{\partial \mathbf{r}}{\partial v} = \frac{\partial x}{\partial u}\frac{\partial x}{\partial v} + \frac{\partial y}{\partial u}\frac{\partial y}{\partial v} + \frac{\partial z}{\partial u}\frac{\partial z}{\partial v}
$$

$$
G = \frac{\partial \mathbf{r}}{\partial v} \cdot \frac{\partial \mathbf{r}}{\partial v} = \left( \frac{\partial x}{\partial v} \right)^2 + \left( \frac{\partial y}{\partial v} \right)^2 + \left( \frac{\partial z}{\partial v} \right)^2
$$

第一基本形式完全决定了曲面的内蕴几何性质，包括：
- 曲面上曲线的长度
- 曲面上区域的面積
- 曲面上曲线之间的夹角
- 曲面上的测地线

这些性质是曲面"本身"的性质，不依赖于曲面如何嵌入到三维空间中。

### 5.2.3 曲面的第二基本形式

曲面的第二基本形式（Second Fundamental Form）描述曲面在三维空间中的弯曲程度。同样使用参数表示：

$$
II = L \, du^2 + 2M \, du \, dv + N \, dv^2
$$

其中系数为：

$$
L = \frac{\partial^2 \mathbf{r}}{\partial u^2} \cdot \mathbf{n}
$$

$$
M = \frac{\partial^2 \mathbf{r}}{\partial u \partial v} \cdot \mathbf{n}
$$

$$
N = \frac{\partial^2 \mathbf{r}}{\partial v^2} \cdot \mathbf{n}
$$

其中 $\mathbf{n}$ 是曲面的单位法向量：

$$
\mathbf{n} = \frac{\frac{\partial \mathbf{r}}{\partial u} \times \frac{\partial \mathbf{r}}{\partial v}}{|\frac{\partial \mathbf{r}}{\partial u} \times \frac{\partial \mathbf{r}}{\partial v}|}
$$

第二基本形式描述了曲面在特定方向上偏离其切平面的程度，即曲面的外蕴几何性质。与第一基本形式不同，第二基本形式依赖于曲面如何嵌入到三维空间中。

### 5.2.4 球面的第一基本形式

对于制图学而言，最重要的曲面是球面或椭球面。考虑半径为 $R$ 的球面，使用经纬度 $(\lambda, \phi)$ 作为参数：

参数方程为：

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

第一基本形式的系数：

$$
E = \frac{\partial \mathbf{r}}{\partial \lambda} \cdot \frac{\partial \mathbf{r}}{\partial \lambda} = R^2 \cos^2\phi \sin^2\lambda + R^2 \cos^2\phi \cos^2\lambda = R^2 \cos^2\phi
$$

$$
F = \frac{\partial \mathbf{r}}{\partial \lambda} \cdot \frac{\partial \mathbf{r}}{\partial \phi} = R^2 \cos\phi \sin\lambda \sin\phi \cos\lambda - R^2 \cos\phi \cos\lambda \sin\phi \sin\lambda = 0
$$

$$
G = \frac{\partial \mathbf{r}}{\partial \phi} \cdot \frac{\partial \mathbf{r}}{\partial \phi} = R^2 \sin^2\phi \cos^2\lambda + R^2 \sin^2\phi \sin^2\lambda + R^2 \cos^2\phi = R^2
$$

因此，球面的第一基本形式为：

$$
ds^2 = E \, d\lambda^2 + 2F \, d\lambda \, d\phi + G \, d\phi^2 = R^2 \cos^2\phi \, d\lambda^2 + R^2 \, d\phi^2
$$

这个简洁的表达式蕴含了球面所有内蕴几何性质，是研究球面投影的数学起点。

## 5.3 高斯绝妙定理

### 5.3.1 高斯曲率的定义

高斯曲率（Gaussian curvature）是高斯在曲面理论中的核心概念。在曲面上任一点，存在两个主曲率（principal curvatures），记为 $k_1$ 和 $k_2$ ，分别是曲面在该点法曲率的最大值和最小值。

高斯曲率 $K$ 定义为两个主曲率的乘积：

$$
K = k_1 \cdot k_2
$$

使用第一基本形式和第二基本形式的系数，高斯曲率可以表示为：

$$
K = \frac{LN - M^2}{EG - F^2}
$$

对于半径为 $R$ 的球面，任意点的主曲率都是 $1/R$ ，因此：

$$
K_{sphere} = \frac{1}{R} \cdot \frac{1}{R} = \frac{1}{R^2}
$$

对于平面，两个主曲率都为零，因此：

$$
K_{plane} = 0 \cdot 0 = 0
$$

这一事实对理解投影变形具有根本性意义。

### 5.3.2 绝妙定理及其表述

1827年，高斯发现并证明了所谓"绝妙定理"（拉丁文：Theorema Egregium，意为"卓越的定理"）：

**定理（高斯绝妙定理）**：曲面的高斯曲率 $K$ 可以仅使用第一基本形式的系数 $E, F, G$ 及其对 $u$ 和 $v$ 的导数来表示。换句话说，高斯曲率是曲面的内蕴性质，不依赖于曲面如何嵌入三维空间，也不依赖于第二基本形式。

具体地，高斯给出了 $K$ 使用第一基本形式表示的公式：

$$
K = \frac{1}{(EG - F^2)^2} \left\{ \begin{array}{c} -\frac{1}{2} [E_{vv} - 2F_{uv} + G_{uu}] + [F_{uv} (F_{uv} - E_{vv}) - E_v v] \\ \quad + [P \cdot \text{det} \begin{pmatrix} E & F \\ F & G \end{pmatrix} + Q \cdot (\text{terms})] \end{array} \right\}
$$

其中下标表示偏导数， $P$ 和 $Q$ 是由第一基本形导数构成的表达式。虽然公式看起来复杂，但关键点是： $K$ 完全由第一基本形决定。

这一定理的深刻意义在于：如果两个曲面彼此等距同构（即存在保持距离的映射），那么它们具有相同的高斯曲率。反之，如果两个曲面的高斯曲率不同，那么不存在保持距离的映射。

### 5.3.3 对制图学的意义

绝妙定理对制图学的影响是根本性和决定性的：

**定理的制图学推论**：由于球面（或部分球面）各点的高斯曲率为 $K = 1/R^2 > 0$ ，而平面的高斯曲率处处为 $K = 0$ ，因此：

1. 不存在从球面到平面的等距映射（isometric mapping），即不可能同时保持所有距离
2. 不存在同时保持所有角度和面积的投影（因为这将蕴含保持所有距离）
3. 不存在同时保持所有角度和测地线曲率的投影

这些推论从数学上解释了地图投影变形的几何本质：
- 等角投影（Conformal projection）保持角度但改变面积
- 等积投影（Equal-area projection）保持面积但改变角度
- 等距投影（Equidistant projection）沿某些方向保持距离但无法沿所有方向保持
- 没有任何投影可以同时保持所有几何性质

绝妙定理从理论上证明了：地图投影的变形是不可避免的，我们只能在不同性质之间做权衡优化，而无法完全消除变形。

### 5.3.4 局部与全局投影的区别

绝妙定理将投影问题区分为局部和全局两个层面：

**局部层面**：对于任意一点 $P$ 及其小邻域，存在局部等角映射。例如，使用泰勒展开，可以将球面在点 $P$ 附近的几何近似为平面上的几何。

设球面上点 $P = (\lambda_0, \phi_0)$ ，考虑其附近的变换：

$$
\lambda' = \lambda - \lambda_0, \quad \phi' = \phi - \phi_0
$$

在 $(\lambda_0, \phi_0)$ 处，球面的度量可以近似：

$$
ds^2 \approx R^2 \cos^2\phi_0 \, d\lambda'^2 + R^2 \, d\phi'^2
$$

通过适当的缩放：

$$
x = R \cos\phi_0 \cdot \lambda', \quad y = R \cdot \phi'
$$

就得到局部欧几里得度量：

$$
ds^2 \approx dx^2 + dy^2
$$

这就是"局部等距映射"，在小范围内可以近似保持所有距离和角度。

**全局层面**：对于任意有限区域，不存在全局距离保持映射。任何区域的投影都会引入不同程度的变形，变形的程度与区域大小、投影位置、投影类型等因素相关。

高斯的理论清晰地界定了哪些投影性质是可能实现的，哪些是根本不可能实现的，为制图家的实践提供了理论指导。

## 5.4 等角投影的进一步发展

### 5.4.1 等角投影的数学表征

高斯在1820年代对等角投影进行了深入研究，建立了更严格的数学表征。等角投影的核心要求是：投影在局部保持角度不变，即投影是局部相似变换。

使用高斯的曲面积分理论，等角条件可以表述为：

设投影函数为：

$$
x = x(\lambda, \phi), \quad y = y(\lambda, \phi)
$$

投影后平面的线元素为：

$$
dS^2 = E \, d\lambda^2 + 2F \, d\lambda \, d\phi + G \, d\phi^2
$$

其中：

$$
E = \left( \frac{\partial x}{\partial \lambda} \right)^2 + \left( \frac{\partial y}{\partial \lambda} \right)^2
$$

$$
F = \frac{\partial x}{\partial \lambda} \frac{\partial x}{\partial \phi} + \frac{\partial y}{\partial \lambda} \frac{\partial y}{\partial \phi}
$$

$$
G = \left( \frac{\partial x}{\partial \phi} \right)^2 + \left( \frac{\partial y}{\partial \phi} \right)^2
$$

球面的线元素为：

$$
ds^2 = R^2 \cos^2\phi \, d\lambda^2 + R^2 \, d\phi^2
$$

等角条件要求存在尺度因子 $k(\lambda, \phi)$ 使得：

$$
dS^2 = k^2(\lambda, \phi) \cdot ds^2
$$

展开并比较系数：

$$
E = k^2 R^2 \cos^2\phi, \quad G = k^2 R^2, \quad F = 0
$$

因此，等角投影要求：
1. $F = 0$ （混合交叉项消失，投影正交）
2. $\frac{E}{R^2 \cos^2\phi} = \frac{G}{R^2} = k^2$ （两个方向的比例因子相同）

这就是等角投影的完整数学条件。

### 5.4.2 高斯-克吕格投影

高斯在大地测量工作中发展了高斯-克吕格投影（Gauss-Krüger projection），这是等角横轴墨卡托投影的一种变体，专门用于中纬度地区的大比例尺地图。

投影的基本思想：在中央经线处，将椭球面局部"展开"到圆柱上，然后展开为平面。

数学表述：
设地球为椭球面，长半轴为 $a$ ，扁率为 $f$ ，椭圆积分模数为 $e$ （第一偏心率）：

$$
e = \sqrt{2f - f^2}
$$

对于给定的中央经线 $\lambda_0$ ，投影坐标 $(X, Y)$ 为：

1. 子午线弧长计算：

$$
M(\phi) = a(1 - e^2) \int_{0}^{\phi} \frac{d\phi'}{(1 - e^2 \sin^2 \phi')^{3/2}}
$$

这个积分无法用初等函数表示，需要使用椭圆积分或数值积分。

2. 子午线坐标（northings）：

$$
Y = M(\phi^*)
$$

其中 $\phi^*$ 是辅助纬度，满足 $\lambda_{diff} = \lambda - \lambda_0$ 为小量时的近似。

3. 投影东向坐标（eastings）：

$$
X = N \cos\phi \cdot \lambda_{diff} + \frac{N \cos^3\phi (1 - t^2 + \eta^2)}{6} \lambda_{diff}^3 + O(\lambda_{diff}^5)
$$

其中：

$$
t = \tan\phi, \quad \eta^2 = e'^2 \cos^2\phi, \quad e' = \frac{e}{\sqrt{1 - e^2}}
$$

高斯-克吕格投影的绝妙之处在于：它在中央经线 $\lambda = \lambda_0$ 处是完全正确的（无变形），随着远离中央经线，变形逐渐增大但增长缓慢。这使得该投影适合分带使用的地图系统，每6°或3°经度建立独立的投影带。

### 5.4.3 横轴、斜轴投影的数学分析

高斯的工作还包括横轴（transverse）和斜轴（oblique）投影的严格数学分析。这些投影通过旋转坐标轴实现：

**坐标旋转**：从正常坐标 $(\lambda, \phi)$ 和目标坐标 $(\lambda', \phi')$ 的旋转使用球面三角公式：

给定新的投影中心 $(\lambda_c, \phi_c)$ 和旋转角 $\psi$ ，坐标转换为：

$$
\sin\phi' = \sin\phi_c \sin\phi + \cos\phi_c \cos\phi \cos(\lambda - \lambda_c)
$$

$$
\tan\lambda' = \frac{\cos\phi \sin(\lambda - \lambda_c)}{\cos\phi_c \sin\phi - \sin\phi_c \cos\phi \cos(\lambda - \lambda_c)}
$$

在这些新坐标下，可以应用标准的投影公式（如墨卡托投影）得到转轴投影。

**横轴墨卡托投影**：将中央子午线旋转到"赤道"位置，然后应用墨卡托公式：

$$
x_{TM} = R \ln\left[\tan\left(\frac{\pi}{4} + \frac{\phi'}{2}\right)\right]
$$

$$
y_{TM} = R \cdot \lambda'
$$

横轴投影在赤道变形最小，适合南北向延伸的区域。

**斜轴墨卡托投影**：投影轴取任意方向，投影在过投影中心的大圆上变形最小。适合沿定向航线或特定方位展开的区域。

这些转轴投影的严格数学分析使制图学家可以根据制图区域的特点选择最适合的投影形式，优化变形分布。

## 5.5 泰索与指示椭圆理论

### 5.5.1 尼古拉·泰索的生平与贡献

尼古拉·泰索（Nicolas Auguste Tissot，1824-1897）是法国数学家和制图学家，他在19世纪中叶对投影变形的定量分析做出了划时代贡献。

泰索的核心贡献是**泰索指示椭圆**（Tissot's indicatrix，又称变形椭圆或Tissot椭圆）。这个可视化工具将投影在某点的变形性质表示为一个椭圆，椭圆的形状、大小和方向完全定量地描述了该点的各种变形。

泰索的工作发表于1859年和1881年的论文中，题为《关于地图投影变形的研究》（Mémoire sur la représentation des surfaces et les projections des cartes géographiques）。这些论文建立了系统性、精确化的投影变形分析框架。

在泰索之前，制图学家对变形的分析主要依赖定性描述（如"东部变形较大"、"中部相对准确"）。泰索的理论首次将变形转化为精确度量的数学量，可以定量比较不同投影在不同区域的变形程度。

### 5.5.2 泰索指示椭圆的数学构造

泰索指示椭圆的构造基于以下思想：在球面上取一个无限小的圆形，投影到平面后通常变为椭圆。这个椭圆的几何参数完全表征了该点的变形性质。

**构造步骤**：

1. 球面：在球面上点 $P(\lambda, \phi)$ 处，取一个半径为 $\epsilon$ 的无限小圆。该圆可参数化为：

   $$
\mathbf{r}(s) = P + \epsilon \cdot ( \cos s \cdot \mathbf{e}_1 + \sin s \cdot \mathbf{e}_2 )
$$

   其中 $\mathbf{e}_1$ 和 $\mathbf{e}_2$ 是球面在 $P$ 点切平面上的正交单位向量。

2. 投影：将这个无限小圆投影到平面。投影函数为 $(x, y) = (f(\lambda, \phi), g(\lambda, \phi))$ 。

3. 线性化：对于无限小量，投影可以近似为线性变换：

   $$
\begin{pmatrix} \Delta x \\ \Delta y \end{pmatrix} = \mathbf{J} \begin{pmatrix} \Delta \lambda \\ \Delta \phi \end{pmatrix}
$$

   其中 $\mathbf{J}$ 是雅可比矩阵：

   $$
\mathbf{J} = \begin{pmatrix} \frac{\partial x}{\partial \lambda} & \frac{\partial x}{\partial \phi} \\ \frac{\partial y}{\partial \lambda} & \frac{\partial y}{\partial \phi} \end{pmatrix}
$$

4. 椭圆方程：投影后，无限小圆在平面上变为二次曲线。

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

则投影椭圆满足的二次型为：

$$
\frac{E}{A^2} \cos^2\theta + \frac{2F}{A B} \cos\theta \sin\theta + \frac{G}{B^2} \sin^2\theta = 1
$$

其中 $A = R \cos\phi$ 和 $B = R$ 是球面坐标 $\lambda$ 和 $\phi$ 方向的尺度参数。

这个方程描述了中心在原点、一般方向的椭圆。

### 5.5.3 主比例因子与主方向

泰索指示椭圆的关键参数是主比例因子（principal scale factors）和主方向（principal directions）。

**主比例因子**：椭圆的长轴（major axis）和短轴（minor axis）长度分别对应两个主比例因子 $a$ 和 $b$ ：

$$
a \geq b > 0
$$

这两个值表示在该点邻域内，投影的最大和最小伸缩比例。

**主方向**：对应于长轴和短轴的方向称为主方向。这两个方向互相垂直。

数学上，主比例因子 $a$ 和 $b$ 通过以下步骤计算：

1. 构造对称矩阵：

$$
\mathbf{M} = \frac{1}{R^2 \cos^2\phi} \begin{pmatrix} E & F \cos\phi \\ F \cos\phi & G \cos^2\phi \end{pmatrix}
$$

2. 求矩阵 $\mathbf{M}$ 的特征值和特征向量。
   - 特征值 $\lambda_1$ 和 $\lambda_2$ 满足 $\lambda_1 \geq \lambda_2 > 0$
   - 主比例因子为： $a = \sqrt{\lambda_1}$ ， $b = \sqrt{\lambda_2}$
   - 对应的特征向量给出主方向

**计算公式**：主比例因子可直接从特征方程计算：

$$
\lambda^2 - \text{tr}(\mathbf{M}) \cdot \lambda + \det(\mathbf{M}) = 0
$$

其中：

$$
\text{tr}(\mathbf{M}) = \frac{E}{R^2 \cos^2\phi} + \frac{G}{R^2}
$$

$$
\det(\mathbf{M}) = \frac{EG - F^2}{R^4 \cos^2\phi}
$$

主比例因子为：

$$
a, b = \sqrt{\frac{\text{tr}(\mathbf{M}) \pm \sqrt{\text{tr}(\mathbf{M})^2 - 4\det(\mathbf{M})}}{2}}
$$

主方向 $\tan\alpha$ （相对于经度方向）为：

$$
\tan 2\alpha = \frac{2F}{E \cos\phi - G \cos\phi}
$$

### 5.5.4 各种变形度量的泰索表达式

主比例因子 $a$ 和 $b$ 是计算所有变形度量的基础：

**1. 最大角度变形（Maximum Angular Distortion）**：

Tissot 定义的最大角度变形 $\omega$ 为：

$$
\omega = 2 \arcsin\left( \frac{a - b}{a + b} \right)
$$

这个量表示在该点，任意两个方向的夹角在投影后最大可能的改变量。

对于等角投影， $a = b$ ，因此 $\omega = 0$ （无角度变形）。

对于等积投影， $a b = 1$ ，但一般 $a \neq b$ ，因此 $\omega > 0$ 。

**2. 面积比例因子（Scale Factor of Area）**：

面积比例因子 $p$ 为：

$$
p = a \cdot b
$$

使用雅可比行列式，面积比例因子也可以表示为：

$$
p = \frac{1}{R^2 \cos\phi} \left| \frac{\partial(x, y)}{\partial(\lambda, \phi)} \right| = \frac{1}{R^2 \cos\phi} \left| \frac{\partial x}{\partial \lambda} \frac{\partial y}{\partial \phi} - \frac{\partial x}{\partial \phi} \frac{\partial y}{\partial \lambda} \right|
$$

对于等积投影， $p = 1$ （面积保持不变），即 $ab = 1$ 。

**3. 形状比例因子（Shape Scale Factor）**：

形状变形通常用 $p^* = a/b$ 表示，称为比例因子比：

$$
p^* = \frac{a}{b} \geq 1
$$

对于等角投影， $a/b = 1$ ，即形状保持不变（局部相似）。

**4. Tissot 椭圆的离心率**：

椭圆的离心率 $e$ 为：

$$
e = \sqrt{1 - \left(\frac{b}{a}\right)^2} = \sqrt{1 - \frac{1}{(p^*)^2}}
$$

对于等角投影， $e = 0$ （椭圆退化为圆）。

### 5.5.5 特殊投影类型的Tissot椭圆特征

不同类型的投影具有特征性的Tissot椭圆形状：

**等角投影（Conformal Projection）**：

- 在所有点： $a = b = h$ ，其中 $h$ 是局部比例因子
- Tissot椭圆处处为圆（离心率 $e = 0$ ）
- 最大角度变形： $\omega = 0$
- 面积比例因子： $p = h^2$ （一般不为1）

**等积投影（Equal-area Projection）**：

- 在所有点： $a \cdot b = 1$ 或 $ab = k^2$ （对于全局缩放）
- Tissot椭圆一般不为圆（ $a \neq b$ ）
- 最大角度变形： $\omega = 2 \arcsin(\frac{a - 1/a}{a + 1/a})$
- 面积比例因子： $p = 1$ （或恒定值）

**等距投影（Equidistant Projection）**：

- 通常沿某些方向保持距离，即沿主方向之一 $a = 1$ 或 $b = 1$
- Tissot椭圆沿主轴长度不同，不一定为圆
- 面积比例因子： $p = a b$
- 角度变形：一般不为零

泰索指示椭圆的强大之处在于，通过单个几何图形可以可视化所有这些变形性质，使得变形分析成为直观且定量化的过程。

## 5.6 失真度量的数学分析

### 5.6.1 地图投影的失真分类

泰索的理论将投影失真系统地分类为三种基本类型：

**1. 距离失真（Distance Distortion）**：

在点 $(\lambda, \phi)$ ，沿方向 $\theta$ 的距离比例因子为：

$$
k(\theta) = \frac{\text{投影后微元长度}}{\text{球面微元长度}} = \sqrt{\frac{dS^2}{ds^2}}
$$

显式表示为：

$$
k(\theta) = \sqrt{E \cos^2\theta + 2F \cos\theta \sin\theta + G \sin^2\theta}
$$

最大和最小距离比例因子正是主比例因子 $a$ 和 $b$ 。

**2. 角度失真（Angle Distortion）**：

球面上两个方向 $\theta_1$ 和 $\theta_2$ 的夹角为 $|\theta_1 - \theta_2|$ ，投影后夹角为：

$$
\angle = \arccos\left( \frac{dS(\theta_1) \cdot dS(\theta_2)}{|dS(\theta_1)| |dS(\theta_2)|} \right)
$$

其中 $dS(\theta)$ 是方向 $\theta$ 的投影微元向量。

角度失真为：

$$
\Delta\psi = |\angle - |\theta_1 - \theta_2||
$$

最大角度失真 $\omega$ 出现在特殊方向，Tissot给出了显式公式：

$$
\omega = 2 \arcsin\left( \frac{a - b}{a + b} \right)
$$

**3. 面积失真（Area Distortion）**：

无限小区域的面积比例因子为：

$$
p = \frac{dA_{map}}{dA_{sphere}} = a b
$$

使用雅可比行列式：

$$
p = \left| \frac{\partial(x, y)}{\partial(\lambda, \phi)} \right| \cdot \frac{1}{R^2 \cos\phi}
$$

对于等积投影， $p = 1$ 或恒定；对于等角投影， $p = h^2$ ，其中 $h$ 是局部比例因子，一般随位置变化。

### 5.6.2 失真的积分度量

除了局部失真度量，Tissot还引入了全局积分失真度量，用于评价整体区域的失真程度。

**最大角度变形的积分度量**：

$$
W_\omega = \frac{1}{A_{region}} \iint_{\Omega} \omega(\lambda, \phi) \, d\lambda \, d\phi
$$

其中 $\Omega$ 是投影区域， $A_{region}$ 是该区域在球面上的面积。

**面积失真的方差**：

$$
\sigma_p^2 = \frac{1}{A_{region}} \iint_{\Omega} (p(\lambda, \phi) - \overline{p})^2 \, d\lambda \, d\phi
$$

其中 $\overline{p}$ 是面积比例因子的平均值。

**形状比例因子的积分**：

$$
I_a = \frac{1}{A_{region}} \iint_{\Omega} \frac{a(\lambda, \phi)}{b(\lambda, \phi)} \, d\lambda \, d\phi
$$

这些积分度量使制图学家可以从整体上评价和比较不同投影的性能，而不仅仅关注局部性质。

### 5.6.3 投影的优化判据

基于失真度量化，19世纪制图学家开始研究投影优化问题：如何设计投影，使得某种失真在给定区域上最小化？

**等积投影的优化判据**：

对于等积投影（ $ab = 1$ ），最小化平均角度变形：

$$
\min_{f,g} \iint_{\Omega} \omega(\lambda, \phi) \, d\lambda \, d\phi
$$

约束条件：

$$
a(\lambda, \phi) \cdot b(\lambda, \phi) = 1
$$

**等角投影的优化判据**：

对于等角投影（ $a = b$ ），最小化面积失真的方差：

$$
\min_{f,g} \iint_{\Omega} (a^2(\lambda, \phi) - 1)^2 \, d\lambda \, d\phi
$$

约束条件：等角性（满足柯西-黎曼方程）。

**混合判据**：

任意投影可以最小化加权和：

$$
\min_{f,g} \iint_{\Omega} \big[ \alpha \omega(\lambda, \phi)^2 + \beta (p(\lambda, \phi) - 1)^2 + \gamma (\frac{a}{b} - 1)^2 \big] \, d\lambda \, d\phi
$$

其中 $\alpha, \beta, \gamma$ 是权重系数，根据应用需求确定。

这些优化问题是变分问题或带约束的优化问题，其求解需要使用变分法和拉格朗日乘数法等高等数学工具，体现了制图理论与分析学的深度融合。

### 5.6.4 失真等值线

Tissot理论的进一步应用是绘制失真等值线（isoline），将失真度量可视化：

**距离比例因子等值线**：

$$
k(\lambda, \phi) = \text{constant}
$$

或更具体地，主比例因子等值线：

$$
a(\lambda, \phi) = C_1, \quad b(\lambda, \phi) = C_2
$$

**角度失真等值线**：

$$
\omega(\lambda, \phi) = C
$$

这显示了投影上角度变形保持不变的曲线族。

**面积比例因子等值线**：

$$
p(\lambda, \phi) = ab = C
$$

对于等积投影，这些等值线退化为等值线 $p = 1$ （整个投影上恒定）。

失真等值线为地图使用者提供了直观的工具，可以根据失真分布选择投影的适用区域。例如，对于某等角投影，如果 $\omega < 2°$ 等值线覆盖了关心的地理区域，则该投影可以被视为在该区域"接近等角"。

## 5.7 微分几何在投影分析中的应用

### 5.7.1 从微分几何看投影的本质

19世纪的微分几何理论为理解投影本质提供了深刻视角：投影是从球面（或曲面）到平面的可微映射。

使用数学语言，投影是映射：

$$
\Phi: S \to \mathbb{R}^2
$$

$$
\Phi(\lambda, \phi) = (x(\lambda, \phi), y(\lambda, \phi))
$$

其中 $S$ 是地球表面（理想化为正球面或旋转椭球面）， $\mathbb{R}^2$ 是平面。

投影的数学核心性质是：

1. **可微性**： $\Phi$ 是充分可微的（至少 $C^2$ ），这确保了投影是"平滑"的
2. **正则性**：雅可比行列式 $|\frac{\partial(x, y)}{\partial(\lambda, \phi)}| \neq 0$ ，这确保了投影是局部同胚的
3. **单值性**：每个 $(\lambda, \phi)$ 对应唯一的 $(x, y)$ ，投影函数是多对一的（不同位置的经纬坐标可能有不同表现）

微分几何关注的是映射 $\Phi$ 如何改变曲面的度量张量（metric tensor）。

### 5.7.2 度量张量的变换

曲面的内蕴几何完全由度量张量决定。在球面上，度量张量（使用第一基本形表示）为：

$$
g_{sphere} = \begin{pmatrix} R^2 \cos^2\phi & 0 \\ 0 & R^2 \end{pmatrix}
$$

投影后，平面上的度量张量为：

$$
g_{map} = \begin{pmatrix} E & F \\ F & G \end{pmatrix}
$$

其中 $E, F, G$ 之前已经定义。

投影 $\Phi$ 将球面上的度量张量转换为平面上的度量张量：

$$
g_{map} = (\Phi^{-1})^* g_{sphere}
$$

其中 $(\Phi^{-1})^*$ 表示逆映射的拉回（pullback）。

在分量形式上，这意味着：

$$
g_{map,ij} = g_{sphere,kl} \frac{\partial \lambda_k}{\partial x_i} \frac{\partial \lambda_l}{\partial x_j}
$$

其中 $(\lambda_1, \lambda_2) = (\lambda, \phi)$ 。

**等角投影的度量条件**：等角投影要求局部相似，即存在尺度因子 $h$ 使得：

$$
g_{map} = h^2 \begin{pmatrix} \cos^2\phi & 0 \\ 0 & 1 \end{pmatrix} \cdot \frac{R^2}{ }
$$

这就是为什么等角投影在每一点的度量张量只是球面度量张量的标量乘法，没有旋转或剪切。

**等积投影的度量条件**：等积投影要求保持面积，即：

$$
\det(g_{map}) = \det(g_{sphere}) = R^4 \cos^2\phi
$$

或显式：

$$
EG - F^2 = R^4 \cos^2\phi
$$

这是一个偏微分方程约束，投影函数必须满足。

### 5.7.3 基于微分几何的投影分类

微分几何框架下，投影可以按其诱导的度量张量性质分类：

**共形映射（Conformal Mapping）**：

$$
g_{map} = \lambda^2(x,y) \cdot g_{sphere}
$$

即度量只是尺度因子 $\lambda$ 的乘法，保持角度和曲率符号。

**等距映射（Isometric Mapping）**：

$$
g_{map} = g_{sphere}
$$

保持度量完全不变。由绝妙定理，从球面到平面不存在此映射。

**保积映射（Area-preserving Mapping）**：

$$
\det(g_{map}) = \det(g_{sphere})
$$

保持行列式，即保持面积。

**保向映射（Orientation-preserving Mapping）**：

雅可比行列式为正： $|\frac{\partial(x, y)}{\partial(\lambda, \phi)}| > 0$ 。

大多数实际使用的投影都满足此条件。

**测地线映射（Geodesic Mapping）**：

将球面上的测地线（大圆）映射为平面上的直线段。除了等距投影，这类映射极少存在。

### 5.7.4 投影的共轭调和函数

等角投影使用复分析表示时，坐标函数 $(x, y)$ 可以认为是共轭调和函数。

设映射的复数为：

$$
z = x + iy = f(\lambda + i\phi) = f(w)
$$

其中 $f$ 是复解析函数。

分解为实部和虚部：

$$
x = \operatorname{Re}(f(w)), \quad y = \operatorname{Im}(f(w))
$$

实部和虚部 $x, y$ 都满足拉普拉斯方程（因为它们是调和函数）：

$$
\nabla^2 x = \frac{\partial^2 x}{\partial \lambda^2} + \frac{\partial^2 x}{\partial \phi^2} = 0
$$

$$
\nabla^2 y = \frac{\partial^2 y}{\partial \lambda^2} + \frac{\partial^2 y}{\partial \phi^2} = 0
$$

且满足柯西-黎曼方程，即它们是共轭调和函数：

$$
\frac{\partial x}{\partial \lambda} = \frac{\partial y}{\partial \phi}, \quad \frac{\partial x}{\partial \phi} = -\frac{\partial y}{\partial \lambda}
$$

这从另一个角度揭示了等角投影的数学优美性：投影坐标是调和函数，这使得它们具有许多良好的数学性质，如平均值原理、最大值原理等。

### 5.7.5 基于微分几何的投影变形分析

微分几何提供了分析投影变形的系统性方法：

**距离比例**：在方向 $(d\lambda, d\phi)$ 上，投影比例为：

$$
h = \sqrt{\frac{E d\lambda^2 + 2F d\lambda d\phi + G d\phi^2}{R^2 \cos^2\phi d\lambda^2 + R^2 d\phi^2}}
$$

**角度变形**：方向 $\mathbf{v}_1$ 和 $\mathbf{v}_2$ 的夹角从球面上的 $\theta$ 变为投影后的 $\theta'$ ：

$$
\cos\theta' = \frac{g_{map}(\mathbf{v}_1, \mathbf{v}_2)}{\sqrt{g_{map}(\mathbf{v}_1, \mathbf{v}_1)} \sqrt{g_{map}(\mathbf{v}_2, \mathbf{v}_2)}}
$$

其中 $g_{map}(\mathbf{v}, \mathbf{w}) = E v_1 w_1 + F(v_1 w_2 + v_2 w_1) + G v_2 w_2$ 。

**雅可比行列式的几何意义**：

$$
\det(g_{map}) = (EG - F^2) = |\frac{\partial x}{\partial \lambda} \frac{\partial y}{\partial \phi} - \frac{\partial x}{\partial \phi} \frac{\partial y}{\partial \lambda}|^2
$$

这是面积元素变换的平方。

这些公式都是微分几何框架下的标准结果，Tissot理论本质上是用这些微分几何工具来特化分析制图问题。

## 5.8 19世纪制图理论的综合

### 5.8.1 高斯-泰索理论的整合

19世纪中叶，高斯的曲面理论和泰索的指示椭圆理论相结合，形成了完整的现代制图理论基础：

**高斯理论**：

- 从微分几何角度理解投影本质
- 绝妙定理揭示了投影变形的内在限制
- 将投影问题表述为曲面的内蕴几何匹配问题

**泰索理论**：

- 提供了定量分析投影变形的方法
- Tissot指示椭圆将抽象概念可视化
- 各种失真度量使投影可比较和可优化

这两个理论的整合完成了制图学从定性描述到定量分析的转变。制图不再是艺术，而是严格的数学科学。

### 5.8.2 投影设计的方法论

19世纪成熟的投影设计方法论包括：

**1. 问题定义**：

- 确定制图区域（纬度范围 $[\phi_{min}, \phi_{max}]$ ，经度范围 $[\lambda_{min}, \lambda_{max}]$ ）
- 确定投影类型（等角、等积、等距或折衷）
- 确定投影轴（正常、横向、斜向）

**2. 数学表述**：

- 将投影要求转化为数学条件（如等角性： $F = 0$, $E/G = \cos^2\phi$ ）
- 建立边界条件（如中央经线无变形、特定纬线无变形）

**3. 求解微分方程**：

- 等角投影导出的偏微分方程（如柯西-黎曼方程）
- 等积投影导出的约束微分方程
- 使用积分、变换或数值方法求解

**4. 失真分析**：

- 计算主比例因子 $a$ 和 $b$ 的分布
- 计算角度变形 $\omega$ 、面积变形 $p$ 等
- 绘制失真等值线和Tissot椭圆分布

**5. 优化**：

- 根据失真分布调整投影参数
- 或使用变分法最小化某种失真积分

这一方法论使投影设计成为可重复、可验证的工程过程，而非单纯的经验艺术。

### 5.8.3 经典投影的数学分析

19世纪的制图学家使用新工具重新分析许多经典投影：

**墨卡托投影（1569年，19世纪重新分析）**：

- 等角性： $a = b = \sec\phi$
- 面积比例因子： $p = \sec^2\phi$
- 角度变形： $\omega = 0$ （各处）
- 极点奇异性： $\phi \to 90^{\circ}$ 时 $a, b \to \infty$

**Lambert等积方位投影（1772年，19世纪推广）**：

- $p = 1$ （各处，等积）
- 主方向：径向和切向
- 比例因子：径向 $a = \frac{2}{1 + \sin\phi}$ ，切向 $b = \frac{1}{a}$

**Aitoff投影（1889年，19世纪新投影）**：

- 折衷投影：不严格等角也不等积
- 优先减小角度变形，同时尽量保持整体面积
- 适合全球地图，变形分布相对均匀

这些分析揭示了经典投影的数学特性，使制图学家可以根据应用需求选择或设计最合适的投影。

### 5.8.4 制图理论的传播与教育

19世纪后半叶，成熟的制图理论开始系统化传播：

**教材编写**：

- 多部制图学教材出版，系统介绍理论框架
- 数学推导、失真分析、投影分类成为标准教学内容
- 教材中包含大量公式、图表和实例

**学术期刊**：

- 制图学专业期刊上发表关于新投影、方法改进的论文
- 失真分析成为论文评估新投影的标准方法

**工程标准**：

- 测绘局、制图机构开始采用标准化投影
- 投影参数、失真容限、质量标准有明确规定

这一时期，制图学从学术研究走向工程实践，成为地理测量、城市规划、航海导航等应用的基础学科。

## 5.9 总结

19世纪是制图学从实践技艺向严格理论体系转变的关键时期，这一转变的核心力量是数学特别是微分几何的引入和应用。

高斯的曲面理论和绝妙定理从几何本体论层面揭示了投影变形的本质：球面（或椭球面）与平面的高斯曲率不同，因此任何投影都无法完全保持球面的内蕴几何。这一理论从根本上解释了为什么地图投影必然存在变形，以及不同投影类型（等角、等积、等距）之间的权衡关系。

泰索的指示椭圆理论则提供了量化分析投影变形的工具系统。通过无限小圆投影为椭圆这一直观构造，Tissot将角度变形、面积变形、形状变形等抽象概念转化为可计算、可比较的数学量。Tissot椭圆不仅是一个可视化工具，更是一个完整的失真分析框架，使制图学研究从定性描述走向定量科学。

19世纪的数学进步对制图学的影响是多层次和深远的：

1. **理论层面的提升**：从几何直觉转向微分几何的严格证明
2. **方法层面的创新**：从经验设计转向基于微分方程的系统性求解
3. **分析层面的精确化**：从定性评价转向失真度量的精确计算
4. **优化层面的可能性**：从被动接受转向主动最小化目标函数

数学与制图的深度融合，使制图学成为连接几何学、分析学、物理学和地理学的交叉学科。这一学科不仅在19世纪取得了巨大进步，也为20世纪的数字制图、地理信息系统（GIS）、全球定位系统（GPS）等现代技术奠定了理论基础。

19世纪的制图学家们建立的不仅是一些具体的投影方法，更是一个理解空间、表达地球、分析变形的数学框架。这个框架的价值在于它的严格性、可扩展性和普适性。在数学的指引下，制图学超越了单纯的技术层面，成为人类理解地球和空间的科学语言。

当我们今天在数字地图上观察世界，使用GPS导航，或在GIS中分析地理数据时，我们实际上是在使用高斯、Tissot等19世纪数学家们创造的理论和方法。他们的工作证明了数学思维的统一力和普适性，也展示了自然科学如何通过数学而获得精确表述和深刻理解。制图学的这段历史是科学史上数学和应用相互促进的典范，其精神和遗产至今仍在指导着我们如何通过数学工具更好地理解和表达我们生活的三维世界。
