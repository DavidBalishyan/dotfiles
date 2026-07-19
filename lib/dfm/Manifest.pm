package dfm::Manifest;

use strict;
use warnings;
use Exporter 'import';

our @EXPORT_OK = qw(parse_manifest);

sub parse_manifest {
    my ($file) = @_;
    open my $fh, '<', $file or die "Cannot open manifest: $file: $!\n";

    my %components;
    my $current = undef;

    while (my $line = <$fh>) {
        chomp $line;
        $line =~ s/^\s+//;
        $line =~ s/\s+$//;

        next if $line =~ /^#/ || $line eq '';

        if ($line =~ /^\[(.+)\]$/) {
            $current = $1;
            $components{$current} = {
                name        => $current,
                desc        => '',
                packages    => {},
                sources     => [],
                hook_install   => [],
                hook_uninstall => [],
                condition  => '',
            };
            next;
        }

        next unless defined $current;

        if ($line =~ /^desc\s*=\s*(.+)$/) {
            $components{$current}{desc} = $1;
        }
        elsif ($line =~ /^packages\.(\S+)\s*=\s*(.+)$/) {
            my ($pm, $pkgs) = ($1, $2);
            my @list = split /\s+/, $pkgs;
            $components{$current}{packages}{$pm} = \@list if @list;
        }
        elsif ($line =~ /^source\s*=\s*(.+)$/) {
            push @{$components{$current}{sources}}, parse_source($1);
        }
        elsif ($line =~ /^hook\.install\s*=\s*(.+)$/) {
            push @{$components{$current}{hook_install}}, split /\s+/, $1;
        }
        elsif ($line =~ /^hook\.uninstall\s*=\s*(.+)$/) {
            push @{$components{$current}{hook_uninstall}}, split /\s+/, $1;
        }
        elsif ($line =~ /^condition\s*=\s*(.+)$/) {
            $components{$current}{condition} = $1;
        }
    }

    close $fh;
    return \%components;
}

sub parse_source {
    my ($str) = @_;
    $str =~ s/^\s+//;
    $str =~ s/\s+$//;

    if ($str =~ /^(.+?)\s*->\s*(.+)$/) {
        return { source => $1, target => $2 };
    }
    die "Invalid source mapping: $str (expected 'source -> target')\n";
}

1;
