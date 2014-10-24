package Data::Sah::Object::Schema;

our $DATE = '2014-07-28'; # DATE
our $VERSION = '0.01'; # VERSION

use 5.010;
use strict;
use warnings;

sub new {
    my ($class, $sch, $is_normalized) = @_;
    $sch //= [undef, {}, {}];

    unless ($is_normalized) {
        require Data::Sah::Normalize;
        $sch = Data::Sah::Normalize::normalize_schema($sch);
    }

    my $obj = \$sch;
    bless $obj, $class;
}

sub type {
    my $self = shift;
    if (@_) {
        my $old = ${$self}->[0];
        ${$self}->[0] = $_[0];
        return $old;
    } else {
        return ${$self}->[0];
    }
}

sub clause {
    my $self = shift;
    my $name = shift;
    if (@_) {
        my $old = ${$self}->[1]{$name};
        ${$self}->[1]{$name} = $_[0];
        return $old;
    } else {
        return ${$self}->[1]{$name};
    }
}

sub req {
    my $self = shift;
    if (@_) {
        my $old = ${$self}->[1]{req};
        ${$self}->[1]{req} = $_[0];
        return $old;
    } else {
        return ${$self}->[1]{req};
    }
}

sub delete_clause {
    my $self = shift;
    my $name = shift;
    my $old = ${$self}->[1]{$name};
    delete ${$self}->[1]{$name};
    return $old;
}

sub as_struct {
    my $self = shift;
    ${$self};
}

1;
# ABSTRACT: Represent Sah schema

__END__

=pod

=encoding UTF-8

=head1 NAME

Data::Sah::Object::Schema - Represent Sah schema

=head1 VERSION

This document describes version 0.01 of Data::Sah::Object::Schema (from Perl distribution Data-Sah-Object), released on 2014-07-28.

=head1 METHODS

=head2 new($sch, $is_normalized) => obj

Constructor. Will create a normalized copy of C<$sch>, unless C<$is_normalized>
is true, in which case won't create a copy.

=head2 type([ $value ]) => str

Get or set type. If set, will return the old value.

=head2 clause($name[, $value]) => any

Get or set a clause. If set, will return the old value.

=head2 req([ $value ]) => bool

Shortcut for C<< $osch->clause('req'[, $value ]) >>.

=head2 delete_clause($name) => any

Delete clause named C<$name>. Return the old value.

=head2 as_struct => array

Return the schema raw data structure.

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Data-Sah-Object>.

=head1 SOURCE

Source repository is at L<https://github.com/sharyanto/perl-Data-Sah-Object>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Data-Sah-Object>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
