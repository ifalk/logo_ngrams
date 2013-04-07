#!/usr/bin/perl
# -*- mode: perl; buffer-file-coding-system: utf-8 -*-
# make_3grams.pl                   falk@lormoral
#                    05 Apr 2013

use warnings;
use strict;
use English;

use Data::Dumper;
use Carp;
use Carp::Assert;

use Pod::Usage;
use Getopt::Long;

use utf8;

=head1 NAME

make_3grams.pl

=head1 USAGE

  perl make_3grams.pl text file containing words (one per line)

=head1 DESCRIPTION

Builds a 3gram (character) distribution from a collection of words given as input.

=head1 REQUIRED ARGUMENTS

Text file of words (one per line) to build ngrams from.

=head1 OPTIONS

=over 2

=item n 

Width of character window.

=back

=cut


my %opts = (
  'n' => 3,
  'csv_out' => '',
  );

my @optkeys = (
  'n:i',
  'csv_out:s',
  );

unless (GetOptions (\%opts, @optkeys)) { pod2usage(2); };
unless (@ARGV) { pod2usage(2) };


print STDERR "Options:\n";
print STDERR Dumper(\%opts);

use Text::Ngram qw(ngram_counts add_to_counts);

my $ngrams;


my %config = (
  flankbreaks => 0,
  lowercase => 0,
  punctuation => 1,
  spaces => 0,
);


open (my $fh, '<:encoding(utf8)', $ARGV[0]) or die "Couldn't open $ARGV[0] for input: $!\n";

my @words = <$fh>;
my $text = join('^ $', @words);
$text = join('', '^', $text, '$');
$ngrams = ngram_counts($text, $opts{n}, %config);

use List::Util qw(max);

print STDERR "Max ngram count: ", max(values %{ $ngrams }), "\n";
print STDERR "Number of ngrams: ", scalar(keys %{ $ngrams }), "\n";

print Dumper($ngrams);

close $fh;

if ($opts{csv_out}) {
  if (open($fh, '>:encoding(utf-8)', $opts{csv_out})) {
    print $fh "trig,count\n";
    while (my ($trig, $count) = each %{ $ngrams }) {
      print $fh join(',', $trig, $count), "\n";
    }
    close $fh;
  } else {
    warn "Couldn't open $opts{csv_out} for output: $!\n";
  }
}

1;





__END__

=head1 EXIT STATUS

=head1 CONFIGURATION

=head1 DEPENDENCIES

=head1 INCOMPATIBILITIES

=head1 BUGS AND LIMITATIONS

created by template.el.

It looks like the author of this script was negligent
enough to leave the stub unedited.


=head1 AUTHOR

Ingrid Falk, E<lt>E<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2013 by Ingrid Falk

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.2 or,
at your option, any later version of Perl 5 you may have available.

=head1 BUGS

None reported... yet.

=cut
