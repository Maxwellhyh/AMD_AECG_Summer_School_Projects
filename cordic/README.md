## Repository Tree

```
.
├── cordiccart2pol.cpp        //源码框架
├── cordiccart2pol.h          //头文件
├── cordiccart2pol_test.cpp   //测试源码
├── tcl_script.tcl            //tcl文件
└── README.md                 //说明文件
```

## CORDIC （最近一次更新：8月4日）

1. 框架代码说明

    框架代码是算法的C-model，
    您需要自行设计可综合co-sim的设计。  

2. 项目要求
 
    在设计完成后，
    您可以使用我们提供的 `cordiccart2pol_test.cpp` 文件进行基本功能测试。
    
    项目最终需要在pynq-z2板卡上通过上板测试。

3. 算法说明

    CORDIC(用于坐标旋转数字计算机)是一种简单而有效的算法，
    用于计算三角函数、双曲函数、平方根、乘法、除法、指数和任意底数的对数。
    **本题选手们需完成坐标系变换的硬件实现。**

4. 函数原型

    ```c++
    void cordiccart2pol(data_t x, data_t y, data_t *r, data_t *theta)
    ```

    - `x`: 直角坐标系X坐标值
    - `y`: 直角坐标系Y坐标值
    - `r`: 极坐标半径
    - `theta`(![](https://render.githubusercontent.com/render/math?math=\theta)): 极坐标角度（与X轴正方向夹角）

    其中，
    <div align="center">
    <img src="https://render.githubusercontent.com/render/math?math=\huge%20r=\sqrt{x^2%2By^2}">
    </div>

    而

    <div align="center">
    <img src="https://render.githubusercontent.com/render/math?math=\huge%20\theta=\arctan{\frac{y}{x}}">
    </div>
