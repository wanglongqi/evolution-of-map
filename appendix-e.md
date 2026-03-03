---
nav_order: 18
---

# 附录E：实施参考（GDAL/PROJ示例）

本附录提供GDAL和PROJ库的实用代码示例，涵盖Python编程接口、命令行工具使用以及实际应用场景。示例从基础操作到高级应用，帮助读者快速掌握地图投影和坐标转换的实践技能。

---

## E.1 Python环境配置

### E.1.1 安装GDAL和PROJ

#### 通过PyPI安装

```bash
# 安装GDAL
pip install GDAL

# 安装pyproj（PROJ的Python接口）
pip install pyproj
```

#### 通过Conda安装（推荐）

```bash
# 创建新环境
conda create -n geospatial python=3.11

# 激活环境
conda activate geospatial

# 安装包
conda install -c conda-forge gdal pyproj rasterio
```

### E.1.2 版本检查

```python
# 检查GDAL版本
from osgeo import gdal
print(f"GDAL Version: {gdal.__version__}")

# 检查PROJ版本
import pyproj
print(f"PROJ Version: {pyproj.proj_version_str}")
```

---

## E.2 坐标参考系统管理（PROJ/PyProj）

### E.2.1 基础查询与验证

#### E.2.1.1 查询CRS信息

```python
from pyproj import CRS

# 通过EPSG代码创建CRS
crs_4326 = CRS.from_epsg(4326)
crs_3857 = CRS.from_epsg(3857)

# 获取CRS信息
print(f"EPSG:4326 - {crs_4326.name}")
print(f"类型: {crs_4326.type_info}")
print(f"椭球体: {crs_4326.ellipsoid.name}")
print(f"单位: {crs_4326.axis_info[0].unit_name}")

# 判断CRS是否为地理坐标系统
print(f"是否为地理坐标系统: {crs_4326.is_geographic}")
print(f"是否为投影坐标系统: {crs_3857.is_projected}")
```

#### E.2.1.2 通过WKT创建CRS

```python
# 通过WKT字符串创建CRS
wkt = """
GEOGCS["WGS 84",
    DATUM["World Geodetic System 1984",
        SPHEROID["WGS 84",6378137,298.257223563,
            AUTHORITY["EPSG","7030"]],
        AUTHORITY["EPSG","6326"]],
    PRIMEM["Greenwich",0,
        AUTHORITY["EPSG","8901"]],
    UNIT["degree",0.0174532925199433,
        AUTHORITY["EPSG","9122"]],
    AUTHORITY["EPSG","4326"]]
"""
crs_from_wkt = CRS.from_wkt(wkt)
print(f"EPSG代码: {crs_from_wkt.to_epsg()}")
```

#### E.2.1.3 通过PROJ字符串创建CRS

```python
# 传统PROJ4字符串
proj_string = "+proj=longlat +datum=WGS84 +no_defs"
crs_from_proj = CRS.from_proj4(proj_string)
print(f"CRS名称: {crs_from_proj.name}")
```

### E.2.2 坐标变换

#### E.2.2.1 单点转换

```python
from pyproj import Transformer

# 创建变换器
transformer = Transformer.from_crs("EPSG:4326", "EPSG:3857", always_xy=True)

# 转换单个坐标点（北京天安门）
lon, lat = 116.4074, 39.9042
x, y = transformer.transform(lon, lat)

print(f"经纬度: ({lon}, {lat})")
print(f"Web Mercator: ({x:.2f}, {y:.2f})")
```

#### E.2.2.2 批量坐标转换

```python
# 准备多个坐标点
coords = [
    (116.4074, 39.9042),  # 北京天安门
    (121.4737, 31.2304),  # 上海外滩
    (113.2644, 23.1291),  # 广州塔
]

# 批量转换
utm_zone = 50  # 中国大部分地区在50N
transformer_utm = Transformer.from_crs("EPSG:4326", f"EPSG:326{utm_zone}", always_xy=True)

results = [transformer_utm.transform(lon, lat) for lon, lat in coords]

for (lon, lat), (x, y) in zip(coords, results):
    print(f"({lon:.4f}, {lat:.4f}) -> UTM{utm_zone}N: ({x:.2f}, {y:.2f})")
```

#### E.2.2.3 NumPy数组转换（高效）

```python
import numpy as np
from pyproj import Transformer

# 创建大数组
n = 1000000
lons = np.linspace(110, 120, n)
lats = np.linspace(30, 40, n)
coords = np.column_stack([lons, lats])

# 转换
transformer = Transformer.from_crs("EPSG:4326", "EPSG:3857", always_xy=True)
x, y = transformer.transform(coords[:, 0], coords[:, 1])

print(f"转换了{n:,}个坐标点")
print(f"x范围: [{x.min():.2f}, {x.max():.2f}]")
print(f"y范围: [{y.min():.2f}, {y.max():.2f}]")
```

### E.2.3 中国区域常用CRS变换

#### E.2.3.1 WGS84到CGCS2000

```python
from pyproj import Transformer

# WGS84 (EPSG:4326) 到 CGCS2000 (EPSG:4490)
transformer = Transformer.from_crs("EPSG:4326", "EPSG:4490", always_xy=True)

# 广州塔坐标
lon, lat = 113.31917, 23.10427
lon_cgcs, lat_cgcs = transformer.transform(lon, lat)

print(f"WGS84: ({lon:.8f}, {lat:.8f})")
print(f"CGCS2000: ({lon_cgcs:.8f}, {lat_cgcs:.8f})")
print(f"差异: ({abs(lon-lon_cgcs)*111320*math.cos(math.radians(lat)):.3f}m, {abs(lat-lat_cgcs)*110574:.3f}m)")
```

#### E.2.3.2 CGCS2000到UTM投影

```python
# 判断UTM带
def get_utm_zone(lon):
    return int((lon + 180) / 6) + 1

lon, lat = 113.31917, 23.10427
utm_zone = get_utm_zone(lon)
epsg_utm = f"EPSG:326{utm_zone}"  # 北半球

transformer = Transformer.from_crs("EPSG:4490", epsg_utm, always_xy=True)
easting, northing = transformer.transform(lon, lat)

print(f"UTM Zone: {utm_zone}N")
print(f"Easting: {easting:.2f}m")
print(f"Northing: {northing:.2f}m")
```

### E.2.4 高级变换：网格基准变换

```python
# 使用网格进行高精度基准变换（如果可用）
# 注意：需要安装PROJ资源文件（+nadgrids）

try:
    # NAD83到WGS84使用NTv2网格
    transformer = Transformer.from_pipeline(
        "+proj=pipeline +step +proj unitconvert +xy_in=deg +xy_out=rad "
        "+step +proj=hgridshifts +grids=ntv2_0.gsb "
        "+step +proj unitconvert +xy_in=rad +xy_out=deg"
    )

    lon, lat = -75, 40  # 纽约附近
    lon_trans, lat_trans = transformer.transform(lon, lat)
    print(f"基准变换: ({lon}, {lat}) -> ({lon_trans:.10f}, {lat_trans:.10f})")
except Exception as e:
    print(f"网格变换可能需要额外资源: {e}")
```

### E.2.5 边界与区域转换

```python
from shapely.geometry import Polygon, box
from pyproj import CRS, Transformer
import numpy as np

# 创建一个矩形区域
min_lon, min_lat = 116.0, 39.0
max_lon, max_lat = 117.0, 40.0
polygon = box(min_lon, min_lat, max_lon, max_lat)

# 转换为UTM并计算面积
utm_zone = get_utm_zone((min_lon + max_lon) / 2)
epsg_utm = f"EPSG:326{utm_zone}"

transformer = Transformer.from_crs("EPSG:4326", epsg_utm, always_xy=True)

# 提取边界并转换
coords = list(polygon.exterior.coords)
transformed_coords = [transformer.transform(lon, lat) for lon, lat in coords]

# 创建变换后的多边形
utm_polygon = Polygon(transformed_coords)
area_km2 = utm_polygon.area / 1_000_000

print(f"区域面积: {area_km2:.2f} km²")
```

---

## E.3 栅格数据处理（GDAL）

### E.3.1 读取栅格数据

#### E.3.1.1 基本读取

```python
from osgeo import gdal, osr
import numpy as np

# 打开GeoTIFF文件
dataset = gdal.Open('input.tif')

if dataset:
    # 获取基本信息
    print(f"驱动: {dataset.GetDriver().ShortName}")
    print(f"宽度: {dataset.RasterXSize}")
    print(f"高度: {dataset.RasterYSize}")
    print(f"波段数: {dataset.RasterCount}")

    # 获取地理转换参数（仿射变换）
    geotransform = dataset.GetGeoTransform()
    print(f"原点X: {geotransform[0]:.2f}")
    print(f"X分辨率: {geotransform[1]:.2f}")
    print(f"旋转: {geotransform[2]:.2f}")
    print(f"原点Y: {geotransform[3]:.2f}")
    print(f"旋转: {geotransform[4]:.2f}")
    print(f"Y分辨率: {geotransform[5]:.2f}")

    # 获取投影
    prj = dataset.GetProjection()
    srs = osr.SpatialReference(wkt=prj)
    print(f"CRS: {srs.GetAttrValue('projcs') or srs.GetAttrValue('geogcs')}")

    # 读取第一个波段
    band = dataset.GetRasterBand(1)
    data = band.ReadAsArray()
    print(f"数据形状: {data.shape}")
    print(f"数据类型: {gdal.GetDataTypeName(band.DataType)}")

dataset = None  # 关闭数据集
```

#### E.3.1.2 子区域读取（高效处理大文件）

```python
import numpy as np

dataset = gdal.Open('large_raster.tif')

# 定义子区域
xoff, yoff = 1000, 1000  # 起始位置（像素）
xsize, ysize = 512, 512   # 读取大小

# 读取子区域
band = dataset.GetRasterBand(1)
subdata = band.ReadAsArray(xoff, yoff, xsize, ysize)

# 计算子区域的地理坐标
geotransform = dataset.GetGeoTransform()
sub_min_x = geotransform[0] + xoff * geotransform[1]
sub_max_y = geotransform[3] + yoff * geotransform[5]
sub_max_x = sub_min_x + xsize * geotransform[1]
sub_min_y = sub_max_y + ysize * geotransform[5]

print(f"子区域空间范围:")
print(f"X: [{sub_min_x:.2f}, {sub_max_x:.2f}]")
print(f"Y: [{sub_min_y:.2f}, {sub_max_y:.2f}]")

dataset = None
```

### E.3.2 栅格重投影

#### E.3.2.1 基本重投影

```python
from osgeo import gdal

# 打开输入数据
dataset = gdal.Open('input_4326.tif')

# 执行重投影
output_file = 'output_3857.tif'
gdal.Warp(
    output_file,
    dataset,
    dstSRS='EPSG:3857',           # 目标CRS
    resampleAlg=gdal.GRA_Bilinear, # 双线性插值
    xRes=30, yRes=30               # 输出分辨率（米）
)

print(f"重投影完成: {output_file}")
```

#### E.3.2.2 保持原始分辨率重投影

```python
# 计算原始分辨率
dataset = gdal.Open('input.tif')
geotransform = dataset.GetGeoTransform()
pixel_size_x = abs(geotransform[1])
pixel_size_y = abs(geotransform[5])

# 重投影（自动分辨率计算）
gdal.Warp(
    'output_resamp.tif',
    dataset,
    dstSRS='EPSG:3857',
    dstAT=True,  # 调整变换以保持最佳分辨率
    targetAlignedPixels=True
)

dataset = None
```

#### E.3.2.3 重采样方法选择

| 方法 | gdal常量 | 使用场景 |
|------|----------|----------|
| 最近邻 | GRA_NearestNeighbour | 分类数据，保持原始值 |
| 双线性 | GRA_Bilinear | 连续数据，平滑过渡 |
| 三次卷积 | GRA_Cubic | 质量优先，计算量较大 |
| Lanczos | GRA_Lanczos | 高质量重采样 |

```python
# 高质量重采样
gdal.Warp(
    'output_high_quality.tif',
    input_dataset,
    dstSRS='EPSG:3857',
    resampleAlg=gdal.GRA_Cubic,
    warpOptions=["NUM_THREADS=ALL_CPUS"]
)
```

### E.3.3 栅格裁剪与裁剪

#### E.3.3.1 按边界框裁剪

```python
from osgeo import gdal, osr

dataset = gdal.Open('input.tif')

# 定义裁剪边界（投影坐标）
min_x, max_x = 116.0, 117.0
min_y, max_y = 39.0, 40.0

# 如果裁剪范围与输入CRS不同，需要先转换
# 此处假设为相同CRS

output_file = 'clipped.tif'
gdal.Translate(
    output_file,
    dataset,
    projWin=[min_x, max_y, max_x, min_y],  # [x_min, y_max, x_max, y_min]
    outputBounds=[min_x, min_y, max_x, max_y]
)

dataset = None
```

#### E.3.3.2 按矢量多边形裁剪

```python
from osgeo import gdal, ogr

# 打开裁剪矢量
shapefile = 'clip_polygon.shp'
vector_ds = ogr.Open(shapefile)
vector_layer = vector_ds.GetLayer()

# 执行裁剪
gdal.Warp(
    'clipped_by_vector.tif',
    'input.tif',
    cutlineDSName=shapefile,
    cutlineLayer=vector_layer.GetName(),
    cropToCutline=True,
    dstNodata=-9999  # 裁剪区域外的填充值
)

vector_ds = None
```

### E.3.4 栅格金字塔构建

```python
from osgeo import gdal

dataset = gdal.Open('input.tif', gdal.GA_Update)

# 构建金字塔层级
# 层级: [2, 4, 8, 16, 32] 意味着构建2倍、4倍等下采样
gdal.BuildOverviews(
    dataset,
    overviewlist=[2, 4, 8, 16, 32],
    resamplingmethod='AVERAGE'  # 平均值下采样
)

# 验证金字塔
print("金字塔层级:")
for i, overview in enumerate(dataset.GetRasterBand(1).GetOverviews()):
    print(f"  层级 {i+1}: {overview.XSize} x {overview.YSize}")

dataset = None
```

### E.3.5 创建栅格数据

```python
import numpy as np
from osgeo import gdal, osr

# 创建示例数据
width, height = 1000, 1000
data = np.random.rand(height, width) * 100

# 设置地理范围和投影
min_x, min_y = 116.0, 39.0
pixel_size = 0.001  # 约100米
max_x = min_x + width * pixel_size
max_y = min_y + height * pixel_size

# 设置投影
srs = osr.SpatialReference()
srs.ImportFromEPSG(4326)
prj = srs.ExportToWkt()

# 创建GeoTIFF
driver = gdal.GetDriverByName('GTiff')
dataset = driver.Create('output.tif', width, height, 1, gdal.GDT_Float64)

# 设置地理变换和投影
dataset.SetGeoTransform([min_x, pixel_size, 0, max_y, 0, -pixel_size])
dataset.SetProjection(prj)

# 写入数据
band = dataset.GetRasterBand(1)
band.SetNoDataValue(-9999)
band.WriteArray(data)

# 计算统计数据并压缩
band.FlushCache()
band.ComputeStatistics(False)

dataset = None

print("栅格文件创建完成: output.tif")
```

### E.3.6 多波段处理（RGB合成）

```python
from osgeo import gdal

# 打开多个单波段文件（如红绿蓝）
red_band = gdal.Open('red.tif').GetRasterBand(1)
green_band = gdal.Open('green.tif').GetRasterBand(1)
blue_band = gdal.Open('blue.tif').GetRasterBand(1)

# 创建输出文件（3波段）
driver = gdal.GetDriverByName('GTiff')
width, height = red_band.XSize, red_band.YSize
output = driver.Create('rgb.tif', width, height, 3, gdal.GDT_Byte)

# 复制地理变换和投影
input_ds = gdal.Open('red.tif')
output.SetGeoTransform(input_ds.GetGeoTransform())
output.SetProjection(input_ds.GetProjection())

# 写入波段
output.GetRasterBand(1).WriteArray(red_band.ReadAsArray())
output.GetRasterBand(2).WriteArray(green_band.ReadAsArray())
output.GetRasterBand(3).WriteArray(blue_band.ReadAsArray())

# 设置波段名称
output.GetRasterBand(1).SetDescription('Red')
output.GetRasterBand(2).SetDescription('Green')
output.GetRasterBand(3).SetDescription('Blue')

output = None
print("RGB合成完成: rgb.tif")
```

---

## E.4 矢量数据处理（GDAL/OGR）

### E.4.1 读取矢量数据

#### E.4.1.1 遍历要素

```python
from osgeo import ogr

# 打开Shapefile
driver = ogr.GetDriverByName('ESRI Shapefile')
data_source = driver.Open('input.shp', 0)  # 0: 只读

if data_source:
    layer = data_source.GetLayer()
    layer_defn = layer.GetLayerDefn()

    print(f"坐标系: {layer.GetSpatialRef().GetName()}")
    print(f"要素数量: {layer.GetFeatureCount()}")
    print(f"字段数: {layer_defn.GetFieldCount()}")

    # 遍历前5个要素
    for i, feature in enumerate(layer):
        if i >= 5:
            break

        geometry = feature.GetGeometryRef()
        print(f"\n要素 {i}:")
        print(f"  几何类型: {geometry.GetGeometryName()}")
        print(f"  WKT: {geometry.ExportToWkt()}")

        # 读取属性
        for j in range(layer_defn.GetFieldCount()):
            field_defn = layer_defn.GetFieldDefn(j)
            field_name = field_defn.GetName()
            field_value = feature.GetField(field_name)
            print(f"  {field_name}: {field_value}")

data_source = None
```

#### E.4.1.2 空间查询

```python
data_source = driver.Open('input.shp')
layer = data_source.GetLayer()

# 创建查询空间（点）
from osgeo import ogr
query_point = ogr.CreateGeometryFromWkt('POINT(116.4074 39.9042)')

# 设置空间过滤器
layer.SetSpatialFilter(query_point)

# 查询结果
print("包含该点的要素:")
for feature in layer:
    geometry = feature.GetGeometryRef()
    print(f"ID: {feature.GetFID()}, 几何: {geometry.GetGeometryName()}")

data_source = None
```

### E.4.2 创建矢量数据

#### E.4.2.1 创建点要素

```python
from osgeo import ogr, osr

# 创建输出文件
driver = ogr.GetDriverByName('ESRI Shapefile')
data_source = driver.CreateDataSource('output_points.shp')

# 设置投影
srs = osr.SpatialReference()
srs.ImportFromEPSG(4326)

# 创建图层
layer = data_source.CreateLayer('points', srs, ogr.wkbPoint)

# 创建字段
layer.CreateField(ogr.FieldDefn('name', ogr.OFTString))
layer.CreateField(ogr.FieldDefn('population', ogr.OFTInteger))

# 创建要素
cities = [
    ('北京', 116.4074, 39.9042, 21540000),
    ('上海', 121.4737, 31.2304, 24870000),
    ('广州', 113.2644, 23.1291, 18000000),
]

for name, lon, lat, pop in cities:
    feature = ogr.Feature(layer.GetLayerDefn())
    feature.SetField('name', name)
    feature.SetField('population', pop)

    # 创建几何
    point = ogr.Geometry(ogr.wkbPoint)
    point.AddPoint(lon, lat)
    feature.SetGeometry(point)

    layer.CreateFeature(feature)
    feature = None  # 释放资源

data_source = None
print(f"创建要素完成: output_points.shp")
```

#### E.4.2.2 创建多边形要素

```python
data_source = driver.CreateDataSource('output_polygons.shp')
srs = osr.SpatialReference()
srs.ImportFromEPSG(3857)

layer = data_source.CreateLayer('polygons', srs, ogr.wkbPolygon)
layer.CreateField(ogr.FieldDefn('name', ogr.OFTString))
layer.CreateField(ogr.FieldDefn('area_km2', ogr.OFTReal))

# 创建多边形
polygon = ogr.Geometry(ogr.wkbPolygon)
ring = ogr.Geometry(ogr.wkbLinearRing)

# 多边形顶点（顺时针）
ring.AddPoint(12960000, 4850000)
ring.AddPoint(12965000, 4850000)
ring.AddPoint(12965000, 4855000)
ring.AddPoint(12960000, 4855000)
ring.AddPoint(12960000, 4850000)  # 闭合

polygon.AddGeometry(ring)

# 创建要素
feature = ogr.Feature(layer.GetLayerDefn())
feature.SetField('name', '区域A')
feature.SetField('area_km2', polygon.GetArea() / 1_000_000)
feature.SetGeometry(polygon)

layer.CreateFeature(feature)

data_source = None
```

### E.4.3 矢量重投影

#### E.4.3.1 使用ogr2ogr重投影

```python
# 命令行方式（推荐）
import os

os.system('ogr2ogr -t_srs EPSG:3857 output_3857.shp input_4326.shp')

# Python API方式
from osgeo import ogr, osr

# 打开输入数据
in_ds = ogr.Open('input.shp')
in_layer = in_ds.GetLayer()
in_srs = in_layer.GetSpatialRef()

# 设置输出CRS
out_srs = osr.SpatialReference()
out_srs.ImportFromEPSG(3857)

# 创建坐标变换
coord_transform = osr.CoordinateTransformation(in_srs, out_srs)

# 创建输出数据
out_driver = ogr.GetDriverByName('ESRI Shapefile')
out_ds = out_driver.CreateDataSource('output.shp')
out_layer = out_ds.CreateLayer('output', out_srs, in_layer.GetGeomType())

# 创建字段
in_layer_defn = in_layer.GetLayerDefn()
for i in range(in_layer_defn.GetFieldCount()):
    out_layer.CreateField(in_layer_defn.GetFieldDefn(i))

# 转换要素
for in_feat in in_layer:
    out_feat = ogr.Feature(out_layer.GetLayerDefn())

    # 复制属性
    for i in range(in_layer_defn.GetFieldCount()):
        out_feat.SetField(i, in_feat.GetField(i))

    # 转换几何
    geom = in_feat.GetGeometryRef()
    geom.Transform(coord_transform)
    out_feat.SetGeometry(geom)

    out_layer.CreateFeature(out_feat)

in_ds = None
out_ds = None
```

### E.4.4 空间分析

#### E.4.4.1 缓冲区分析

```python
from osgeo import ogr

data_source = ogr.Open('input.shp')
layer = data_source.GetLayer()

# 创建缓冲区输出
out_driver = ogr.GetDriverByName('GeoJSON')
out_ds = out_driver.CreateDataSource('buffered.json')
out_layer = out_ds.CreateLayer('buffered', layer.GetSpatialRef())

# 缓冲距离（单位与CRS相同，如米）
buffer_distance = 1000

for feature in layer:
    geom = feature.GetGeometryRef()
    buffered_geom = geom.Buffer(buffer_distance)

    out_feat = ogr.Feature(out_layer.GetLayerDefn())
    out_feat.SetGeometry(buffered_geom)
    out_layer.CreateFeature(out_feat)

data_source = None
out_ds = None
```

#### E.4.4.2 求交分析

```python
# 打开两个图层
roads_ds = ogr.Open('roads.shp')
roads_layer = roads_ds.GetLayer()

buildings_ds = ogr.Open('buildings.shp')
buildings_layer = buildings_ds.GetLayer()

# 创建输出
out_ds = ogr.GetDriverByName('GeoJSON').CreateDataSource('intersect.json')
out_layer = out_ds.CreateLayer('intersect', roads_layer.GetSpatialRef())

# 求交
for road_feat in roads_layer:
    road_geom = road_feat.GetGeometryRef()

    for build_feat in buildings_layer:
        build_geom = build_feat.GetGeometryRef()

        # 几何交集
        inter_geom = road_geom.Intersection(build_geom)

        if inter_geom.IsEmpty():
            continue

        out_feat = ogr.Feature(out_layer.GetLayerDefn())
        out_feat.SetGeometry(inter_geom)
        out_layer.CreateFeature(out_feat)

roads_ds = None
buildings_ds = None
out_ds = None
```

---

## E.5 GDAL命令行工具

### E.5.1 gdalinfo - 栅格信息查询

```bash
# 基本信息查询
gdalinfo input.tif

# 查询坐标系统详细信息
gdalinfo -proj4 input.tif

# 查询最小最大值
gdalinfo -mm input.tif

# 查询统计数据（近似）
gdalinfo -stats input.tif

# 仅查询元数据
gdalinfo -nomd input.tif

# 输出JSON格式
gdalinfo -json input.tif > info.json
```

### E.5.2 gdal_translate - 格式转换

```bash
# 栅格格式转换
gdal_translate -of GTiff input.jpg output.tif

# 指定子区域（xoff yoff xsize ysize）
gdaltranslate -srcwin 0 0 1000 1000 input.tif output_subset.tif

# 裁剪矩形
gdal_translate -projwin 116.0 40.0 117.0 39.0 input.tif output_clipped.tif

# 压缩选项
gdal_translate -co COMPRESS=LZW -co TILED=YES -co BIGTIFF=YES input.tif output_compressed.tif

# 调整分辨率（放大）
gdal_translate -outsize 2000% 2000% input.tif output_scaled_up.tif

# 调整分辨率（缩小）
gdal_translate -outsize 50% 50% input.tif output_scaled_down.tif
```

### E.5.3 gdalwarp - 重投影与处理

```bash
# 基本重投影
gdalwarp -t_srs EPSG:3857 input_4326.tif output_3857.tif

# 指定输出分辨率
gdalwarp -t_srs EPSG:3857 -tr 30 30 input.tif output_resampled.tif

# 重采样方法
gdalwarp -t_srs EPSG:3857 -r cubic input.tif output_cubic.tif
gdalwarp -t_srs EPSG:3857 -r near input.tif output_near.tif

# 裁剪重投影
gdalwarp -t_srs EPSG:3857 -te 12960000 4850000 12970000 4860000 input.tif output_clipped.tif
# -顺序: xmin ymin xmax ymax

# 重投影并裁剪（先投影后裁剪）
gdalwarp -t_srs EPSG:3857 -crop_to_cutline -cutline input_polygon.shp input.tif output.tif

# 多线程处理
gdalwarp -t_srs EPSG:3857 -wo NUM_THREADS=ALL_CPUS input.tif output.tif

# 目标对齐像素（瓦片对齐）
gdalwarp -t_srs EPSG:3857 -dstnodata -9999 -targetAlignedPixels input.tif output.tif
```

### E.5.4 ogr2ogr - 矢量转换

```bash
# 格式转换
ogr2ogr -f "GeoJSON" output.json input.shp

# 重投影
ogr2ogr -t_srs EPSG:3857 output_3857.shp input_4326.shp

# 保持属性表结构
ogr2ogr -f "Esri Shapefile" -preserve_fid output.shp input.geojson

# 属性过滤（SQL）
ogr2ogr -where "population > 1000000" output.shp input.shp

# 使用空间查询
ogr2ogr -spat 116 39 118 41 output.shp input.shp

# 仅几何（无属性）
ogr2ogr -select "" output.shp input.shp

# 仅特定字段
ogr2ogr -select "name,population" output.shp input.shp

# 追加到现有文件
ogr2ogr -append -update output.shp input_new.shp

# 覆盖现有文件
ogr2ogr -overwrite output.shp input.shp
```

### E.5.5 gdaladdo - 构建金字塔

```bash
# 构建金字塔
gdaladdo -r average input.tif 2 4 8 16 32

# 生成外部金字塔
gdaladdo -r average --config USE_RRD YES input.tif 2 4 8 16

# 仅验证是否已有金字塔
gdaladdo -r nearest input.tif --clean
```

---

## E.6 实际应用案例

### E.6.1 案例1：Web地图瓦片生成

#### 场景说明：生成Web格式的地图瓦片（TMS/XYZ格式）

```python
import math
from osgeo import gdal

def lonlat_to_tile(lon, lat, zoom):
    """将经纬度转换为瓦片坐标"""
    n = 2.0 ** zoom
    xtile = int((lon + 180.0) / 360.0 * n)
    ytile = int((1.0 - math.log(math.tan(math.radians(lat)) + 1.0/math.cos(math.radians(lat))) / math.pi) / 2.0 * n)
    return xtile, ytile

def tile_to_lonlat(xtile, ytile, zoom):
    """将瓦片坐标转换为经纬度"""
    n = 2.0 ** zoom
    lon = xtile / n * 360.0 - 180.0
    lat_rad = math.atan(math.sinh(math.pi * (1 - 2 * ytile / n)))
    lat = math.degrees(lat_rad)
    return lon, lat

def generate_tile(input_raster, output_tile, x, y, zoom, size=256):
    """生成单个瓦片"""
    # 计算瓦片边界（Web Mercator，EPSG:3857）
    lon_max, lat_max = tile_to_lonlat(x, y, zoom)
    lon_min, lat_min = tile_to_lonlat(x + 1, y + 1, zoom)

    # 创建临时VRT
    vrt_options = gdal.WarpOptions(
        format='VRT',
        outputBounds=[lon_min, lat_min, lon_max, lat_max],
        xRes=size, yRes=size,
        dstSRS='EPSG:3857',
        resampleAlg=gdal.GRA_Bilinear
    )

    # 执行重投影并输出PNG
    gdal.Warp(
        output_tile,
        input_raster,
        options=gdal.WarpOptions(
            format='PNG',
            xRes=size,
            yRes=size,
            outputBounds=[lon_min, lat_min, lon_max, lat_max],
            dstSRS='EPSG:3857',
            resampleAlg=gdal.GRA_Bilinear
        )
    )

# 示例：生成缩放级别12的瓦片
input_raster = 'base_map.tif'
zoom = 12
x, y = lonlat_to_tile(116.4074, 39.9042, zoom)  # 北京

generate_tile(input_raster, f'tile_{zoom}_{x}_{y}.png', x, y, zoom)

print(f"生成瓦片: tile_{zoom}_{x}_{y}.png")
```

### E.6.2 案例2：多源数据融合

#### 场景说明：融合多个数据源（栅格+矢量）并进行统一投影

```python
from osgeo import gdal, ogr, osr
import numpy as np

def create_base_raster(output_file, min_x, max_x, min_y, max_y, resolution=30):
    """创建基础栅格"""
    width = int((max_x - min_x) / resolution)
    height = int((max_y - min_y) / resolution)

    driver = gdal.GetDriverByName('GTiff')
    dataset = driver.Create(
        output_file,
        width,
        height,
        1,  # 单波段
        gdal.GDT_Float64
    )

    # 设置地理信息和投影
    dataset.SetGeoTransform([min_x, resolution, 0, max_y, 0, -resolution])

    srs = osr.SpatialReference()
    srs.ImportFromEPSG(3857)
    dataset.SetProjection(srs.ExportToWkt())

    # 初始化数据
    data = np.zeros((height, width), dtype=np.float64)
    band = dataset.GetRasterBand(1)
    band.WriteArray(data)
    band.SetNoDataValue(-9999)

    dataset = None
    return output_file

def rasterize_vector(raster_file, vector_file, burn_value=1):
    """将矢量栅格化到栅格"""
    # 打开栅格
    raster_ds = gdal.Open(raster_file, gdal.GA_Update)
    band = raster_ds.GetRasterBand(1)

    # 打开矢量
    vector_ds = ogr.Open(vector_file)
    vector_layer = vector_ds.GetLayer()

    # 栅格化
    gdal.RasterizeLayer(
        raster_ds,
        [1],
        vector_layer,
        burn_values=[burn_value]
    )

    raster_ds = None
    vector_ds = None

# 创建融合范围（北京区域）
min_x, max_x = 12900000, 13000000  # Web Mercator范围
min_y, max_y = 4850000, 4950000
resolution = 100

# 1. 创建基础栅格
base_raster = 'base_fusion.tif'
create_base_raster(base_raster, min_x, max_x, min_y, max_y, resolution)

# 2. 叠加矢量数据（如道路）
# 假设有roads.shp（已重投影到EPSG:3857）
# rasterize_vector(base_raster, 'roads.shp', burn_value=1)

# 3. 叠加另一栅格（如高程模型）
# elevation_ds = gdal.Open('dem.tif')
# warped_elevation = 'dem_warped.tif'
# gdal.Warp(warped_elevation, elevation_ds,
#           dstSRS='EPSG:3857',
#           outputBounds=[min_x, min_y, max_x, max_y],
#           xRes=resolution, yRes=resolution)

# 4. 数值计算栅格数据
ds = gdal.Open(base_raster, gdal.GA_Update)
band = ds.GetRasterBand(1)
data = band.ReadAsArray()

# 示例：添加随机噪声模拟高程
data += np.random.rand(*data.shape) * 10

band.WriteArray(data)
ds = None

print(f"数据融合完成: {base_raster}")
```

### E.6.3 案例3：大数据批处理

#### 场景说明：批量处理大量栅格文件（重投影+压缩）

```python
import os
import glob
from osgeo import gdal
from concurrent.futures import ProcessPoolExecutor, as_completed

def process_raster(input_file, output_dir, target_crs='EPSG:3857'):
    """处理单个栅格文件"""
    basename = os.path.basename(input_file)
    output_file = os.path.join(output_dir, f'processed_{basename}')

    try:
        # 重投影并压缩
        gdal.Warp(
            output_file,
            input_file,
            dstSRS=target_crs,
            resampleAlg=gdal.GRA_Bilinear,
            creationOptions=[
                'COMPRESS=LZW',
                'TILED=YES',
                'BIGTIFF=IF_NEEDED'
            ],
            warpOptions=['NUM_THREADS=1']  # 每个进程单线程
        )
        print(f"完成: {output_file}")
        return output_file
    except Exception as e:
        print(f"错误处理 {input_file}: {e}")
        return None

def batch_process(input_dir, output_dir, num_workers=4):
    """批量处理"""
    # 创建输出目录
    os.makedirs(output_dir, exist_ok=True)

    # 获取输入文件列表
    input_files = glob.glob(os.path.join(input_dir, '*.tif'))

    print(f"找到 {len(input_files)} 个文件待处理")

    # 多进程并行处理
    with ProcessPoolExecutor(max_workers=num_workers) as executor:
        futures = [executor.submit(process_raster, f, output_dir) for f in input_files]

        # 等待所有任务完成
        results = [future.result() for future in as_completed(futures)]

    success_count = sum(1 for r in results if r is not None)
    print(f"处理完成: {success_count}/{len(input_files)} 个文件")

# 使用示例
batch_process('input_tifs', 'output_tifs', num_workers=4)
```

### E.6.4 案例4：动态投影服务

#### 场景说明：根据用户请求动态重投影并返回数据

```python
from flask import Flask, request, send_file
from osgeo import gdal
import tempfile
import os

app = Flask(__name__)

@app.route('/api/warp')
def warp_raster():
    """栅格重投影API"""
    # 获取参数
    input_file = request.args.get('input')
    target_crs = request.args.get('crs', 'EPSG:3857')
    resolution = float(request.args.get('resolution', 30))

    if not input_file or not os.path.exists(input_file):
        return "错误: 输入文件不存在", 400

    # 创建临时输出文件
    with tempfile.NamedTemporaryFile(suffix='.tif', delete=False) as tmp:
        output_file = tmp.name

    try:
        # 重投影
        gdal.Warp(
            output_file,
            input_file,
            dstSRS=target_crs,
            xRes=resolution,
            yRes=resolution,
            resampleAlg=gdal.GRA_Bilinear
        )

        # 返回文件
        return send_file(output_file, mimetype='image/tiff')

    except Exception as e:
        return f"错误: {str(e)}", 500

@app.route('/api/info')
def raster_info():
    """栅格信息查询API"""
    input_file = request.args.get('input')

    if not input_file or not os.path.exists(input_file):
        return "错误: 输入文件不存在", 400

    ds = gdal.Open(input_file)
    if not ds:
        return "错误: 无法打开文件", 400

    info = {
        'driver': ds.GetDriver().ShortName,
        'size': [ds.RasterXSize, ds.RasterYSize],
        'bands': ds.RasterCount,
        'projection': ds.GetProjection(),
        'geotransform': ds.GetGeoTransform()
    }

    ds = None
    return info

if __name__ == '__main__':
    app.run(debug=True, port=5000)
```

---

## E.7 错误处理与最佳实践

### E.7.1 常见错误与解决方案

#### E.7.1.1 投影错误

```python
# 错误: 无法识别EPSG代码
try:
    crs = CRS.from_epsg(999999)  # 不存在
except Exception as e:
    print(f"CRS错误: {e}")
    # 解决方案: 检查EPSG代码是否正确
```

#### E.7.1.2 数据类型不匹配

```python
# 错误: 栅格数据类型不兼容
dataset = gdal.Open('input.tif')
if dataset:
    band = dataset.GetRasterBand(1)
    data_type = band.DataType

    # 确保输出数据类型兼容
    driver = gdal.GetDriverByName('GTiff')
    output = driver.Create('output.tif', width, height, 1, data_type)  # 使用相同类型
    output = None
dataset = None
```

#### E.7.1.3 内存溢出

```python
# 对大文件逐块处理，避免内存溢出
def process_large_raster(input_file, output_file, block_size=1024):
    dataset = gdal.Open(input_file)
    width, height = dataset.RasterXSize, dataset.RasterYSize

    driver = gdal.GetDriverByName('GTiff')
    output = driver.Create(output_file, width, height, 1, gdal.GDT_Float32)
    output.SetGeoTransform(dataset.GetGeoTransform())
    output.SetProjection(dataset.GetProjection())

    output_band = output.GetRasterBand(1)

    # 逐块处理
    for y in range(0, height, block_size):
        for x in range(0, width, block_size):
            block_width = min(block_size, width - x)
            block_height = min(block_size, height - y)

            data = dataset.GetRasterBand(1).ReadAsArray(x, y, block_width, block_height)

            # 处理数据（例如：乘以常数）
            processed_data = data * 1.5

            output_band.WriteArray(processed_data, x, y)

    dataset = None
    output = None
```

### E.7.2 性能优化建议

**1. 批量处理优于单个处理**

```python
# 推荐: 批量转换
gdal.Warp('output.tif', ['input1.tif', 'input2.tif'], ...)

# 避免: 逐个转换
gdal.Warp('output1.tif', 'input1.tif', ...)
gdal.Warp('output2.tif', 'input2.tif', ...)
```

**2. 使用金字塔加速显示**

```bash
gdaladdo -r average input.tif 2 4 8 16
```

**3. 选择合适的压缩格式**

```python
# 连续数据: LZW
# 分类数据: DEFLATE或无压缩
# 网络: JPEG（如果质量可接受）
```

**4. 多线程处理**

```bash
gdalwarp --config GDAL_NUM_THREADS ALL_CPUS -t_srs EPSG:3857 input.tif output.tif
```

---

## E.8 参考资源

### E.8.1 官方文档

- **GDAL官网**: https://gdal.org
- **PROJ官网**: https://proj.org
- **PyProj文档**: https://pyproj4.github.io/pyproj/
- **OSGeo wiki**: https://trac.osgeo.org/

### E.8.2 示例数据

- **Natural Earth数据**: https://www.naturalearthdata.com/
- **OpenStreetMap**: https://www.openstreetmap.org/
- **USGS Earth Explorer**: https://earthexplorer.usgs.gov/

---

**说明**：本附录提供了GDAL和PROJ库的综合实践示例，涵盖从基础操作到复杂应用的完整流程。示例采用Python编程语言，配合命令行工具，旨在帮助读者快速掌握地图投影和坐标转换的实用技能。对于生产环境应用，建议进一步阅读官方文档并关注性能优化和错误处理。
