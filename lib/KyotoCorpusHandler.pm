package KyotoCorpusHandler;

use 5.006;
use strict;
use warnings FATAL => 'all';
use utf8;

=head1 NAME

KyotoCorpusHandler - The great new KyotoCorpusHandler!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use KyotoCorpusHandler;

    my $foo = KyotoCorpusHandler->new();
    ...

=cut

sub new {
    my ($self, %args) = @_;
    bless \%args, $self;
}

sub extract_substantive {
    my ($self, $buf, $option) = @_;
    my @substantives = ();
    foreach my $line (split /\n/, $buf) {
	next if $line =~ /^[#\*\+]/ || $line eq "EOS";
	my ($midashi, $yomi, $genkei, $hinshi, $bunrui, $bunrui2, $katsuyou, @rest) = split /\s/, $line;
	if ($self->_is_noun($hinshi, $bunrui, $option)) {
	    push @substantives, $midashi;
	}
	# e.g. 明確に めいかくに 明確だ 形容詞 * ナ形容詞 ダ列基本連用形
	elsif ($hinshi eq "形容詞" && $bunrui2 eq "ナ形容詞") {
	    # e.g. 不確定だ ふかくていだ * 形容詞 * ナ形容詞 基本形
	    push @substantives, $1 if ($genkei =~ /(.+?)だ$/);
	}
	elsif ($bunrui2 eq "ナノ形容詞") {
	    # e.g. 必要だ ひつようだ * 形容詞 * ナノ形容詞 基本形
	    push @substantives, $1 if ($genkei =~ /(.+?)だ$/);
	}
    }
    @substantives;
}

sub _is_noun {
    my ($self, $hinshi, $bunrui, $option) = @_;
    if ($option->{"extracted_noun"}) {
	$option->{"extracted_noun"}{$bunrui};
    } else {
	$hinshi eq "名詞";
    }
}

=head1 AUTHOR

jun-harashima, C<< <j.harashima at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-kyotocorpushandler at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=KyotoCorpusHandler>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc KyotoCorpusHandler


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=KyotoCorpusHandler>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/KyotoCorpusHandler>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/KyotoCorpusHandler>

=item * Search CPAN

L<http://search.cpan.org/dist/KyotoCorpusHandler/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2014 jun-harashima.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut

1; # End of KyotoCorpusHandler
