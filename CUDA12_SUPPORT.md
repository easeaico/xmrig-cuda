# CUDA 12 支持修复

## 修复内容

### 1. 更新CUDA架构支持
- 添加了Hopper架构 (sm_90) 支持
- 更新了架构兼容性检查逻辑
- 移除了对已弃用架构的支持（CUDA 12中移除了Maxwell及更早架构）

### 2. 更新CMake配置
- 修改了 `cmake/CUDA.cmake` 中的架构映射
- 更新了 `cmake/CUDA-Version.cmake` 添加CUDA 12检测
- 修改了 `CMakeLists.txt` 中的版本检查逻辑

### 3. 添加CUDA 12优化
- 添加了 `CUDA_12_OPTIMIZATIONS` 编译标志
- 为CUDA 12添加了特定的编译优化

### 4. 架构支持矩阵

| CUDA版本 | 支持的架构 | 新增架构 |
|---------|-----------|---------|
| CUDA 8.x | 20,21,30,50,60 | - |
| CUDA 9.x | 30,50,60,70 | 70 (Volta) |
| CUDA 10.x | 30,50,60,70,75 | 75 (Turing) |
| CUDA 11.x | 35,50,60,70,75,80,86,87,89 | 80,86,87,89 (Ampere) |
| CUDA 12.x | 50,60,70,75,80,86,87,89,90 | 90 (Hopper) |

### 5. 主要修改文件

1. **cmake/CUDA.cmake**
   - 更新架构映射信息
   - 添加Hopper架构支持
   - 更新版本检查逻辑
   - 添加CUDA 12优化标志

2. **cmake/CUDA-Version.cmake**
   - 添加CUDA 12检测
   - 添加CUDA_12_SUPPORT宏定义

3. **CMakeLists.txt**
   - 更新CUDA版本检查逻辑
   - 添加CUDA 12支持消息

4. **build_cuda12.sh**
   - 创建构建脚本用于测试CUDA 12支持

## 使用方法

### 构建项目
```bash

# 或手动构建
mkdir build && cd build
cmake .. -DWITH_DRIVER_API=ON -DWITH_RANDOMX=ON -DWITH_KAWPOW=ON -DCMAKE_BUILD_TYPE=Release
make -j$(nproc)
```

### 支持的算法
- CryptoNight系列 (CN_0, CN_1, CN_2, CN_R, CN_LITE, CN_HEAVY, CN_PICO, CN_FEMTO)
- RandomX系列
- KawPow

### 系统要求
- CUDA Toolkit 12.x
- 支持CUDA 12的NVIDIA驱动
- CMake 3.5+
- 支持的GPU架构: Maxwell (5.0) 及以上

## 注意事项

1. CUDA 12移除了对Maxwell (5.0) 及更早架构的支持
2. 需要NVIDIA驱动版本 >= 525.60.13
3. 建议使用最新的CUDA Toolkit以获得最佳性能

## 测试

构建完成后，可以通过以下方式验证CUDA 12支持：

```bash
# 检查生成的库文件
ls -la build/libxmrig-cuda.so

# 检查CUDA版本信息
strings build/libxmrig-cuda.so | grep -i cuda
``` 