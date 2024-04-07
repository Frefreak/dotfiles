function uniq-no-sort
    perl -ne 'print unless $seen{$_}++'
end
