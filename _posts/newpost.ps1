$date = get-date -format yyyy/MM/dd
$time = get-date -format HH:mm:ss
$filename = $date + "-" + $args[0] + ".markdown"
New-Item $filename
echo --- >> $filename
echo layout:' 'default >> $filename
echo title: >> $filename
echo $date' '$time >> $filename
echo tag: >> $filename
echo --- >> $filename