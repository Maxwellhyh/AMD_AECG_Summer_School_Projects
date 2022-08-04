## Repository Tree
```
.
├── dft.cpp              //源码框架
├── dft.h                //头文件
├── dft_test.cpp         //测试源码
├── coefficients1024.h   //系数文件
├── out.gold.dat         //标准输出
├── tcl_script.tcl       //tcl文件
└── README.md            //说明文件
```
## DFT （最近一次更新：8月4日）

1. 框架代码说明

    框架代码是算法的C-model，
    您需要自行设计可综合co-sim的设计。  
    
2. 项目要求

    在设计完成后，
    您可以使用我们提供的`dft_test.cpp`文件进行基本功能测试。
    
    **项目最终需要在pynq-z2板卡上通过上板测试。**

3. 函数原型

    ```c++
    void dft(DTYPE real_sample[SIZE], DTYPE imag_sample[SIZE], DTYPE real_op[SIZE], DTYPE imag_op[SIZE])
    ```
    - `SIZE`(![](https://render.githubusercontent.com/render/math?math=N)): 信号总数目
    - `real_sample`(![](https://render.githubusercontent.com/render/math?math=\mathfrak{Re}(z_i))): 输入信号（列向量）的实部
    - `imag_sample`(![](https://render.githubusercontent.com/render/math?math=\mathfrak{Im}(z_i))): 输入信号（列向量）的虚部
    - `real_op`(![](https://render.githubusercontent.com/render/math?math=\mathfrak{Re}(z_o))): DFT信号处理结果（列向量）的实部
    - `imag_op`(![](https://render.githubusercontent.com/render/math?math=\mathfrak{Im}(z_o))): DFT信号处理结果（列向量）的虚部

    其中，
    ![](https://render.githubusercontent.com/render/math?math=z_i)是输入复数信号, ![](https://render.githubusercontent.com/render/math?math=z_o)是输出复数信号
    ![](https://render.githubusercontent.com/render/math?math=\mathfrak{Re}(z))表示取复数实部, ![](https://render.githubusercontent.com/render/math?math=\mathfrak{Im}(z))表示取复数虚部
    有
    <div align="center">
    <img src="https://render.githubusercontent.com/render/math?math=\huge%20z_o=S%20\times%20z_i">
    </div>

    ![](https://render.githubusercontent.com/render/math?math=S)为DFT操作的复数系数矩阵，其上元素![](https://render.githubusercontent.com/render/math?math=s_{i,j})满足（注意是顺时针旋转）

    <div align="center">
    <img src="https://render.githubusercontent.com/render/math?math=\huge%20s_{i,j}=\cos(2\pi\frac{i%20\cdot%20j}{N})-\mathbb{i}\cdot\sin(2\pi\frac{i%20\cdot%20j}{N})">
    </div>
