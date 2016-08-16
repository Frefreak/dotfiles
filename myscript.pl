# myscript.pl

use strict;
use Irssi;

our $VERSION = '0.1';
our %IRSSI = (
    authors     => 'Xiangyu Zhu',
    contact     => 'frefreak.zxy@gmail.com',
    name        => 'myscript',
    description => 'load script helper',
    license     => 'GPLv2',
    url         => 'http://irssi.org/scripts/',
    modules     => 'scriptassist',
    commands	=> "myscript"
);

if (defined $ENV{TMUX}) {
	Irssi::command('script load ' . 'tmux-nicklist-portable.pl');
} else {
	print CLIENTCRAP '%R!%G!%B! %W%9%FNot under tmux!%n';
}

# .irssi/script structure
# .
# ├── autorun
# │   ├── myscript.pl -> ../myscript.pl
# │   ├── nickcolor_expando.pl -> ../nickcolor_expando.pl
# │   ├── nm2.pl -> ../nm2.pl
# │   ├── scriptassist.pl -> ../scriptassist.pl
# │   ├── smartfilter.pl -> ../smartfilter.pl
# │   ├── trackbar.pl -> ../trackbar.pl
# │   ├── uberprompt.pl -> ../uberprompt.pl
# │   └── vim_mode.pl -> ../vim_mode.pl
# ├── myscript.pl
# ├── nickcolor_expando.pl
# ├── nm2.pl
# ├── old
# ├── scriptassist.pl
# ├── smartfilter.pl
# ├── tmux-nicklist-portable.pl
# ├── trackbar.pl
# ├── uberprompt.pl
# └── vim_mode.pl
# 
# 2 directories, 17 files
