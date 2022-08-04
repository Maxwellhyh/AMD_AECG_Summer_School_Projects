## Repository Tree
```
.
├── filter2d.cpp        //源码框架
├── filter2d.h          //头文件
├── filter2d_test.cpp   //测试源码
├── src.txt             //测试输入
├── dst.txt             //标准输出
├── tcl_script.tcl      //tcl文件
└── README.md           //说明文件
```
## filter2d （最近一次更新：8月4日）

1. 框架代码说明

    框架代码是算法的C-model，
    您需要自行设计可综合co-sim的设计。  

2. 项目要求

    在设计完成后，
    您可以使用我们提供的`filter2d_test.cpp`文件进行基本功能测试。

    **项目最终需要在pynq-z2板卡上通过上板测试。**

3. 函数原型

    ```c++
    void filter2d_accel(DTYPE* img_in, DTYPE* kernel, DTYPE* img_out, int rows, int cols)
    ```
    - `img_in`: 图像输入
    - `img_out`: 图像输出
    - `kernel`: 卷积核
    - `rows`: 图像长度（行数）
    - `cols`: 图像宽度（列数）

    **其中kernel为任意3*3卷积核，并统一不做padding。**
    
    在本项目中，输入的图像已经被转化为了一个大小为![](https://render.githubusercontent.com/render/math?math=128\times128)的一维数组。
    输入矩阵是按行展开的。
    
