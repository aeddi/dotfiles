#! /bin/sh

format_subscript()
{
	awk -v WIDTH=75 '
	{
		gsub(/\t/, "   ");
		while (length>WIDTH) {
			print "   | " substr($0,1,WIDTH);
			$0=substr($0,WIDTH+1);
		}
		print "   | " $0;
		fflush();
	}'
}

echo $@ | format_subscript
