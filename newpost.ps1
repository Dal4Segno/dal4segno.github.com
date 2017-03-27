$date = get-date -format yyyy-MM-dd
$time = get-date -format HH:mm:ss
$filename = ".\_posts\" + $date + "-" + $args[0] + ".markdown"
New-Item $filename
echo --- >> $filename
echo layout:' 'post >> $filename
echo title: >> $filename
echo date: $date' '$time >> $filename
echo tag: >> $filename
echo categories: >> $filename
echo excerpt: >> $filename
echo --- >> $filename
echo "{% include _toc.html %}" >> $filename