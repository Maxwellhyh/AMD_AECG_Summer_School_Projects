## Repository Tree
```
.
├── canny.cpp         //源码框架
├── canny.hpp         //头文件
├── canny_test.cpp    //测试源码
├── src.txt           //测试输入
├── dst.txt           //标准输出
├── tcl_script.tcl    //tcl文件
└── README.md         //说明文件
```
## Canny （最近一次更新：8月4日）

1. 框架代码说明

    框架代码是算法的C-model，
    您需要自行设计可综合co-sim的设计。  

2. 项目要求

    在设计完成后，
    您可以使用我们提供的`canny_test.cpp`文件进行基本功能测试。
    
    **项目最终需要在pynq-z2板卡上通过上板测试。**
		
3. 算法说明

    Canny边缘检测器是一种边缘检测算子，
    它使用多阶段算法检测图像中的边缘。

4. 函数原型

    ```c++
    void canny(DTYPE* src, DTYPE* dst, int upperThresh, int lowerThresh);
    ```
    - `src`: 图像输入
    - `dst`: 图像输出
    - `upperThresh`: 高阈值
    - `lowerThresh`: 低阈值

    在本项目中，输入的图像已经被转化为了一个大小为![](https://render.githubusercontent.com/render/math?math=128\times128)的一维数组。
    输入矩阵是按行展开的。
    输出矩阵是算法得到的k个边缘点在图像中的位置。
    如果该位置是强边缘点，则该位置的值为255；如果该位置是弱边缘点，则该位置的值为127；如果不是，则该位置的值为0。
    例如，算法得到的一张![](https://render.githubusercontent.com/render/math?math=4\times4)大小图像的强边缘点坐标为![](https://render.githubusercontent.com/render/math?math=(0,1))和![](https://render.githubusercontent.com/render/math?math=(2,3))，那么dst应为

    <div align="center">
    <img src="https://render.githubusercontent.com/render/math?math=\huge%20\begin{matrix}%200%26255%260%260\\0%260%260%260\\0%260%260%26255\\0%260%260%260\end{matrix}">
    </div>

    分16行输出：
    <div align="center">
    <img src="https://render.githubusercontent.com/render/math?math=\huge%20\begin{matrix}%200%26255%260%260%260%260%260%260%260%260%260%26255%260%260%260%260\end{matrix}">
    </div>

    **本题若最终输出与标准输出不一致的点数不大于64个，则视为通过测试。**
    
    **在使用滤波器前一律进行opencv的BORDER_DEFAULT填充，使得滤波后的图像和滤波前大小一致。**

    关于canny算法本身，以下为算法4个主要步骤的大致介绍：

    1.使用![](https://render.githubusercontent.com/render/math?math=3\times3)的高斯滤波来平滑图像，标准差![](https://render.githubusercontent.com/render/math?math=\sigma)=1.5。

    2.使用![](https://render.githubusercontent.com/render/math?math=3\times3)的Sobel滤波器找寻图像的梯度强度。

    Sobel的X方向和Y方向上的算子![](https://render.githubusercontent.com/render/math?math=I_x)和![](https://render.githubusercontent.com/render/math?math=I_y)分别为：
    <div align="center">
    <img src="https://render.githubusercontent.com/render/math?math=\huge%20I_x=\begin{bmatrix}-1%260%26%2B1\\-2%260%26%2B2\\-1%260%26%2B1\end{bmatrix},">
    <img src="https://render.githubusercontent.com/render/math?math=\huge%20I_y=\begin{bmatrix}-1%26-2%26-1\\0%260%260\\%2B1%26%2B2%26%2B1\end{bmatrix}">
    </div>

    则图像某点X方向梯度![](https://render.githubusercontent.com/render/math?math=G_x)、Y方向梯度![](https://render.githubusercontent.com/render/math?math=G_y)和梯度强度![](https://render.githubusercontent.com/render/math?math=G)之间满足
    
    <div align="center">
    <img src="https://render.githubusercontent.com/render/math?math=\huge%20G=\sqrt{G_x^2%2BG_y^2}">
    </div>
    
    上式中平方为对应元素相乘，不是矩阵乘法。
    
    此外，计算梯度方向![](https://render.githubusercontent.com/render/math?math=a)：
    
    <div align="center">
    <img src="https://render.githubusercontent.com/render/math?math=\huge%20a=arctan{\frac{G_y}{G_x}}">
    </div>
    
    3.对梯度强度![](https://render.githubusercontent.com/render/math?math=G)在![](https://render.githubusercontent.com/render/math?math=3\times3)范围内进行非最大值抑制。
    
    如果梯度方向大于22.5度小于等于67.5度，则比较像素的左上和右下的像素；
    如果梯度方向大于67.5度小于等于112.5度，则比较像素的上边和下边的像素；
    如果梯度方向大于112.5度小于等于157.5度，则比较像素的右上和左下的像素；
    如果梯度方向大于-22.5度小于等于22.5度，则比较像素的左边和右边的像素。
    若该像素不大于这两个像素之中的任何一个，则该点被抑制。

    4.使用双阈值法对梯度强度![](https://render.githubusercontent.com/render/math?math=G)进行边界求解，其中高阈值取80，低阈值取30。如果边缘像素的梯度值**大于等于**高阈值，则将其标记为强边缘像素，赋值255；如果边缘像素的梯度值**小于**高阈值并且**大于**低阈值，则将其标记为弱边缘像素，赋值127；其余像素赋值0。
