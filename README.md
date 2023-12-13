# CmakeCrossPlatformDemo
cmake windows 平台的编译，生成dll 的测试demo.
## 前提条件
1. cmake
2. vs 2019 version

## 编译指南
1. 执行 `generate_sln.bat` 生成build 目录
2. cd 到 `build`` 目录中, 执行如下命令：
    ```shell
      cmake --build .
    ```
3. 成功则会生成两个 dll 文件。

## cmake 编译说明
> 为了使得层级cmake 调用可以正常编译，windows 平台需要在最顶层级的`CMakeLists.txt` 中添加如下命令：
```cmake
  # To build shared libraries in Windows, we set CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS to TRUE.
# See https://cmake.org/cmake/help/v3.4/variable/CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS.html
# See https://blog.kitware.com/create-dlls-on-windows-without-declspec-using-new-cmake-export-all-feature/
set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)

```