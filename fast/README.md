## Repository Tree
```
.
├── fast.cpp         //源码框架
├── fast.h           //头文件
├── fast_test.cpp    //测试源码
├── src.txt          //测试输入
├── dst.txt          //标准输出
├── tcl_script.tcl   //tcl文件
└── README.md        //说明文件
```
## FAST （最近一次更新：8月4日）

1. 框架代码说明

    框架代码是算法的C-model，
    您需要自行设计可综合co-sim的设计。  

2. 项目要求

    在设计完成后，
    您可以使用我们提供的`fast_test.cpp`文件进行基本功能测试。

    **项目最终需要在pynq-z2板卡上通过上板测试。**
		
3. 算法说明

    特征加速分割测试(Featuresfrom Accelerated Segment Test, FAST)是一种角点检测方法，
    可用于提取特征点，并用于许多计算机视觉任务中的目标跟踪。
    FAST角点检测器使用一个16像素的圆(半径为3的Bresenham圆)来区分候选点是否为角点。

4. 函数原型

    ```c++
    void fast_accel(DTYPE* img_in, int threshold, DTYPE* img_out, int rows, int cols)
    ```
    - `img_in`: 图像输入
    - `img_out`: 图像输出
    - `threshold`: 阈值
    - `rows`: 图像长度（行数）
    - `cols`: 图像宽度（列数）

    在本项目中，输入的图像已经被转化为了一个大小为![](https://render.githubusercontent.com/render/math?math=128\times128)的一维数组。
    输入矩阵是按行展开的。
    输出矩阵是算法得到的k个特征点在图像中的位置。
    如果该位置是特征点，则该位置的值为255；如果不是，则该位置的值为0。
    例如，算法得到的一张![](https://render.githubusercontent.com/render/math?math=4\times4)大小图像的特征点坐标为![](https://render.githubusercontent.com/render/math?math=(0,1))和![](https://render.githubusercontent.com/render/math?math=(2,3))，那么dst应为

    <div align="center">
    <img src="https://render.githubusercontent.com/render/math?math=\huge%20\begin{matrix}%200%26255%260%260\\0%260%260%260\\0%260%260%26255\\0%260%260%260\end{matrix}">
    </div>

    分16行输出：
    <div align="center">
    <img src="https://render.githubusercontent.com/render/math?math=\huge%20\begin{matrix}%200%26255%260%260%260%260%260%260%260%260%260%26255%260%260%260%260\end{matrix}">
    </div>
  
    关于fast算法本身，threshold取20，
    判断条件为严格大于threshold，不做padding以及极大值抑制。
    对于除图像边缘外的每一个像素，
    先判断该像素的上下左右的1号、5号、9号、13号（如图所示）
    这四个像素与该像素的像素差是否严格大于阈值，
    如果有三个及以上的像素大于阈值，
    则继续计算周围16个点与该像素的像素差（如图所示），
    若它们有至少12个超过阈值，则是特征点。

    <div align="center">
    <img src="https://github.com/xupsh/ccc/raw/main/problems/fast/images/fast.png">
    </div>

