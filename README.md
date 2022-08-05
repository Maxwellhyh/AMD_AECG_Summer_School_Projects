# AMD_AECG_Summer_School_Projects

Easy: cordic, filter2d

Medium: fast, DFT

Hard: canny

## HLS 任务
使用 HLS 设计和验证功能完整的IP内核。我们为您提供了一个可以使用的测试文件<*>_test.cpp，尽管该测试文件并未涵盖所有情况。我们鼓励您创建一个更广泛的测试平台，以确保您的代码是正确的。

建议：

首先您可以使用浮点变量设计baseline。在有一个功能正确的设计后，您可以开始试验任意精度的数据类型。您可以使用新的 typedef定义变量的数据类型。使用大而复杂的数据类型（如浮点）通常是最准确的，但在性能和资源使用方面并不好。定点类型提供更好的性能和资源使用，但可能会降低结果的准确性。

## PYNQ 演示任务
您需要使用 PYNQ 将IP内核集成到可编程逻辑 (PL) 上。您需要自己设计Jupyter Notebook代码。Notebook代码应将数据传递给IP，启动进程，读取结果，并将其与 Python 中计算的结果进行比较。

在Notebook中您也可以进行创新，例如结合自己的研究方向搭建自己的应用等。
