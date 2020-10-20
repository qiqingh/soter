	wc -c "$1" | while read image_size _n ; do echo $image_size ; break; done
