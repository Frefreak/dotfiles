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
our $username = "c4r50nz";
sub msgPublic {
    my ($server, $msg, $nick, $address, $target) = @_;
    if ($msg =~ $username) {
	system("kdialog --title " . "\"Irssi: You have been mentioned!\"" .
		" --passivepopup \"" . $msg . "\" 5");
    }
}
sub msgPrivate {
    my ($server, $msg, $nick, $address) = @_;
    system("kdialog --title " . "\"Irssi: You have a private message!\"" .
		" --passivepopup \"" . $nick . " @ " . $address . "\" 5");
}

Irssi::signal_add('message public', 'msgPublic');
Irssi::signal_add('message private', 'msgPrivate');

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
