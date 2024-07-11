function pandoc_html
	set fst $argv[1]
	set basename (string split -m1 -r . $fst | head -n1)
	set rem_args $argv[2..-1]
	pandoc --embed-resources --standalone  \
		--css $HOME/files/gh-pandoc.css \
		--mathjax -f markdown -t html \
		"$fst" -o $basename.html $rem_args
end

