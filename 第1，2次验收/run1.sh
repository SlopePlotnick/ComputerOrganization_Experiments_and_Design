echo "开始编译"
iverilog -o wave ./counter.v tcounter.v
echo "编译完成"

echo "生成波形文件"
vvp -n wave -lxt2 
cp wave1.vcd wave1.lxt

echo "打开波形文件"
open wave1.vcd