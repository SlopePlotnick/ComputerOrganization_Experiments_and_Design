echo "开始编译"
iverilog -o wave ./counter16.v tcounter16.v
echo "编译完成"

echo "生成波形文件"
vvp -n wave -lxt2 
cp wave2.vcd wave2.lxt

echo "打开波形文件"
open wave2.vcd