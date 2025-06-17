#!/bin/bash

echo "==========================="
echo " Statistik Performa Server "
echo "==========================="
echo ""

echo " Total Penggunaan CPU "
cpu_usage=$(top -b -n 1 | grep "Cpu(s)" | awk '{print 100 - $8}')
echo " CPU Usage : ${cpu_usage}%"
echo ""

echo " Total Penggunaan Memori "
free -h | grep "Mem:"
# Menghitung persentase penggunaan memori
mem_info=$(free -m | grep "Mem:")
mem_used=$(echo "$mem_info" | awk '{print $3}')
mem_total=$(echo "$mem_info" | awk '{print $2}')
mem_percent=$(awk "BEGIN {printf \"%.2f\", ($mem_used/$mem_total)*100}")
echo "   Persentase Digunakan: ${mem_percent}%"
echo ""


# Total Penggunaan Disk
echo "=> Total Penggunaan Disk:"
df -h --total | grep 'total' # Opsi --total memberikan ringkasan
echo ""

#5 Proses teratas berdasarkan CPU
echo "=> 5 Proses Teratas (Berdasarkan CPU):"
# ps: tampilkan proses
# -eo: format output custom
# pcpu: persentase CPU
# --sort=-pcpu: urutkan berdasarkan penggunaan CPU (dari tertinggi)
# head -n 6: ambil 5 baris teratas + 1 baris header
ps -eo pcpu,pid,user,args --sort=-pcpu | head -n 6
echo ""

# 5 Proses Teratas berdasarkan Memori
echo "=> 5 Proses Teratas (Berdasarkan Memori):"
# pmem: persentase memori
# --sort=-pmem: urutkan berdasarkan penggunaan memori (dari tertinggi)
ps -eo pmem,pid,user,args --sort=-pmem | head -n 6
echo ""

