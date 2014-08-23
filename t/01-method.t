#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;
use KyotoCorpusHandler;

plan tests => 1;

my $handler = KyotoCorpusHandler->new;
isa_ok $handler, "KyotoCorpusHandler";
