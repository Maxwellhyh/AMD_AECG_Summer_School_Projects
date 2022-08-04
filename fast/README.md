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
## FAST （最近一次更新：4月29日）

1. 框架代码说明

    框架代码是算法的C-model，
    您需要自行设计可综合co-sim的设计。  
    但请注意：**您必须保持顶层函数不变。**

2. 项目要求

    在设计完成后，
    您可以使用我们提供的`fast_test.cpp`文件进行基本功能测试。
    但是，由于在评分时会统一使用评分系统内部的`fast_test.cpp`，
    因此请不要将设计写在`fast_test.cpp`中，
    `fast_test.cpp`文件也无需提交。
    **在HLS优化的过程中，请务必将优化指令设置为pragma写入c++代码中。**
    比赛不需要生成最终bit文件，仅考察算法实现功能和综合报告的性能，能完成co-sim即可。
		
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
    - `imag_sample`: 阈值
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

5. 提交程序

    您仅需提交cpp文件和h文件。
    请将除`fast_test.cpp`以外的所有cpp和h文件
    压缩为一个压缩包`fast.zip`，
    在页面下方您的解答处点击“**上传代码**”按钮进行提交，
    稍待片刻即可在文本框下方得知您的设计是否通过了基本功能测试。
    延迟、面积等性能指标则可在历史提交记录中点击版本号详细查看。
  
6. 评分规则

    - 如果最大频率![](https://render.githubusercontent.com/render/math?math=F_{max}<100\MHz)， 视为未通过基本功能

    - 如果最大频率![](https://render.githubusercontent.com/render/math?math=100\MHz%20\le%20F_{max}<300\MHz)，使用下列公式计算性能
      <div align="center">
      <img src="https://render.githubusercontent.com/render/math?math=\huge%20\frac{T_{clock}\times%20F_{max}}{\tau_{Simulation}}">
      </div>

    - 如果最大频率![](https://render.githubusercontent.com/render/math?math=F_{max}%20\ge%20300\MHz)，使用下列公式计算性能
      <div align="center">
      <img src="https://render.githubusercontent.com/render/math?math=\huge%20\frac{T_{clock}\times300\MHz}{\tau_{Simulation}}">
      </div>
    
    其中,
    ![](https://render.githubusercontent.com/render/math?math=F_{max})是设计的最高运行频率，
    ![](https://render.githubusercontent.com/render/math?math=T_{clock})是TCL中设定的时钟频率，
    ![](https://render.githubusercontent.com/render/math?math=\tau_{Simulation})是Vitis HLS软件Cosimulation所用时间。
    性能公式计算出的数值越大，性能越好。

    **注意：**
    设计的频率范围建议在100MHz和300MHz之间。
    如果频率低于100MHz，则未能满足最低性能指标，无法得到基本分10分；
    如果设计的最高运行频率高于300MHz，则在上方公式中也只会取300MHz作为最高频率。
